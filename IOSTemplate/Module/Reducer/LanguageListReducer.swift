//
//  LanguageListReducer.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/11/17.
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
struct LanguageListReducer {
    
    @ObservableState
    struct State: Equatable {
        let forSearch: Bool
        var list: ListReducer<Language>.State
        var keyword = ""
        var originals: [Language] = []
        @Shared(.preference) var preference = .default
        init(url: String) {
            var myList = ListReducer<Language>.State.init(url: url)
            myList.shouldRefresh = myList.parameters.bool(for: Parameter.shouldRefresh) ?? false
            myList.shouldLoadMore = myList.parameters.bool(for: Parameter.shouldLoadMore) ?? false
            self.forSearch = myList.parameters.bool(for: Parameter.search) ?? false
            self.list = myList
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case list(ListReducer<Language>.Action)
        case load
        case duplicate
        case change(Language)
        case target(String)
    }
    
    @Dependency(\.platformClient) var platformClient
    private enum CancelID { case load, target }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Scope(state: \.list, action: \.list) { ListReducer.init() }
        Reduce { state, action in
            switch action {
            case .load:
                state.list.isLoading = true
                return .run { send in
                    await send(.list(.models(
                        await self.platformClient.database().languageService().languages().asResult()
                    )))
                    await send(.duplicate)
                    await send(.binding(.set(\.list.isLoading, false)))
                }.cancellable(id: CancelID.load)
            case .duplicate:
                state.originals = state.list.models
                return .none
            case .binding(\.keyword):
                if state.keyword.isEmpty {
                    state.list.models = state.originals
                } else {
                    state.list.models = state.originals.filter {
                        $0.name?.contains(state.keyword, caseSensitive: false) ?? false
                    }
                }
                if state.list.models.isEmpty {
                    state.list.error = HiError.dataIsEmpty
                } else {
                    state.list.error = nil
                }
                return .none
            case let .change(language):
                var preference = state.preference
                if state.forSearch {
                    preference.searchLanguage = language
                } else {
                    preference.trendingLanguage = language
                }
                // state.preference = preference // YJX_TODO
                return .run { send in
                    await send(.target(HiNav.shared.backDeepLink()))
                }
            default:
                return .none
            }
        }
    }
    
}
