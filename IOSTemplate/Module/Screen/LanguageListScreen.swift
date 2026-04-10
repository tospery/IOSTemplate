//
//  LanguageListScreen.swift
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
import HiCore
import HiSwiftUI
import Domain
import NetworkPlatform
import SwiftUIKit_Hi
import HiLog

struct LanguageListScreen: View {
    @Perception.Bindable var store: StoreOf<LanguageListReducer>

    var body: some View {
        WithPerceptionTracking {
            VStack {
//                SearchBarView(text: $store.keyword) { _ in
//                }
                if let error = store.list.error {
                    ErrorView(error) { store.send(.load) }
                } else {
                    ScrollView {
                        let last = store.list.models.last
                        LazyVStack(spacing: 0) {
                            ForEach(store.list.models) { cell($0, last) }
                        }
                    }
                    .background(Color.surface)
                }
            }
            .background(Color.surface)
            .navigationTitle(R.string.localizable.language.localizedStringKey)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .tabBar)
            .onAppear {
                stats(.beginPageView(name: self.className))
                store.send(.load)
            }
            .onDisappear {
                stats(.endPageView(name: self.className))
            }
        }
    }
    
    @ViewBuilder
    func cell(_ model: Language, _ last: Language?) -> some View {
        let lang: Language = store.forSearch
        ? (store.preference.searchLanguage ?? .any)
        : (store.preference.trendingLanguage ?? .any)
        VStack(spacing: 0) {
            LanguageCell(
                model,
                selected: lang == model
            ) {
                if model.id == lang.id {
                    return
                }
                store.send(.change(model))
            }
            if model != last {
                Separator()
                    .padding(.leading)
            }
        }
    }
    
}
