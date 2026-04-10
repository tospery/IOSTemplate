//
//  TrendingScreen.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/11/17.
//

import SwiftUI
import ComposableArchitecture

import SFSafeSymbols
import SwifterSwift
import AlertToast_Hi
import Parchment
import ExytePopupView
import HiBase
import HiCore
import HiNav
import HiSwiftUI
import Domain
import HiLog

struct TrendingScreen: View {
    
    @Perception.Bindable var store: StoreOf<TrendingReducer>
    @State var hasLoaded = false
    
    var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.route.push, action: \.route.push)) {
                EmptyView()
//                PageView(store.pages, selectedIndex: $store.selectedIndex) { page in
//                    Page(page.description.localizedStringKey) {
//                        if page.forRepo {
//                            repoListScreen(page)
//                        } else {
//                            userListScreen(page)
//                        }
//                    }
//                }
//                .foregroundColor(.primary)
//                .selectedColor((store.preference.colorTheme ?? .red).swiftUIColor)
//                .menuBackgroundColor(.background)
//                .menuHorizontalAlignment(.center)
//                .borderOptions(.hidden)
//                .menuItemLabelSpacing(12)
//                .menuItemSize(.selfSizing(estimatedWidth: 50, height: 44))
//                .indicatorOptions(.visible(height: 2, zIndex: .max, spacing: .zero, insets: .zero))
//                .indicatorColor(.accentColor)
//                .toolbar(.hidden, for: .navigationBar)
//                .overlay(optionsNavBarItem(), alignment: .topLeading)
//                .overlay(searchNavBarItem(), alignment: .topTrailing)
//                .onAppear {
//                    stats(.beginPageView(name: self.className))
//                    if hasLoaded {
//                        return
//                    }
//                    hasLoaded = true
//                    store.send(.load)
//                }
//                .onDisappear {
//                    stats(.endPageView(name: self.className))
//                }
            } destination: {
                Push.destination($0)
            }
            .withRouteHandling(
                route: store.scope(state: \.route, action: \.route),
                alert: $store.scope(state: \.route.alert, action: \.route.alert),
                sheet: $store.scope(state: \.route.sheet, action: \.route.sheet),
                login: $store.scope(state: \.route.login, action: \.route.login)
//                search: $store.scope(state: \.route.search, action: \.route.search),
//                trendingOptions: $store.scope(state: \.route.trendingOptions, action: \.route.trendingOptions)
            )
        }
    }
    
    func repoListScreen(_ page: PageType) -> RepoListScreen {
        RepoListScreen.init(
            store: Store(
                initialState: RepoListReducer.State.init(
                    url: HiNav.shared.deepLink(
                        host: .repoList,
                        parameters: [
                            Parameter.shouldRefresh: true.string,
                            Parameter.shouldLoadMore: false.string,
                            Parameter.page: page.rawValue
                        ]
                    )
                ),
                reducer: { RepoListReducer() }
            )
        ) { store.send(.route(.target($0))) }
    }
    
    func userListScreen(_ page: PageType) -> UserListScreen {
        UserListScreen.init(
            store: Store(
                initialState: UserListReducer.State.init(
                    url: HiNav.shared.deepLink(
                        host: .userList,
                        parameters: [
                            Parameter.shouldRefresh: true.string,
                            Parameter.shouldLoadMore: false.string,
                            Parameter.page: page.rawValue
                        ]
                    )
                ),
                reducer: { UserListReducer() }
            )
        ) { store.send(.route(.target($0))) }
    }
    
    func optionsNavBarItem() -> some View {
        Image(systemSymbol: .listBullet)
            .font(.system(size: 20))
            .frame(width: navigationBarHeight * 1.4, height: navigationBarHeight)
            .foregroundStyle(Color.primary)
            .contentShape(.rect)
            .onTapGesture {
//                store.send(.route(.target(
//                    HiNav.shared.deepLink(host: .trendingOptions)
//                )))
            }
    }
    
    func searchNavBarItem() -> some View {
        Image(systemSymbol: .magnifyingglass)
            .font(.system(size: 20))
            .frame(width: navigationBarHeight * 1.4, height: navigationBarHeight)
            .foregroundStyle(Color.primary)
            .contentShape(.rect)
            .onTapGesture {
//                store.send(.route(.target(
//                    HiNav.shared.deepLink(host: .search)
//                )))
            }
    }
    
}
