//
//  RepoListReducer.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/11/17.
//

import SwiftUI
import Combine
import ComposableArchitecture
import SFSafeSymbols
import SwifterSwift
import AlertToast_Hi
import Kingfisher
import HiBase
import HiCore
import HiSwiftUI
import Domain
import NetworkPlatform
import HiLog

@Reducer
struct RepoListReducer {
    
    @ObservableState
    struct State: Equatable {
        var list: ListReducer<Repo>.State
        var onceToken = false
        @Shared(.preference) var preference = .default
        
        init(url: String) {
            var myList = ListReducer<Repo>.State.init(url: url)
            myList.shouldRefresh = myList.parameters.bool(for: Parameter.shouldRefresh) ?? true
            myList.shouldLoadMore = myList.parameters.bool(for: Parameter.shouldLoadMore) ?? true
            self.list = myList
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case list(ListReducer<Repo>.Action)
        case load
        case target(String)
    }
    
    @Dependency(\.platformClient) var platformClient
    private enum CancelID { case load }
    
    init() {
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Scope(state: \.list, action: \.list) { ListReducer.init() }
        Reduce { _, action in
            switch action {
            case .load:
                return .run { send in
                    await send(.list(.load))
                }.cancellable(id: CancelID.load)
            default:
                return .none
            }
        }
    }
    
}
