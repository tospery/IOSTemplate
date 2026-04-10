//
//  LocalizationScreen.swift
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
import HiNav
import HiSwiftUI
import Domain
import NetworkPlatform
import HiLog
import RswiftResources

struct LocalizationListScreen: View {
    @Perception.Bindable var store: StoreOf<LocalizationListReducer>

    var body: some View {
        WithPerceptionTracking {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(store.list.models) { cell($0) }
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
    
    func cell(_ model: Tile) -> TileCell {
        let id = HiBase.Localization.init(rawValue: model.id) ?? .english
        return TileCell(model.copyWith(
            checked: id == store.preference.localization ?? .english
        )) {
            if store.preference.localization ?? .english == id {
                return
            }
            store.send(.data(id))
            store.send(.target(
                HiNav.shared.alertDeepLink(
                    R.string.localizable.prompt.localizedString,
                    R.string(bundle: .localizedBundle ?? .main)
                        .localizable.alertLocalizationMessage(id.description),
                    [
                        WHAlertAction.cancel,
                        WHAlertAction.default
                    ]
                )
            ))
        }
    }
    
}
