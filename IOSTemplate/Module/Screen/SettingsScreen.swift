//
//  SettingsScreen.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/11/26.
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

struct SettingsScreen: View {
    @Perception.Bindable var store: StoreOf<SettingsReducer>

    var body: some View {
        WithPerceptionTracking {
            content()
            .background(Color.surface)
            .navigationTitle(R.string.localizable.settings.localizedStringKey)
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
    func content() -> some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(store.list.models) { model in
                    let id = TileId(rawValue: model.id) ?? .space
                    if id == .colorTheme {
                        WithPerceptionTracking {
                            TileCell(model.copyWith(
                                detail: (store.preference.colorTheme ?? .red).rawValue
                                    .capitalizedFirstCharacter.localizedString
                            )) {
                                store.send(.target(model.target ?? ""))
                            }
                        }
                    } else if id == .localization {
                        WithPerceptionTracking {
                            TileCell(model.copyWith(
                                detail: (store.preference.localization ?? .english).description
                            )) {
                                store.send(.target(model.target ?? ""))
                            }
                        }
                    } else if id == .cache {
                        WithPerceptionTracking {
                            TileCell(model.copyWith(
                                detail: store.size ?? "0"
                            )) {
                                store.send(.clear)
                            }
                        }
                    } else {
                        EmptyView()
                    }
                }
            }
        }
    }
    
}
