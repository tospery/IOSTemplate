//
//  LoginReducer.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/11/17.
//

import Foundation
import ComposableArchitecture
import HiBase
import HiCore
import HiNav
import HiSwiftUI
import Domain
import HiLog

@Reducer
struct LoginReducer {
    
    @ObservableState
    struct State: Equatable {
        @Shared(.preference) var preference = .default
        var route = RouteReducer.State.init()
        var personalToken = ""
        var authCode: String?
        var authToken: AccessToken?
        var error: HiError?
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case route(RouteReducer.Action)
        case oauth
        case login
        case personalToken(String)
        case user(Result<User, Error>)
        case authCode(Result<String, Error>)
        case authToken(Result<AccessToken, Error>)
    }
    
    @Dependency(\.dismiss) var dismiss
    @Dependency(\.applicationClient) var application
    @Dependency(\.continuousClock) var clock
    @Dependency(\.platformClient) var platformClient
    @Dependency(\.authorizationClient) var authorizationClient
    
    private enum CancelID { case oauth, login, user, authCode }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Scope(state: \.route, action: \.route) { RouteReducer.init() }
        Reduce { state, action in
            switch action {
            case .oauth:
                return .run { send in
                    await send(.route(.target(HiNav.shared.toastActivityDeepLink(true))))
                    let codeResult = await self.authorizationClient
                        .oauthCode(AuthorizationPresentationContextProvider.init())
                    await send(.authCode(codeResult))
                    guard let code = try? codeResult.get(), code.isNotEmpty else { return }
                    let tokenResult = await self.platformClient.network().accessTokenService()
                        .accessToken(code: code).asResult()
                    await send(.authToken(tokenResult))
                    guard let token = try? tokenResult.get().id, token.isNotEmpty else { return }
                    let userResult = await self.platformClient.network().userService()
                        .login(token: token).asResult()
                    await send(.user(userResult))
                }.cancellable(id: CancelID.oauth)
            case .login:
                let token = state.personalToken
                guard token.isNotEmpty else { return .none }
                state.authToken = .init(id: token)
                return .run { [token] send in
                    await send(.route(.target(HiNav.shared.toastActivityDeepLink(true))))
                    let userResult = await self.platformClient.network().userService()
                        .login(token: token).asResult()
                    await send(.user(userResult))
                    await send(.route(.target(HiNav.shared.toastActivityDeepLink(false))))
                }.cancellable(id: CancelID.login)
            case let .personalToken(personalToken):
                state.personalToken = personalToken
                return .none
            case let .authCode(.success(authCode)):
                state.authCode = authCode
                return .none
            case let .authToken(.success(authToken)):
                state.authToken = authToken
                return .none
            case let .user(.success(user)):
                var preference = state.preference
                preference.user = user
                preference.accessToken = state.authToken
                // state.preference = preference // YJX_TODO
                let userid = user.id
                let username = user.username ?? ""
                let nickname = user.nickname ?? ""
                let email = user.email ?? ""
                stats(.userLoginSuccess(
                    userid: userid, username: username, nickname: nickname, email: email
                ))
                return .run { _ in
                    await dismiss()
                }.cancellable(id: CancelID.user)
            case let .authCode(.failure(error)),
                let .authToken(.failure(error)),
                let .user(.failure(error)):
                state.error = error.asHiError
                return .run { send in
                    await send(.route(.target(
                        HiNav.shared.toastMessageDeepLink(error.asHiError.localizedDescription)
                    )))
                }.cancellable(id: CancelID.authCode)
            default:
                return .none
            }
        }
    }
}
