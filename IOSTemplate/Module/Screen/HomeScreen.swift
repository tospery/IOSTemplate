//
//  HomeScreen.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/3/28.
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
import Refresh_Hi
import Domain
import NetworkPlatform
import RswiftResources
import HiLog

struct HomeScreen: View {
    
    @State var hasLoaded = false
    @Perception.Bindable var store: StoreOf<HomeReducer>

    var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.route.path, action: \.route.path)) {
                content()
            } destination: {
                Path.destination($0)
            }
        }
    }
    
    // swiftlint:disable function_body_length
    func content() -> some View {
        ScrollView {
            LazyVStack(spacing: 8) {
//                if store.list.models.count > 0 {
//                    RefreshHeader(refreshing: $store.list.isRefreshing) {
//                        store.send(.list(.refresh))
//                    } label: { progress in
//                        WithPerceptionTracking {
//                            if store.list.isRefreshing {
//                                SimpleHeaderRefreshingView()
//                            } else {
//                                SimpleHeaderIdleView(progress)
//                            }
//                        }
//                    }
//                }
                ForEach(store.list.models) { model in
                    NewsCell(model) { _ in
                    }
                }
//                if store.list.models.count > 0 {
//                    RefreshFooter(refreshing: $store.list.isLoadingMore) {
//                        store.send(.list(.loadMore))
//                    } label: {
//                        WithPerceptionTracking {
//                            if store.list.noMoreData {
//                                SimpleFooterNoMoreDataView()
//                            } else {
//                                SimpleFooterLoadingView()
//                            }
//                        }
//                    }
//                    .noMore(store.list.noMoreData)
//                    .preload(offset: 50)
//                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
        }
        .enableRefresh()
        .navigationTitle(store.title)
        .navigationBarTitleDisplayMode(.inline)
        .overlay { loadOverlay() }
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
    
//    @ViewBuilder
//    func cell(_ model: Tile) -> some View {
//        let id = TileId(rawValue: model.id) ?? .space
//        if id == .logo {
//            AboutLogoCell {
//                store.send(.increment)
//            }
//        } else {
//            TileCell(model) {
//                if let target = model.target {
//                    store.send(.target(target))
//                } else {
//                    let id = TileId(rawValue: model.id) ?? .space
//                    if id == .share {
//                        share()
//                    }
//                }
//            }
//        }
//    }
//
//    func share() {
//        let title = UIApplication.shared.name
//        let content = R.string.localizable.appMessage.localizedString
//        let url = R.string.constant.appDownloadLink()
//        let avatar = R.string.constant.appOnlineLogo()
//        store.send(.target(
//            HiNav.shared.popupDeepLink(
//                PopupType.share.rawValue,
//                [
//                    Parameter.title: title,
//                    Parameter.content: content,
//                    Parameter.avatar: avatar,
//                    Parameter.url: url
//                ].jsonString() ?? ""
//            )
//        ))
//    }
    
}
