//
//  RepoListScreen.swift
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
import Refresh_Hi
import HiLog

struct RepoListScreen: View {
    let action: (String) -> Void
    @Perception.Bindable var store: StoreOf<RepoListReducer>
    @State var hasLoaded = false
    
    init(store: StoreOf<RepoListReducer>, action: @escaping (String) -> Void) {
        self.store = store
        self.action = action
    }

    var body: some View {
        WithPerceptionTracking {
            content()
            .ignoresSafeArea(.all, edges: .bottom)
            .onAppear {
                stats(.beginPageView(name: self.className))
                if hasLoaded {
                    return
                }
                hasLoaded = true
                store.send(.load)
            }
            .onDisappear {
                stats(.endPageView(name: self.className))
            }
            .onChange(
                of: "\(store.preference.trendingSince ?? .daily)/\((store.preference.trendingLanguage ?? .any).id)"
            ) { _ in
                if store.list.page != .trendingRepos {
                    return
                }
                store.send(.list(.refresh))
            }
        }
    }
    
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
                    RepoBasicCell(model) { action($0) }
                    if model != last {
                        Separator()
                            .padding(.leading)
                    }
                }
                if store.list.shouldLoadMore {
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
        }
        .enableRefresh()
        .background(Color.surface)
        .overlay { loadOverlay() }
    }
    
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
