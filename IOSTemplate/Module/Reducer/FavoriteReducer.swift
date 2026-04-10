//
//  FavoriteReducer.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/11/17.
//

import Foundation
import ComposableArchitecture

import SwifterSwift
import HiBase
import HiCore
import HiSwiftUI
import Domain
import HiLog

@Reducer
struct FavoriteReducer {
    
    @ObservableState
    struct State: Equatable {
        var list: ListReducer<Repo>.State
        var route = RouteReducer.State.init()
        var title = R.string.localizable.favorite.localizedString
        @Shared(.preference) var preference = .default
        init(url: String) {
            let myURL = url.url?.myAppendingQueryParameters([
                Parameter.page: PageType.stars.rawValue
            ])
            var myList = ListReducer<Repo>.State.init(url: myURL!.absoluteString)
            myList.shouldRefresh = myList.parameters.bool(for: Parameter.shouldRefresh) ?? true
            myList.shouldLoadMore = myList.parameters.bool(for: Parameter.shouldLoadMore) ?? true
            self.list = myList
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case list(ListReducer<Repo>.Action)
        case route(RouteReducer.Action)
        case load
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Scope(state: \.list, action: \.list) { ListReducer.init() }
        Scope(state: \.route, action: \.route) { RouteReducer.init() }
        Reduce { state, action in
            switch action {
            case .load:
                state.title = R.string.localizable.favorite.localizedString
//                guard state.preference.hasLoginedUser else {
//                    return .none
//                }
//                return .run { send in
//                    await send(.list(.load))
//                }
                return .none
            default:
                return .none
            }
        }
    }
    
}
