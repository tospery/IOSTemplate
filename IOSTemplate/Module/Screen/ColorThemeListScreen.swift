//
//  ColorThemeScreen.swift
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
import RswiftResources
import HiLog

struct ColorThemeListScreen: View {
    @Perception.Bindable var store: StoreOf<ColorThemeListReducer>

    var body: some View {
        WithPerceptionTracking {
            ScrollView {
                VStack(spacing: 0) {
                    let last = store.list.models.last?.data as? ColorTheme ?? .red
                    ForEach(store.list.models) { cell($0, last) }
                }
            }
            .background(Color.surface)
            .navigationTitle(R.string.localizable.theme.localizedStringKey)
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
    func cell(_ model: WrappedModel, _ last: ColorTheme) -> some View {
        let id = model.data as? ColorTheme ?? .red
        VStack(spacing: 0) {
            ThemeCell(id, selected: store.preference.colorTheme ?? .red == id) {
                if store.preference.colorTheme ?? .red == id {
                    return
                }
                store.send(.data(id))
                store.send(.target(
                    HiNav.shared.alertDeepLink(
                        R.string.localizable.prompt.localizedString,
                        R.string(bundle: .localizedBundle ?? .main).localizable.alertThemeMessage(
                            id.rawValue.capitalizedFirstCharacter.localizedString
                        ),
                        [
                            WHAlertAction.cancel,
                            WHAlertAction.default
                        ]
                    )
                ))
            }
            if id != last {
                Separator()
                    .padding(.leading)
            }
        }
    }
    
}
