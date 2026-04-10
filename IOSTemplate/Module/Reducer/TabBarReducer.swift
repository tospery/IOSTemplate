//
//  TabBarReducer.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/3/28.
//

import Foundation
import ComposableArchitecture
import HiLog
import HiNav

@Reducer
struct TabBarReducer {
    @ObservableState
    struct State: Equatable {
        var tabBarItemType = TabBarItemType.home
        
        var home = HomeReducer.State.init(url: HiNav.shared.deepLink(host: .home))
        var shop = ShopReducer.State.init(url: HiNav.shared.deepLink(host: .shop))
        var fave = FaveReducer.State.init(url: HiNav.shared.deepLink(host: .fave))
        var mine = MineReducer.State.init(url: HiNav.shared.deepLink(host: .mine))
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case load
        case setTabBarItemType(TabBarItemType)
        case home(HomeReducer.Action)
        case shop(ShopReducer.Action)
        case fave(FaveReducer.Action)
        case mine(MineReducer.Action)
    }

    // @Dependency(\.deviceClient) private var deviceClient

    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .load:
                log("展示了root")
//                return .run { send in
////                    _ = await self.exampleData().asResult()
////                    _ = await performMigration().asResult()
//                    await send(.databaseInitialized(
//                        await self.databaseInitialize()
//                    ))
//                }.cancellable(id: CancelID.load)
                return .none
            case let .setTabBarItemType(tabBarItemType):
                state.tabBarItemType = tabBarItemType
                return .none
            default:
                return .none
            }
        }
        Scope(state: \.home, action: \.home) { HomeReducer.init() }
        Scope(state: \.shop, action: \.shop) { ShopReducer.init() }
        Scope(state: \.fave, action: \.fave) { FaveReducer.init() }
        Scope(state: \.mine, action: \.mine) { MineReducer.init() }
    }
}
