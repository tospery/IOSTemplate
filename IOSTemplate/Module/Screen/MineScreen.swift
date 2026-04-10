//
//  MineScreen.swift
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
import Domain
import NetworkPlatform
import RswiftResources
import FancyScrollView_Hi
import HiLog

struct MineScreen: View {
    @State var hasLoaded = false
    @Perception.Bindable var store: StoreOf<MineReducer>
    
    var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.route.path, action: \.route.path)) {
                FancyScrollView(
                    title: R.string.localizable.mine.localizedKeyString,
                    titleColor: .clear,
                    headerHeight: 586.0 / 780.0 * screenWidth,
                    scrollUpHeaderBehavior: .parallax,
                    scrollDownHeaderBehavior: .offset,
                    header: {
                        MineParallaxView(user: store.preference.user) { tapPageType($0) }
                        .onTapGesture { tapUser() }
                    },
                    content: { content() }
                )
                .background(Color.surface)
                .onChange(of: store.preference.user?.id) { _ in store.send(.load) }
                .onChange(of: store.preference.colorTheme) { _ in store.send(.load) }
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
            } destination: {
                Path.destination($0)
            }
            .withRouteHandling(
                route: store.scope(state: \.route, action: \.route),
                alert: $store.scope(state: \.route.alert, action: \.route.alert),
                sheet: $store.scope(state: \.route.sheet, action: \.route.sheet),
                login: $store.scope(state: \.route.login, action: \.route.login)
//                search: $store.scope(state: \.route.search, action: \.route.search),
//                trendingOptions: $store.scope(state: \.route.trendingOptions, action: \.route.trendingOptions)
            )
//            .withRouteHandling(
//                route: store.scope(state: \.route, action: \.route),
//                alert: $store.scope(state: \.route.alert, action: \.route.alert),
//                sheet: $store.scope(state: \.route.sheet, action: \.route.sheet)
//            )
        }
    }
    
    func tapUser() {
        store.send(.route(.target(HiNav.shared.deepLink(host: .login))))
//        if store.profile.hasLoginedUser {
//            store.send(.route(.target(HiNav.shared.deepLink(host: .profile))))
//        } else {
//            store.send(.route(.target(HiNav.shared.deepLink(host: .login))))
//        }
    }
    
    func tapPageType(_ pageType: PageType?) {
//        guard let pageType = pageType else {
//            store.send(.route(.target(HiNav.shared.deepLink(host: .page, parameters: [
//                Parameter.owner: store.profile.user?.username ?? "",
//                Parameter.index: PageType.userValues.firstIndex(of: pageType!)?.string ?? "",
//                Parameter.pages: PageType.userValues.map { $0.rawValue }.jsonString() ?? ""
//            ]))))
//            return
//        }
//        store.send(.dark)
    }
    
    @ViewBuilder
    func content() -> some View {
        ScrollView {
            VStack(spacing: 0) {
                if store.preference.hasLoginedUser {
//                    UserMilestoneCell($store.milestone) { }
//                    TileCell(.space(height: 8))
//                    ForEach(TileId.loginedValues) { id in
//                        cellForLogined(id)
//                    }
                } else {
                    ForEach(TileId.unloginValues) { id in
                        TileCell(.init(
                            id: id.id,
                            icon: id.icon,
                            title: id.description,
                            separated: id.separated,
                            indicated: true
                        )) {
                            store.send(.route(.target(id.target ?? "")))
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: screenHeight - (586.0 / 780.0 * screenWidth) - tabBarHeight)
        .background(Color.surface)
    }
    
//    @ViewBuilder
//    func cellForLogined(_ id: TileId) -> some View {
//        switch id {
//        case .company:
//            UserCompanyCell(
//                store.profile.user?.companyWithDefault.1 ?? "",
//                store.profile.user?.companyWithDefault.0 ?? true
//            )
//        case .location:
//            TileCell(.init(
//                id: id.id,
//                icon: id.icon,
//                title: store.profile.user?.location,
//                separated: id.separated,
//                autoLinked: false
//            ))
//        case .email:
//            TileCell(.init(
//                id: id.id,
//                icon: id.icon,
//                title: store.profile.user?.email,
//                separated: id.separated,
//                indicated: !((store.profile.user?.email?.isEmpty ?? true)),
//                autoLinked: false
//            )) {
//                store.send(.route(.target(store.profile.user?.email?.emailLink ?? "")))
//            }
//        case .blog:
//            TileCell(.init(
//                id: id.id,
//                icon: id.icon,
//                title: store.profile.user?.blogWithDefault.1 ?? "",
//                separated: id.separated,
//                indicated: !((store.profile.user?.blog?.isEmpty ?? true)),
//                autoLinked: false
//            )) {
//                store.send(.route(.target(store.profile.user?.blog ?? "")))
//            }
//        case .space:
//            TileCell(.space())
//        default:
//            TileCell(.init(
//                id: id.id,
//                icon: id.icon,
//                title: id.description,
//                separated: id.separated,
//                indicated: true
//            )) {
//                store.send(.route(.target(id.target ?? "")))
//            }
//        }
//    }
    
}
