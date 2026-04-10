//
//  LoginReducer.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/4/7.
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
        var route = AppRouteReducer.State.init()
        var isSecure = true
        var isAgree = false
        var account = ""
        var password = ""
        var login: Login?
        var error: HiError?
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case route(AppRouteReducer.Action)
        case load
        case login
        case account(String?)
        case password(String?)
        case user(Result<User, Error>)
        case loginResponse(Result<Login, Error>)
    }
    
    @Dependency(\.dismiss) var dismiss
    @Dependency(\.openURL) var application
    @Dependency(\.continuousClock) var clock
    @Dependency(\.platformClient) var platformClient
    
    private enum CancelID { case login, user, authCode }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Scope(state: \.route, action: \.route) { AppRouteReducer.init() }
        Reduce { state, action in
            switch action {
            case .load:
                log("屏幕高度；\(screenHeight)")
                log("屏幕高度；\(statusBarHeightConstant)")
                log("屏幕高度；\(navigationContentTopConstant)")
                return .none
//            case .oauth:
//                return .run { send in
//                    await send(.route(.target(HiNav.shared.toastActivityDeepLink(true))))
//                    let codeResult = await self.authorizationClient
//                        .oauthCode(AuthorizationPresentationContextProvider.init())
//                    await send(.authCode(codeResult))
//                    guard let code = try? codeResult.get(), code.isNotEmpty else { return }
//                    let tokenResult = await self.platformClient.network().accessTokenService()
//                        .accessToken(code: code).asResult()
//                    await send(.authToken(tokenResult))
//                    guard let token = try? tokenResult.get().id, token.isNotEmpty else { return }
//                    let userResult = await self.platformClient.network().userService()
//                        .login(token: token).asResult()
//                    await send(.user(userResult))
//                }.cancellable(id: CancelID.oauth)
//            case .login:
//                let token = state.personalToken
//                guard token.isNotEmpty else { return .none }
//                state.authToken = .init(id: token)
//                return .run { [token] send in
//                    await send(.route(.target(HiNav.shared.toastActivityDeepLink(true))))
//                    let userResult = await self.platformClient.network().userService()
//                        .login(token: token).asResult()
//                    await send(.user(userResult))
//                    await send(.route(.target(HiNav.shared.toastActivityDeepLink(false))))
//                }.cancellable(id: CancelID.login)
//            case let .personalToken(personalToken):
//                state.personalToken = personalToken
//                return .none
//            case let .authCode(.success(authCode)):
//                state.authCode = authCode
//                return .none
//            case let .authToken(.success(authToken)):
//                state.authToken = authToken
//                return .none
//            case let .user(.success(user)):
//                var profile = state.profile
//                profile.user = user
//                profile.accessToken = state.authToken
//                state.profile = profile
//                let userid = user.id
//                let username = user.username ?? ""
//                let nickname = user.nickname ?? ""
//                let email = user.email ?? ""
//                stats(.userLoginSuccess(
//                    userid: userid, username: username, nickname: nickname, email: email
//                ))
//                return .run { _ in
//                    await dismiss()
//                }.cancellable(id: CancelID.user)
//            case let .authCode(.failure(error)),
//                let .authToken(.failure(error)),
//                let .user(.failure(error)):
//                state.error = error.asHiError
//                return .run { send in
//                    await send(.route(.target(
//                        HiNav.shared.toastMessageDeepLink(error.asHiError.localizedDescription)
//                    )))
//                }.cancellable(id: CancelID.authCode)
            default:
                return .none
            }
        }
    }
    
}
