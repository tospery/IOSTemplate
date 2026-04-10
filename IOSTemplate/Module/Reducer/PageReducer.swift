//
//  PageReducer.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/11/23.
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
struct PageReducer {
    
    @ObservableState
    struct State: Equatable {
        let url: String
        let parameters: [String: String]
        let owner: String
        let repo: String
        let pages: [PageType]
        
        var selectedIndex = 0
        var title: String?
        @Shared(.preference) var preference = .default
        
        init(url: String) {
            self.url = url
            self.parameters = self.url.url?.queryParameters ?? [:]
            var owner = self.parameters.string(for: Parameter.owner) ?? ""
            if owner.isEmpty {
                owner = preferenceService.value?.loginedUser?.username ?? ""
            }
            self.owner = owner
            self.repo = self.parameters.string(for: Parameter.repo) ?? ""
            let data = self.parameters.string(for: Parameter.pages)?.data(using: .utf8)
            let json = (try? data?.jsonObject()) as? [String] ?? []
            self.pages = json.map { PageType.init(rawValue: $0) ?? .none }
            self.title = self.parameters.string(for: Parameter.title) ?? self.owner
            self.selectedIndex = self.parameters.int(for: Parameter.index) ?? 0
            log("Page URL: \(self.url)")
            log("Page OWNER: \(self.owner)")
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case target(String)
    }
    
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
