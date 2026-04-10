//
//  PersonalScreen.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/11/17.
//

import SwiftUI
import ComposableArchitecture
import AlertToast_Hi
import SwiftUIKit_Hi
import ExytePopupView
import SFSafeSymbols
import SwifterSwift
import RswiftResources
import Kingfisher
import HiBase
import HiCore
import HiNav
import HiSwiftUI
import Domain
import HiLog

struct PersonalScreen: View {
    @State var hasLoaded = false
    @Perception.Bindable var store: StoreOf<PersonalReducer>
    
    var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.route.push, action: \.route.push)) {
                EmptyView()
//                FancyScrollView(
//                    title: R.string.localizable.personal.localizedKeyString,
//                    titleColor: .clear,
//                    headerHeight: 586.0 / 780.0 * screenWidth,
//                    scrollUpHeaderBehavior: .parallax,
//                    scrollDownHeaderBehavior: .offset,
//                    header: {
//                        PersonalParallaxHeader(user: store.preference.user) { tapPageType($0) }
//                        .onTapGesture { tapUser() }
//                    },
//                    content: { content() }
//                )
//                .background(Color.surface)
//                .onChange(of: store.preference.user?.id) { _ in store.send(.load) }
//                .onChange(of: store.preference.colorTheme) { _ in store.send(.load) }
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
    
    func tapUser() {
//        if store.preference.hasLoginedUser {
//            store.send(.route(.target(HiNav.shared.deepLink(host: .preference))))
//        } else {
//            store.send(.route(.target(HiNav.shared.deepLink(host: .login))))
//        }
    }
    
    func tapPageType(_ pageType: PageType?) {
        if pageType == nil {
            store.send(.dark)
            return
        }
        store.send(.route(.target(HiNav.shared.deepLink(host: .page, parameters: [
            Parameter.owner: store.preference.user?.username ?? "",
            Parameter.index: PageType.userValues.firstIndex(of: pageType!)?.string ?? "",
            Parameter.pages: PageType.userValues.map { $0.rawValue }.jsonString() ?? ""
        ]))))
    }
    
    @ViewBuilder
    func content() -> some View {
        ScrollView {
            VStack(spacing: 0) {
                if store.preference.hasLoginedUser {
                    UserMilestoneCell($store.milestone) { }
                    TileCell(.space(height: 8))
                    ForEach(TileId.loginedValues) { id in
                        cellForLogined(id)
                    }
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
    
    @ViewBuilder
    func cellForLogined(_ id: TileId) -> some View {
        switch id {
        case .company:
            UserCompanyCell(
                store.preference.user?.companyWithDefault.1 ?? "",
                store.preference.user?.companyWithDefault.0 ?? true
            )
        case .location:
            TileCell(.init(
                id: id.id,
                icon: id.icon,
                title: store.preference.user?.location,
                separated: id.separated,
                autoLinked: false
            ))
        case .email:
            TileCell(.init(
                id: id.id,
                icon: id.icon,
                title: store.preference.user?.email,
                separated: id.separated,
                indicated: !((store.preference.user?.email?.isEmpty ?? true)),
                autoLinked: false
            )) {
                store.send(.route(.target(store.preference.user?.email?.emailLink ?? "")))
            }
        case .blog:
            TileCell(.init(
                id: id.id,
                icon: id.icon,
                title: store.preference.user?.blogWithDefault.1 ?? "",
                separated: id.separated,
                indicated: !((store.preference.user?.blog?.isEmpty ?? true)),
                autoLinked: false
            )) {
                store.send(.route(.target(store.preference.user?.blog ?? "")))
            }
        case .space:
            TileCell(.space())
        default:
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
