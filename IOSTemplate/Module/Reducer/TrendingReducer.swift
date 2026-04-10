//
//  TrendingReducer.swift
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
struct TrendingReducer {
    
    @ObservableState
    struct State: Equatable {
        let url: String
        let parameters: [String: String]
        var pages = PageType.trendingValues
        
        var selectedIndex = 1
        var route = RouteReducer.State.init()
        @Shared(.preference) var preference = .default
        
        init(url: String) {
            self.url = url
            self.parameters = self.url.url?.queryParameters ?? [:]
            self.selectedIndex = self.parameters.int(for: Parameter.index) ?? 0
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case route(RouteReducer.Action)
        case load
    }
    
    @Dependency(\.continuousClock) var clock
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Scope(state: \.route, action: \.route) { RouteReducer.init() }
        Reduce { state, action in
            switch action {
            case .load:
                state.selectedIndex = 0
                return .none
            default:
                return .none
            }
        }
    }
    
}
