//
//  ListReducer.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/3/4.
//

import Foundation
import ComposableArchitecture
import DependenciesAdditions
import SwifterSwift
import HiBase
import HiCore
import HiSwiftUI
import Domain
import HiLog

// swiftlint:disable type_body_length file_length
@Reducer
struct ListReducer<Model: ModelType> {
    
    @ObservableState
    struct State: Equatable {
        let url: String
        let parameters: [String: String]
        let owner: String
        let repo: String
        let host: String
        let page: PageType
        let pageStart: Int
        let pageSize: Int
        
        var isLoading = true
        var isRefreshing = false
        var isLoadingMore = false
        var noMoreData = false
        var shouldRefresh = false
        var shouldLoadMore = false
        var fromDatabase = false
        var pageIndex = UIApplication.shared.pageStart
        var models = [Model].init()
        var error: HiError?
        @Shared(.profile) var profile = .default
        
        init(url: String) {
            self.url = url
            self.parameters = self.url.url?.queryParameters ?? [:]
            self.host = self.url.routeHost
            self.page = self.parameters.enum(for: Parameter.page, type: PageType.self) ?? .none
            self.owner = self.parameters.string(for: Parameter.owner) ?? ""
            self.repo = self.parameters.string(for: Parameter.repo) ?? ""
            self.pageStart = self.parameters.int(for: Parameter.pageIndex)
                ?? UIApplication.shared.pageStart
            self.pageSize = self.parameters.int(for: Parameter.pageSize)
                ?? UIApplication.shared.pageSize
            self.shouldRefresh = self.parameters.bool(for: Parameter.shouldRefresh) ?? false
            self.shouldLoadMore = self.parameters.bool(for: Parameter.shouldLoadMore) ?? false
            self.pageIndex = self.pageStart
            // log("通用列表：host = \(self.host), page = \(self.page), owner = \(self.owner), repo = \(self.repo)")
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case load
        case refresh
        case loadMore
        case models(Result<[Model], Error>)
    }
    
