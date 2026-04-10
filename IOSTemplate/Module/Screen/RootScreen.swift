//
//  RootScreen.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/11/17.
//

import SwiftUI
import ComposableArchitecture

import SFSafeSymbols
import SwifterSwift
import AlertToast_Hi
import HiCore
import HiSwiftUI
import HiLog
import Domain
import HiBase
import Combine

struct RootScreen: View {

    @Perception.Bindable var store: StoreOf<RootReducer>
    @Environment(\.locale) var locale
    
    var body: some View {
        WithPerceptionTracking {
            ZStack {
                TabView(selection: $store.tabBarItemType.sending(\.tabBarItemType)) {
                    // trending
                    TrendingScreen(
                        store: store.scope(
                            state: \.trending,
                            action: \.trending
                        )
                    )
                    .tabItem {
                        (
                            store.tabBarItemType == .trending ?
                            R.image.trending_selected_icon.swiftUIImage : R.image.trending_normal_icon.swiftUIImage
                        )
                            .renderingMode(.template)
                        Text(R.string.localizable.trending.localizedStringKey)
                    }
                    .tag(TabBarItemType.trending)
//                    // event
//                    EventListScreen(
//                        store: store.scope(
//                            state: \.event,
//                            action: \.event
//                        )
//                    )
//                    .tabItem {
//                        (
//                            store.tabBarItemType == .event ?
//                            R.image.event_selected_icon.swiftUIImage : R.image.event_normal_icon.swiftUIImage
//                        )
//                            .renderingMode(.template)
//                        Text(R.string.localizable.event.localizedStringKey)
//                    }
//                    .tag(TabBarItemType.event)
                    // favorite
                    FavoriteScreen(
                        store: store.scope(
                            state: \.favorite,
                            action: \.favorite
                        )
                    )
                    .tabItem {
                        (
                            store.tabBarItemType == .favorite ?
                            R.image.favorite_selected_icon.swiftUIImage : R.image.favorite_normal_icon.swiftUIImage
                        )
                            .renderingMode(.template)
                        Text(R.string.localizable.favorite.localizedStringKey)
                    }
                    .tag(TabBarItemType.favorite)
                    // personal
                    PersonalScreen(
                        store: store.scope(
                            state: \.personal,
                            action: \.personal
                        )
                    )
                    .tabItem {
                        (
                            store.tabBarItemType == .personal ?
                            R.image.personal_selected_icon.swiftUIImage : R.image.personal_normal_icon.swiftUIImage
                        )
                            .renderingMode(.template)
                        Text(R.string.localizable.personal.localizedStringKey)
                    }
                    .tag(TabBarItemType.personal)
                }
                .toolbar(.visible, for: .tabBar)
                .navigationTitle(Text(store.tabBarItemType.title))
                .navigationBarTitleDisplayMode(.inline)
                .tint((store.preference.colorTheme ?? .red).swiftUIColor)
                .environment(\.locale, (store.preference.localization ?? .english).locale)
                .environment(\.colorScheme, (store.preference.isDark ?? false) ? .dark : .light)
                .onOpenURL { handleURL($0) }
                .onChange(of: store.preference) { preference in
                    log("preference变化了: \(preference)")
                    preferenceService.send(preference)
                    store.send(.binding(.set(\.preference, preference)))
                }
                .overlay(alignment: .bottom) { overlay() }
                .onAppear {
                    stats(.beginPageView(name: self.className))
                    store.send(.load)
                }
                .onDisappear {
                    stats(.endPageView(name: self.className))
                }
            }
        }
    }
    
    @ViewBuilder
    func overlay() -> some View {
        if store.preference.hasLoginedUser {
            EmptyView()
        } else {
            HStack(spacing: 0) {
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: screenWidth / 4.0, height: tabBarHeight - safeArea.bottom)
                    .contentShape(.rect)
                    .onTapGesture {
                        store.send(.login)
                    }
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: screenWidth / 4.0, height: tabBarHeight - safeArea.bottom)
                    .contentShape(.rect)
                    .onTapGesture {
                        store.send(.login)
                    }
            }
        }
    }
    
    func handleURL(_ url: URL) {
        log("root中的onOpenURL: \(url)")
        log("store.tabBarItemType: \(store.tabBarItemType)")
        switch store.tabBarItemType {
        case .trending: store.send(.trending(.route(.target(url.absoluteString))))
//        case .event: store.send(.event(.route(.target(url.absoluteString))))
        case .favorite: store.send(.favorite(.route(.target(url.absoluteString))))
        case .personal: store.send(.personal(.route(.target(url.absoluteString))))
        }
    }
    
}
