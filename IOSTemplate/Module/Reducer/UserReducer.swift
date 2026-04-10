//
//  UserReducer.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/12/11.
//

import Foundation
import Combine
import ComposableArchitecture

import SwifterSwift
import HiBase
import HiCore
import HiNav
import HiSwiftUI
import Domain
import HiLog

@Reducer
struct UserReducer {
    
    @ObservableState
    struct State: Equatable {
        let url: String
        let parameters: [String: String]
        let owner: String
        var isLoading = true
        var isRefreshing = false
        var isFollowed: Bool?
        var milestone = ""
        var title = R.string.localizable.loading.localizedString
        var user: User?
        var error: HiError?
        var models = [AnyModel].init()
        @Shared(.preference) var preference = .default
        init(url: String) {
            self.url = url
            self.parameters = self.url.url?.queryParameters ?? [:]
            self.owner = self.parameters.string(for: Parameter.owner) ?? ""
            log("User页面的URL：\(self.url), owner=\(self.owner)")
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case load
        case refresh
        case target(String)
        case follow(Bool)
        case user(Result<User, Error>)
        case followed(Result<Bool, Error>)
        case milestone(Result<Any, Error>)
    }
    
    @Dependency(\.platformClient) var platformClient
    private enum CancelID { case load, refresh, follow }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .load:
                let owner = state.owner
                state.isLoading = true
                return .merge(
                    .run { send in
                        await send(.user(
                            await self.platformClient.network().userService().user(owner: owner).asResult()
                        ))
                        await send(.binding(.set(\.isLoading, false)))
                    },
                    .run { send in
                        let isFollowed = await self.platformClient.network().userService()
                            .checkFollowing(owner: owner)
                            .catch { _ in Just(false) }
                            .asOutput() ?? false
                        await send(.binding(.set(\.isFollowed, isFollowed)))
                    }
                ).cancellable(id: CancelID.load)
            case let .user(.success(user)):
                state.user = user
                state.title = user.type ?? ""
                var models = [AnyModel].init()
                models.append(AnyModel.init(user))
                if !user.isOrganization {
                    models.append(AnyModel.init(
                        user.copyWith(pageType: .milestone)
                            .copyWith(id: UUID().uuidString)
                    ))
                }
                models.append(AnyModel.init(
                    user.copyWith(pageType: .company)
                        .copyWith(id: UUID().uuidString)
                ))
                models.append(AnyModel.init(
                    Tile.init(
                        id: TileId.location.rawValue,
                        icon: TileId.location.icon,
                        title: user.locationWithDefault.1,
                        separated: true,
                        indicated: false,
                        autoLinked: false,
                        disabled: user.locationWithDefault.0
                    )
                ))
                models.append(AnyModel.init(
                    Tile.init(
                        id: TileId.email.rawValue,
                        icon: TileId.email.icon,
                        title: user.emailWithDefault.1,
                        separated: true,
                        indicated: !user.emailWithDefault.0,
                        autoLinked: false,
                        disabled: user.emailWithDefault.0,
                        target: user.email?.emailLink
                    )
                ))
                models.append(AnyModel.init(
                    Tile.init(
                        id: TileId.blog.rawValue,
                        icon: TileId.blog.icon,
                        title: user.blogWithDefault.1,
                        separated: false,
                        indicated: !user.blogWithDefault.0,
                        autoLinked: false,
                        disabled: user.blogWithDefault.0,
                        target: user.blog
                    )
                ))
                state.models = models
                return .run { send in
                    await send(.milestone(
                        await self.platformClient.network().dynamicService()
                            .file(urlString: user.milestone, baseString: UIApplication.shared.baseApiUrl)
                            .asResult()
                    ))
                }
            case let .milestone(.success(milestone)):
                guard let string = milestone as? String else { return .none }
                state.milestone = string
                return .none
            case let .follow(toFollow):
                let owner = state.owner
                return .run { send in
                    await send(.target(HiNav.shared.toastActivityDeepLink(true)))
                    if toFollow {
                        let result = await self.platformClient.network().userService().follow(owner: owner).asResult()
                        switch result {
                        case .success:
                            await send(.binding(.set(\.isFollowed, true)))
                            await send(.target(HiNav.shared.toastActivityDeepLink(false)))
                        case .failure(let error):
                            await send(.target(HiNav.shared.toastMessageDeepLink(
                                error.asHiError.localizedDescription
                            )))
                        }
                    } else {
                        let result = await self.platformClient.network().userService().unfollow(owner: owner).asResult()
                        switch result {
                        case .success:
                            await send(.binding(.set(\.isFollowed, false)))
                            await send(.target(HiNav.shared.toastActivityDeepLink(false)))
                        case .failure(let error):
                            await send(.target(HiNav.shared.toastMessageDeepLink(
                                error.asHiError.localizedDescription
                            )))
                        }
                    }
                }.cancellable(id: CancelID.follow)
            case let .user(.failure(error)):
                state.error = error.asHiError
                return .none
            default:
                return .none
            }
        }
    }
    
}
