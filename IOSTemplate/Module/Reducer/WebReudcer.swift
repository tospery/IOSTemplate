//
//  WebReducer.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/12/13.
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
struct WebReducer {
    
    @ObservableState
    struct State: Equatable {
        let url: String
        let parameters: [String: String]
        var isLoading = true
        var isRefreshing = false
        var error: HiError?
        @Shared(.preference) var preference = .default
        init(url: String) {
            self.parameters = url.url?.queryParameters ?? [:]
            self.url = self.parameters.string(for: Parameter.url) ?? url
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case target(String)
    }
    
    private enum CancelID { case load, target }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { _, action in
            switch action {
            default:
                return .none
            }
        }
    }
    
}
