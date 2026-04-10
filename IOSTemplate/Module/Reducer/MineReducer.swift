//
//  MineReducer.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/3/28.
//

import Foundation
import ComposableArchitecture
import SwifterSwift
import HiBase
import HiCore
import HiNav
import HiSwiftUI
import Domain
import HiLog

@Reducer
struct MineReducer {
    
    @ObservableState
    struct State: Equatable {
        var title = R.string.localizable.mine.localizedString
        var route = AppRouteReducer.State.init()
        var list: ListReducer<Tile>.State
        @Shared(.preference) var preference = .default
        init(url: String) {
            var myList = ListReducer<Tile>.State.init(url: url)
            myList.shouldRefresh = myList.parameters.bool(for: Parameter.shouldRefresh) ?? false
            myList.shouldLoadMore = myList.parameters.bool(for: Parameter.shouldLoadMore) ?? false
            self.list = myList
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case route(AppRouteReducer.Action)
        case list(ListReducer<Tile>.Action)
        case load
        case dark
    }
    
    @Dependency(\.platformClient) var platformClient
    private enum CancelID { case load }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Scope(state: \.route, action: \.route) { AppRouteReducer.init() }
        Scope(state: \.list, action: \.list) { ListReducer.init() }
        Reduce { state, action in
            switch action {
//            case .load:
//                state.milestone = ""
//                guard let urlString = state.profile.user?.milestone else { return .none }
//                return .run { send in
//                    let milestone = await self.platformClient.network().dynamicService()
//                        .file(urlString: urlString, baseString: UIApplication.shared.baseApiUrl)
//                        .asOutput() as? String ?? ""
//                    await send(.binding(.set(\.milestone, milestone)))
//                }.cancellable(id: CancelID.load)
            case .dark:
//                var profile = state.profile
//                profile.isDark = !(profile.isDark ?? false)
//                state.profile = profile
                return .none
            default:
                return .none
            }
        }
    }
    
}
