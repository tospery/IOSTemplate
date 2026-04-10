//
//  HomeReducer.swift
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
struct HomeReducer {
    
    @ObservableState
    struct State: Equatable {
        var list: ListReducer<News>.State
        var route = AppRouteReducer.State.init()
        var title = R.string.localizable.home.localizedString
//        var tappedCount = 0
        @Shared(.preference) var preference = .default
        init(url: String) {
            var myList = ListReducer<News>.State.init(url: url)
            myList.shouldRefresh = myList.parameters.bool(for: Parameter.shouldRefresh) ?? true
            myList.shouldLoadMore = myList.parameters.bool(for: Parameter.shouldLoadMore) ?? false
            self.list = myList
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case list(ListReducer<News>.Action)
        case load
        case target(String)
        case route(AppRouteReducer.Action)
//        case data(Any?)
    }
    
//    @Dependency(\.applicationClient) var application
    private enum CancelID { case load }
    
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
//            switch action {
//            case .load:
//                state.list.isLoading = true
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
//            case .increment:
//                state.tappedCount += 1
//                if state.tappedCount == 10 {
//                    state.tappedCount = 0
//                    return .run { send in
//                        // await self.clipboardClient.saveText(UIDevice.current.uuid)
//                        await send(.target(HiNav.shared.toastMessageDeepLink(
//                            R.string.localizable.toastCopyMessage.localizedString
//                        )))
//                    }.cancellable(id: CancelID.increment)
//                }
//                return .none
//            default:
//                return .none
//            }
        }
    }
    
}

