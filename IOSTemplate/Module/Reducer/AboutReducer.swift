//
//  AboutReducer.swift
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
import HiNav
import HiSwiftUI
import Domain
import HiLog

@Reducer
struct AboutReducer {
    
    @ObservableState
    struct State: Equatable {
        var list: ListReducer<Tile>.State
        var tappedCount = 0
        @Shared(.profile) var profile = .default
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
        case increment
        case target(String)
        case data(Any?)
    }
    
    @Dependency(\.application) var application
    private enum CancelID { case load, increment }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Scope(state: \.list, action: \.list) { ListReducer.init() }
        Reduce { state, action in
            switch action {
            case .load:
                state.list.isLoading = true
//                return .run { send in
//                    await send(.list(.models(.success(
//                        TileId.aboutValues.map {
//                            Tile.init(
//                                id: $0.id,
//                                style: $0 == .space ? .space : .plain,
//                                title: $0.description,
//                                separated: $0.separated,
//                                indicated: $0.indicated,
//                                target: $0 == .author ? HiNav.shared.deepLink(host: .user, parameters: [
//                                    Parameter.owner: Author.owner
//                                ]) : $0.target
//                            )
//                        }
//                    ))))
//                    await send(.binding(.set(\.list.isLoading, false)))
//                }.cancellable(id: CancelID.load)
                return .none
            case .increment:
                state.tappedCount += 1
//                if state.tappedCount == 10 {
//                    state.tappedCount = 0
//                    return .run { send in
//                        await self.clipboardClient.saveText(UIDevice.current.uuid)
//                        await send(.target(HiNav.shared.toastMessageDeepLink(
//                            R.string.localizable.toastCopyMessage.localizedString
//                        )))
//                    }.cancellable(id: CancelID.increment)
//                }
                return .none
            default:
                return .none
            }
        }
    }
    
}
