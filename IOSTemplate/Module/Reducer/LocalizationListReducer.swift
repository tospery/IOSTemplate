//
//  LocalizationListReducer.swift
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
struct LocalizationListReducer {
    
    @ObservableState
    struct State: Equatable {
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
        case list(ListReducer<Tile>.Action)
        case load
        case data(Any?)
        case target(String)
    }
    
    @Dependency(\.applicationClient) var application
    // @Dependency(\.clipboardClient) var clipboardClient
    private enum CancelID { case load, target }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Scope(state: \.list, action: \.list) { ListReducer.init() }
        Reduce { state, action in
            switch action {
            case .load:
                state.list.isLoading = true
                return .run { send in
                    await send(.list(.models(.success(
                        HiBase.Localization.allCases.map {
                            Tile(
                                id: $0.id,
                                title: $0.description,
                                separated: $0 == .english ? false : true,
                                indicated: false
                            )
                        }
                    ))))
                    await send(.binding(.set(\.list.isLoading, false)))
                }.cancellable(id: CancelID.load)
            default:
                return .none
            }
        }
    }
    
}
