//
//  SettingsReducer.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/11/26.
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
struct SettingsReducer {
    
    @ObservableState
    struct State: Equatable {
        var list: ListReducer<Tile>.State
        var size: String?
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
        case clear
        case target(String)
    }
    
    @Dependency(\.continuousClock) var clock
    // @Dependency(\.cacheClient) var cacheClient
    private enum CancelID { case load, clear }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Scope(state: \.list, action: \.list) { ListReducer.init() }
        Reduce { state, action in
            switch action {
            case .load:
                state.list.isLoading = true
                return .run { send in
                    await send(.list(.models(.success(
                        TileId.settingValues.map {
                            Tile.init(
                                id: $0.id,
                                title: $0.description,
                                separated: $0.separated,
                                indicated: $0.indicated,
                                target: $0.target
                            )
                        }
                    ))))
//                    await send(.binding(.set(
//                        \.size,
//                         await self.cacheClient.calculateDiskStorageSize()
//                    )))
                    await send(.binding(.set(\.list.isLoading, false)))
                }.cancellable(id: CancelID.load)
            case .clear:
                return .run { send in
//                    await self.cacheClient.clearDiskCache()
                    await send(.binding(.set(\.size, "0")))
                    await send(.target(HiNav.shared.toastMessageDeepLink(
                        R.string.localizable.toastCacheMessage.localizedString
                    )))
                }.cancellable(id: CancelID.clear)
            default:
                return .none
            }
        }
    }
    
}
