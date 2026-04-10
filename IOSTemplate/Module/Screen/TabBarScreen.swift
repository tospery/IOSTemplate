//
//  TabBarScreen.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/3/28.
//

import SwiftUI
import ComposableArchitecture
import HiBase

struct TabBarScreen: View {
//    @Environment(\.scenePhase) private var scenePhase
    @Perception.Bindable var store: StoreOf<TabBarReducer>

//    init(store: StoreOf<AppReducer>) {
//        self.store = store
//    }

    var body: some View {
        WithPerceptionTracking {
            ZStack {
                TabView(selection: $store.tabBarItemType.sending(\.setTabBarItemType)) {
                    ForEach(TabBarItemType.allCases) { type in
                        WithPerceptionTracking {
                            Group {
                                switch type {
                                case .home: HomeScreen(store: store.scope(state: \.home, action: \.home))
                                case .shop: ShopScreen(store: store.scope(state: \.shop, action: \.shop))
                                case .fave: FaveScreen(store: store.scope(state: \.fave, action: \.fave))
                                case .mine: MineScreen(store: store.scope(state: \.mine, action: \.mine))
                                }
                            }
                            .tabItem {
                                (
                                    store.tabBarItemType == type ? type.selectedImage : type.normalImage
                                )
                                .renderingMode(.template)
                                Text(type.title.localizedStringKey)
                            }
                            .tag(type)
                        }
                    }
                }
                .toolbar(.visible, for: .tabBar)
                .navigationTitle(Text(store.tabBarItemType.title))
                .navigationBarTitleDisplayMode(.inline)
                .tint(Color.red) // YJX_TODO
//                .tint((store.preference.colorTheme ?? .red).swiftUIColor)
//                .environment(\.locale, (store.preference.localization ?? .english).locale)
//                .environment(\.colorScheme, (store.preference.isDark ?? false) ? .dark : .light)
//                .onOpenURL { handleURL($0) }
//                .onChange(of: store.preference) { preference in
//                    log("preference变化了: \(preference)")
//                    preferenceService.send(preference)
//                    store.send(.binding(.set(\.preference, preference)))
//                }
//                .overlay(alignment: .bottom) { overlay() }
//                .onAppear {
//                    stats(.beginPageView(name: self.className))
//                    store.send(.load)
//                }
//                .onDisappear {
//                    stats(.endPageView(name: self.className))
//                }
            }
        }
    }

}