    @Dependency(\.continuousClock) var clock
    @Dependency(\.platformClient) var platformClient
    private enum CancelID { case load, refresh, loadMore }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .load:
                return self.load(&state, action).cancellable(id: CancelID.load)
            case .refresh:
                return self.refresh(&state, action).cancellable(id: CancelID.refresh)
            case .loadMore:
                return self.loadMore(&state, action).cancellable(id: CancelID.loadMore)
            case let .models(.success(models)):
                return self.models(&state, action, models)
            case let .models(.failure(error)):
                return self.error(&state, action, error)
            default:
                return .none
            }
        }
    }
    
    func load(_ state: inout State, _ action: Action) -> Effect<Action> {
        state.isLoading = true
//        if state.host == .eventList {
//            return self.requestEventList(&state, action, .load)
//        }
//        if state.host == .favorite {
//            return self.requestFavorite(&state, action, .load)
//        }
//        if state.host == .userList {
//            return self.requestUserList(&state, action, .load)
//        }
//        if state.host == .repoList {
//            return self.requestRepoList(&state, action, .load)
//        }
//        if state.host == .issueList {
//            return self.requestIssueList(&state, action, .load)
//        }
//        if state.host == .pullList {
//            return self.requestPullList(&state, action, .load)
//        }
//        if state.host == .branchList {
//            return self.requestBranchList(&state, action, .load)
//        }
        return .none
    }
    
    func refresh(_ state: inout State, _ action: Action) -> Effect<Action> {
        state.isRefreshing = true
//        if state.host == .eventList {
//            return self.requestEventList(&state, action, .refresh)
//        }
//        if state.host == .favorite {
//            return self.requestFavorite(&state, action, .refresh)
//        }
//        if state.host == .userList {
//            return self.requestUserList(&state, action, .refresh)
//        }
//        if state.host == .repoList {
//            return self.requestRepoList(&state, action, .refresh)
//        }
//        if state.host == .issueList {
//            return self.requestIssueList(&state, action, .refresh)
//        }
//        if state.host == .pullList {
//            return self.requestPullList(&state, action, .refresh)
//        }
//        if state.host == .branchList {
//            return self.requestBranchList(&state, action, .refresh)
//        }
        return .none
    }
    
    func loadMore(_ state: inout State, _ action: Action) -> Effect<Action> {
        if state.noMoreData {
            return .none
        }
        state.isLoadingMore = true
//        if state.host == .eventList {
//            return self.requestEventList(&state, action, .loadMore)
//        }
//        if state.host == .favorite {
//            return self.requestFavorite(&state, action, .loadMore)
//        }
//        if state.host == .userList {
//            return self.requestUserList(&state, action, .loadMore)
//        }
//        if state.host == .repoList {
//            return self.requestRepoList(&state, action, .loadMore)
//        }
//        if state.host == .issueList {
//            return self.requestIssueList(&state, action, .loadMore)
//        }
//        if state.host == .pullList {
//            return self.requestPullList(&state, action, .loadMore)
//        }
//        if state.host == .branchList {
//            return self.requestBranchList(&state, action, .loadMore)
//        }
        return .none
    }
    
    // swiftlint:disable function_body_length
    func models(_ state: inout State, _ action: Action, _ models: [Model]) -> Effect<Action> {
        state.noMoreData = models.count < state.pageSize
        if state.isLoadingMore {
            var myModels = state.models
            myModels.append(contentsOf: models)
            state.models = myModels
        } else {
            state.models = models
        }
        state.error = nil
//        if state.fromDatabase {
//            if models.isEmpty {
//                return .none
//            } else {
//                log("加载数据库数据完成---\(state.host)")
//                state.isLoading = false
//            }
//        } else {
//            if !state.isLoadingMore && !models.isEmpty {
//                if state.host == .eventList {
//                    log("开始保存到数据库---事件")
//                    return .run { _ in
//                        _ = await self.platformClient.database().eventService()
//                            .save(events: unsafeBitCast(models, to: [Event].self))
//                            .asResult()
//                    }
//                }
//                if state.page == .stars {
//                    log("开始保存到数据库---收藏")
//                    return .run { _ in
//                        _ = await self.platformClient.database().repoService()
//                            .save(repos: unsafeBitCast(models, to: [Repo].self))
//                            .asResult()
//                    }
//                }
//                if state.page == .trendingRepos {
//                    log("开始保存到数据库---趋势repo")
//                    if models is [Repo] {
//                        return .run { _ in
//                            _ = await self.platformClient.database().repoService()
//                                .save(repos: unsafeBitCast(models, to: [Repo].self))
//                                .asResult()
//                        }
//                    }
//                }
//                if state.page == .trendingUsers {
//                    log("开始保存到数据库---趋势user")
//                    if models is [User] {
//                        return .run { _ in
//                            _ = await self.platformClient.database().userService()
//                                .save(users: unsafeBitCast(models, to: [User].self))
//                                .asResult()
//                        }
//                    }
//                }
//            }
//        }
        return .none
    }
    // swiftlint:enable function_body_length
    
    func error(_ state: inout State, _ action: Action, _ error: Error) -> Effect<Action> {
        if state.isLoading || state.isRefreshing {
            state.models = []
        }
        state.error = error.asHiError
        return .none
    }
    
    func requestEventList(_ state: inout State, _ action: Action, _ mode: HiRequestMode) -> Effect<Action> {
        let owner = state.owner.isEmpty ? (state.profile.user?.username ?? "") : state.owner
        let pageIndex = mode == .loadMore ? state.pageIndex : state.pageStart
        let pageSize = state.pageSize
        return .run { send in
            if mode == .load {
                await send(.binding(.set(\.fromDatabase, true)))
                await send(.models(
                    unsafeBitCast(
                        await self.platformClient.database().eventService()
                            .events(owner: owner, pageIndex: pageIndex, pageSize: pageSize)
                            .asResult(),
                        to: Result<[Model], Error>.self
                    )
                ))
                await send(.binding(.set(\.fromDatabase, false)))
            }
            await send(.models(
                unsafeBitCast(
                    await self.platformClient.network().eventService()
                        .events(owner: owner, pageIndex: pageIndex, pageSize: pageSize)
                        .asResult(),
                    to: Result<[Model], Error>.self
                )
            ))
            if mode == .refresh {
                await send(.binding(.set(\.isRefreshing, false)))
            } else if mode == .loadMore {
                await send(.binding(.set(\.isLoadingMore, false)))
            } else {
                await send(.binding(.set(\.isLoading, false)))
            }
            await send(.binding(.set(\.pageIndex, pageIndex + 1)))
        }
    }
    
    func requestFavorite(_ state: inout State, _ action: Action, _ mode: HiRequestMode) -> Effect<Action> {
        let owner = state.owner.isEmpty ? (state.profile.user?.username ?? "") : state.owner
        let pageIndex = mode == .loadMore ? state.pageIndex : state.pageStart
        let pageSize = state.pageSize
        return .run { send in
            if mode == .load {
                await send(.binding(.set(\.fromDatabase, true)))
                await send(.models(
                    unsafeBitCast(
                        await self.platformClient.database().repoService()
                            .starred(owner: owner, pageIndex: pageIndex, pageSize: pageSize)
                            .asResult(),
                        to: Result<[Model], Error>.self
                    )
                ))
                await send(.binding(.set(\.fromDatabase, false)))
            }
            await send(.models(
                unsafeBitCast(
                    await self.platformClient.network().repoService()
                        .starred(owner: owner, pageIndex: pageIndex, pageSize: pageSize)
                        .asResult(),
                    to: Result<[Model], Error>.self
                )
            ))
            if mode == .refresh {
                await send(.binding(.set(\.isRefreshing, false)))
            } else if mode == .loadMore {
                await send(.binding(.set(\.isLoadingMore, false)))
            } else {
                await send(.binding(.set(\.isLoading, false)))
            }
            await send(.binding(.set(\.pageIndex, pageIndex + 1)))
        }
    }
    
    // swiftlint:disable function_body_length
    func requestUserList(_ state: inout State, _ action: Action, _ mode: HiRequestMode) -> Effect<Action> {
        let owner = state.owner.isEmpty ? (state.profile.user?.username ?? "") : state.owner
        let repo = state.repo
        let pageIndex = mode == .loadMore ? state.pageIndex : state.pageStart
        let pageSize = state.pageSize
        if state.page == .trendingUsers {
            let language = state.profile.trendingLanguage
            let since = state.profile.trendingSince
            return .run { [language, since] send in
                if mode == .load {
                    await send(.binding(.set(\.fromDatabase, true)))
                    await send(.models(
                        unsafeBitCast(
                            await self.platformClient.database().userService()
                                .trending(language: language, since: since)
                                .asResult(),
                            to: Result<[Model], Error>.self
                        )
                    ))
                    await send(.binding(.set(\.fromDatabase, false)))
                }
                await send(.models(
                    unsafeBitCast(
                        await self.platformClient.network().userService()
                            .trending(language: language, since: since)
                            .asResult(),
                        to: Result<[Model], Error>.self
                    )
                ))
                if mode == .refresh {
                    await send(.binding(.set(\.isRefreshing, false)))
                } else if mode == .loadMore {
                    await send(.binding(.set(\.isLoadingMore, false)))
                } else {
                    await send(.binding(.set(\.isLoading, false)))
                }
                await send(.binding(.set(\.pageIndex, pageIndex + 1)))
            }
        } else if state.page == .followers {
            return .run { send in
                await send(.models(
                    unsafeBitCast(
                        await self.platformClient.network().userService()
                            .followers(owner: owner, pageIndex: pageIndex, pageSize: pageSize)
                            .asResult(),
                        to: Result<[Model], Error>.self
                    )
                ))
                if mode == .refresh {
                    await send(.binding(.set(\.isRefreshing, false)))
                } else if mode == .loadMore {
                    await send(.binding(.set(\.isLoadingMore, false)))
                } else {
                    await send(.binding(.set(\.isLoading, false)))
                }
                await send(.binding(.set(\.pageIndex, pageIndex + 1)))
            }
        } else if state.page == .following {
            return .run { send in
                await send(.models(
                    unsafeBitCast(
                        await self.platformClient.network().userService()
                            .following(owner: owner, pageIndex: pageIndex, pageSize: pageSize)
                            .asResult(),
                        to: Result<[Model], Error>.self
                    )
                ))
                if mode == .refresh {
                    await send(.binding(.set(\.isRefreshing, false)))
                } else if mode == .loadMore {
                    await send(.binding(.set(\.isLoadingMore, false)))
                } else {
                    await send(.binding(.set(\.isLoading, false)))
                }
                await send(.binding(.set(\.pageIndex, pageIndex + 1)))
            }
        } else if state.page == .subscribers {
            return .run { send in
                await send(.models(
                    unsafeBitCast(
                        await self.platformClient.network().userService()
                            .subscribers(owner: owner, repo: repo, pageIndex: pageIndex, pageSize: pageSize)
                            .asResult(),
                        to: Result<[Model], Error>.self
                    )
                ))
                if mode == .refresh {
                    await send(.binding(.set(\.isRefreshing, false)))
                } else if mode == .loadMore {
                    await send(.binding(.set(\.isLoadingMore, false)))
                } else {
                    await send(.binding(.set(\.isLoading, false)))
                }
                await send(.binding(.set(\.pageIndex, pageIndex + 1)))
            }
        } else if state.page == .stargazers {
            return .run { send in
                await send(.models(
                    unsafeBitCast(
                        await self.platformClient.network().userService()
                            .stargazers(owner: owner, repo: repo, pageIndex: pageIndex, pageSize: pageSize)
                            .asResult(),
                        to: Result<[Model], Error>.self
                    )
                ))
                if mode == .refresh {
                    await send(.binding(.set(\.isRefreshing, false)))
                } else if mode == .loadMore {
                    await send(.binding(.set(\.isLoadingMore, false)))
                } else {
                    await send(.binding(.set(\.isLoading, false)))
                }
                await send(.binding(.set(\.pageIndex, pageIndex + 1)))
            }
        } else if state.page == .contributors {
            return .run { send in
                await send(.models(
                    unsafeBitCast(
                        await self.platformClient.network().userService()
                            .contributors(owner: owner, repo: repo, pageIndex: pageIndex, pageSize: pageSize)
                            .asResult(),
                        to: Result<[Model], Error>.self
                    )
                ))
                if mode == .refresh {
                    await send(.binding(.set(\.isRefreshing, false)))
                } else if mode == .loadMore {
                    await send(.binding(.set(\.isLoadingMore, false)))
                } else {
                    await send(.binding(.set(\.isLoading, false)))
                }
                await send(.binding(.set(\.pageIndex, pageIndex + 1)))
            }
        }
        return .none
    }
    // swiftlint:enable function_body_length
    
    // swiftlint:disable function_body_length
    func requestRepoList(_ state: inout State, _ action: Action, _ mode: HiRequestMode) -> Effect<Action> {
        let owner = state.owner.isEmpty ? (state.profile.user?.username ?? "") : state.owner
        let repo = state.repo
        let pageIndex = mode == .loadMore ? state.pageIndex : state.pageStart
        let pageSize = state.pageSize
        if state.page == .trendingRepos {
            let language = state.profile.trendingLanguage
            let since = state.profile.trendingSince
            return .run { [language, since] send in
                if mode == .load {
                    await send(.binding(.set(\.fromDatabase, true)))
                    await send(.models(
                        unsafeBitCast(
                            await self.platformClient.database().repoService()
                                .trending(language: language, since: since)
                                .asResult(),
                            to: Result<[Model], Error>.self
                        )
                    ))
                    await send(.binding(.set(\.fromDatabase, false)))
                }
                await send(.models(
                    unsafeBitCast(
                        await self.platformClient.network().repoService()
                            .trending(language: language, since: since)
                            .asResult(),
                        to: Result<[Model], Error>.self
                    )
                ))
                if mode == .refresh {
                    await send(.binding(.set(\.isRefreshing, false)))
                } else if mode == .loadMore {
                    await send(.binding(.set(\.isLoadingMore, false)))
                } else {
                    await send(.binding(.set(\.isLoading, false)))
                }
                await send(.binding(.set(\.pageIndex, pageIndex + 1)))
            }
        } else if state.page == .repositories {
            return .run { send in
                await send(.models(
                    unsafeBitCast(
                        await self.platformClient.network().repoService()
                            .repos(owner: owner, pageIndex: pageIndex, pageSize: pageSize)
                            .asResult(),
                        to: Result<[Model], Error>.self
                    )
                ))
                if mode == .refresh {
                    await send(.binding(.set(\.isRefreshing, false)))
                } else if mode == .loadMore {
                    await send(.binding(.set(\.isLoadingMore, false)))
                } else {
                    await send(.binding(.set(\.isLoading, false)))
                }
                await send(.binding(.set(\.pageIndex, pageIndex + 1)))
            }
        } else if state.page == .stars {
            return .run { send in
                await send(.models(
                    unsafeBitCast(
                        await self.platformClient.network().repoService()
                            .starred(owner: owner, pageIndex: pageIndex, pageSize: pageSize)
                            .asResult(),
                        to: Result<[Model], Error>.self
                    )
                ))
                if mode == .refresh {
                    await send(.binding(.set(\.isRefreshing, false)))
                } else if mode == .loadMore {
                    await send(.binding(.set(\.isLoadingMore, false)))
                } else {
                    await send(.binding(.set(\.isLoading, false)))
                }
                await send(.binding(.set(\.pageIndex, pageIndex + 1)))
            }
        } else if state.page == .subscriptions {
            return .run { send in
                await send(.models(
                    unsafeBitCast(
                        await self.platformClient.network().repoService()
                            .subscriptions(owner: owner, pageIndex: pageIndex, pageSize: pageSize)
                            .asResult(),
                        to: Result<[Model], Error>.self
                    )
                ))
                if mode == .refresh {
                    await send(.binding(.set(\.isRefreshing, false)))
                } else if mode == .loadMore {
                    await send(.binding(.set(\.isLoadingMore, false)))
                } else {
                    await send(.binding(.set(\.isLoading, false)))
                }
                await send(.binding(.set(\.pageIndex, pageIndex + 1)))
            }
        } else if state.page == .forks {
            return .run { send in
                await send(.models(
                    unsafeBitCast(
                        await self.platformClient.network().repoService()
                            .forks(owner: owner, repo: repo, pageIndex: pageIndex, pageSize: pageSize)
                            .asResult(),
                        to: Result<[Model], Error>.self
                    )
                ))
                if mode == .refresh {
                    await send(.binding(.set(\.isRefreshing, false)))
                } else if mode == .loadMore {
                    await send(.binding(.set(\.isLoadingMore, false)))
                } else {
                    await send(.binding(.set(\.isLoading, false)))
                }
                await send(.binding(.set(\.pageIndex, pageIndex + 1)))
            }
        }
        return .none
    }
    // swiftlint:enable function_body_length
    
    func requestIssueList(_ state: inout State, _ action: Action, _ mode: HiRequestMode) -> Effect<Action> {
        let owner = state.owner.isEmpty ? (state.profile.user?.username ?? "") : state.owner
        let repo = state.repo
        let pageIndex = mode == .loadMore ? state.pageIndex : state.pageStart
        let pageSize = state.pageSize
        let page = state.page
        return .run { send in
            await send(.models(
                unsafeBitCast(
                    await self.platformClient.network().issueService()
                        .issues(
                            owner: owner, repo: repo, state: page.stateType, pageIndex: pageIndex, pageSize: pageSize
                        )
                        .asResult(),
                    to: Result<[Model], Error>.self
                )
            ))
            if mode == .refresh {
                await send(.binding(.set(\.isRefreshing, false)))
            } else if mode == .loadMore {
                await send(.binding(.set(\.isLoadingMore, false)))
            } else {
                await send(.binding(.set(\.isLoading, false)))
            }
            await send(.binding(.set(\.pageIndex, pageIndex + 1)))
        }
    }
    
    func requestPullList(_ state: inout State, _ action: Action, _ mode: HiRequestMode) -> Effect<Action> {
        let owner = state.owner.isEmpty ? (state.profile.user?.username ?? "") : state.owner
        let repo = state.repo
        let pageIndex = mode == .loadMore ? state.pageIndex : state.pageStart
        let pageSize = state.pageSize
        let page = state.page
        return .run { send in
            await send(.models(
                unsafeBitCast(
                    await self.platformClient.network().pullService()
                        .pulls(
                            owner: owner, repo: repo, state: page.stateType, pageIndex: pageIndex, pageSize: pageSize
                        )
                        .asResult(),
                    to: Result<[Model], Error>.self
                )
            ))
            if mode == .refresh {
                await send(.binding(.set(\.isRefreshing, false)))
            } else if mode == .loadMore {
                await send(.binding(.set(\.isLoadingMore, false)))
            } else {
                await send(.binding(.set(\.isLoading, false)))
            }
            await send(.binding(.set(\.pageIndex, pageIndex + 1)))
        }
    }
    
    func requestBranchList(_ state: inout State, _ action: Action, _ mode: HiRequestMode) -> Effect<Action> {
        let owner = state.owner.isEmpty ? (state.profile.user?.username ?? "") : state.owner
        let repo = state.repo
        let pageIndex = mode == .loadMore ? state.pageIndex : state.pageStart
        return .run { send in
            await send(.models(
                unsafeBitCast(
                    await self.platformClient.network().branchService()
                        .branches(
                            owner: owner, repo: repo, page: pageIndex
                        )
                        .asResult(),
                    to: Result<[Model], Error>.self
                )
            ))
            if mode == .refresh {
                await send(.binding(.set(\.isRefreshing, false)))
            } else if mode == .loadMore {
                await send(.binding(.set(\.isLoadingMore, false)))
            } else {
                await send(.binding(.set(\.isLoading, false)))
            }
            await send(.binding(.set(\.pageIndex, pageIndex + 1)))
        }
    }
    
}
// swiftlint:enable type_body_length file_length
