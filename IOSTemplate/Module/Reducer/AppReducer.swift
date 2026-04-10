//
//  AppReducer.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/3/28.
//

import SwiftUI
import ComposableArchitecture
import HiNav

@Reducer
struct AppReducer {
    @ObservableState
    struct State: Equatable {
//        var appDelegateState = AppDelegateReducer.State()
//        var appRouteState = AppRouteReducer.State()
//        var appLockState = AppLockReducer.State()
        var appDelegate = AppDelegateReducer.State.init()
        var root = TabBarReducer.State.init()
        var home = HomeReducer.State.init(url: HiNav.shared.deepLink(host: .home))
        var shop = ShopReducer.State.init(url: HiNav.shared.deepLink(host: .shop))
        var fave = FaveReducer.State.init(url: HiNav.shared.deepLink(host: .fave))
        var mine = MineReducer.State.init(url: HiNav.shared.deepLink(host: .mine))
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
//        case onScenePhaseChange(ScenePhase)
//        
//        case appDelegate(AppDelegateReducer.Action)
//        case appRoute(AppRouteReducer.Action)
//        case appLock(AppLockReducer.Action)
        
        case appDelegate(AppDelegateReducer.Action)
        
        case root(TabBarReducer.Action)
        
        case home(HomeReducer.Action)
        case shop(ShopReducer.Action)
        case fave(FaveReducer.Action)
        case mine(MineReducer.Action)
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            default:
                return .none
            }
//            switch action {
//            case let .tabBarItemType(tabBarItemType):
//                state.tabBarItemType = tabBarItemType
//                return .none
//            case .load:
//                log("展示了root")
////                return .run { send in
//////                    _ = await self.exampleData().asResult()
//////                    _ = await performMigration().asResult()
////                    await send(.databaseInitialized(
////                        await self.databaseInitialize()
////                    ))
////                }.cancellable(id: CancelID.load)
//                return .none
//            case .login:
//                return .run { _ in
//                    _ = await self.application.open(
//                        HiNav.shared.deepLink(host: .login).url!,
//                        options: [:]
//                    )
//                }.cancellable(id: CancelID.login)
//            case let .databaseInitialized(.success(preference)):
//                // state.preference = preference // YJX_TODO
//                return .none
//            case let .databaseInitialized(.failure(error)):
//                log("样本数据库失败: \(error)")
//                return .none
//            case .binding(\.preference):
//                log("preference需要保存了。。。")
//                let preference = state.preference
//                return .run { [preference] _ in
//                    _ = await self.platformClient.network().preferenceService().save(preference: preference).asResult()
//                    _ = await self.platformClient.database().preferenceService().save(preference: preference).asResult()
//                }
//            default:
//                return .none
//            }
        }
        Scope(state: \.appDelegate, action: \.appDelegate) { AppDelegateReducer.init() }
        Scope(state: \.home, action: \.home) { HomeReducer.init() }
        Scope(state: \.shop, action: \.shop) { ShopReducer.init() }
        Scope(state: \.fave, action: \.fave) { FaveReducer.init() }
        Scope(state: \.mine, action: \.mine) { MineReducer.init() }
    }
    
}
