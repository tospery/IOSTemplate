//
//  AppDelegate.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/10/6.
//

import SwiftUI
import ComposableArchitecture
import HiLog

@Reducer
struct AppReducer {
    
    @ObservableState
    struct State: Equatable {
    }

    enum Action: Equatable {
        case onLaunchFinish
    }
    
    var body: some Reducer<State, Action> {
        Reduce { _, action in
            switch action {
            case .onLaunchFinish:
                return .none
            }
        }
    }

}
