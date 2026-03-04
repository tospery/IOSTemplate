//
//  FavoriteScreen.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/3/3.
//

import SwiftUI
import Combine
import ComposableArchitecture
import DependenciesAdditions
import SFSafeSymbols
import SwifterSwift
import AlertToast_Hi
import SwiftUIKit_Hi
import ExytePopupView
import HiCore
import HiSwiftUI
import Refresh_Hi
import Domain
import HiLog

struct FavoriteScreen: View {
    @Perception.Bindable var store: StoreOf<FavoriteReducer>
    @State var hasLoaded = false
    
    var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.route.push, action: \.route.push)) {
                content()
            } destination: {
                Push.destination($0)
            }
            .withRouteHandling(
                route: store.scope(state: \.route, action: \.route),
                alert: $store.scope(state: \.route.alert, action: \.route.alert),
                sheet: $store.scope(state: \.route.sheet, action: \.route.sheet),
                login: $store.scope(state: \.route.login, action: \.route.login),
                search: $store.scope(state: \.route.search, action: \.route.search),
                trendingOptions: $store.scope(state: \.route.trendingOptions, action: \.route.trendingOptions)
            )
        }
    }

    // swiftlint:disable function_body_length
    func content() -> some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                if store.list.models.count > 0 {
                    RefreshHeader(refreshing: $store.list.isRefreshing) {
                        store.send(.list(.refresh))
                    } label: { progress in
                        if store.list.isRefreshing {
                            SimpleHeaderRefreshingView()
                        } else {
                            SimpleHeaderIdleView(progress)
                        }
                    }
                }
                let last = store.list.models.last
                ForEach(store.list.models) { model in
                    RepoBasicCell(model) { store.send(.route(.target($0))) }
                    if model != last {
                        Separator()
                            .padding(.leading)
                    }
                }
                if store.list.models.count > 0 {
                    RefreshFooter(refreshing: $store.list.isLoadingMore) {
                        store.send(.list(.loadMore))
                    } label: {
                        if store.list.noMoreData {
                            SimpleFooterNoMoreDataView()
                        } else {
                            SimpleFooterLoadingView()
                        }
                    }
                    .noMore(store.list.noMoreData)
                    .preload(offset: 50)
                }
            }
        }
        .enableRefresh()
        .navigationTitle(store.title)
        .navigationBarTitleDisplayMode(.inline)
        .overlay { loadOverlay() }
        .onChange(of: store.profile.localization) { _ in
            store.send(.binding(.set(\.title, R.string.localizable.favorite.localizedString)))
        }
        .onAppear {
            stats(.beginPageView(name: self.className))
            if hasLoaded {
                store.send(.list(.refresh))
                return
            }
            hasLoaded = true
            store.send(.load)
        }
        .onDisappear {
            stats(.endPageView(name: self.className))
        }
    }
    // swiftlint:enable function_body_length
    
    @ViewBuilder
    func loadOverlay() -> some View {
        if store.list.isLoading {
            ProgressView()
        } else {
            if let error = store.list.error {
                ErrorView(error) { store.send(.load) }
            } else {
                EmptyView()
            }
        }
    }
    
}
