//
//  UserScreen.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/12/11.
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
import HiLog

struct UserScreen: View {
    
    @State var hasLoaded = false
    @Perception.Bindable var store: StoreOf<UserReducer>

    var body: some View {
        WithPerceptionTracking {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(store.models) { cell($0) }
                }
            }
            .enableRefresh()
            .background(Color.surface)
            .navigationTitle(store.title.localizedString)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .tabBar)
            .toolbar { ToolbarItem(placement: .topBarTrailing) { follow() } }
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
            .overlay { loadOverlay() }
            .overlay(alignment: .bottomTrailing) { shareOverlay() }
        }
    }
    
    @ViewBuilder
    func loadOverlay() -> some View {
        if store.isLoading {
            ProgressView()
        } else {
            if let error = store.error {
                ErrorView(error) { store.send(.load) }
            } else {
                EmptyView()
            }
        }
    }
    
    @ViewBuilder
    func shareOverlay() -> some View {
//        R.image.native_share_icon.swiftUIImage
//            .resizable()
//            .frame(width: metric(40), height: metric(40))
//            .padding(.trailing, 20)
//            .padding(.bottom, 30)
//            .opacity((store.user?.isValid ?? false) ? 1.0 : 0.0)
//            .onTapGesture {
//                share()
//            }
    }
    
    @ViewBuilder
    func cell(_ model: AnyModel) -> some View {
        if let user = model.base as? User {
            if user.pageType == .milestone {
                WithPerceptionTracking {
                    UserMilestoneCell($store.milestone) { }
                }
                TileCell(.space(height: 8))
            } else if user.pageType == .company {
                UserCompanyCell(user.companyWithDefault.1, user.companyWithDefault.0)
            } else {
                UserDetailCell(user) { mode in
                    store.send(.target(
                        HiNav.shared.deepLink(host: .page, parameters: [
                            Parameter.owner: store.owner,
                            Parameter.index: PageType.userValues.firstIndex(of: mode)?.string ?? "",
                            Parameter.pages: PageType.userValues.map { $0.rawValue }.jsonString() ?? ""
                        ])
                    ))
                }
            }
        } else if let tile = model.base as? Tile {
            TileCell(tile) {
                guard let target = tile.target else { return }
                store.send(.target(target))
            }
        } else {
            EmptyView()
        }
    }
    
    func follow() -> some View {
        Button {
            if store.isFollowed == nil {
                return
            }
            store.send(.follow(!(store.isFollowed ?? false)))
        } label: {
            if store.isFollowed ?? false {
                Image(systemSymbol: .personBadgeMinus)
                    .font(.system(size: 15))
                    .foregroundStyle(Color.primary)
            } else {
                Image(systemSymbol: .personFillBadgePlus)
                    .font(.system(size: 15))
                    .foregroundStyle(Color.primary)
            }
        }
    }
    
    func share() {
        guard let url = store.user?.htmlUrl, url.isNotEmpty else { return }
        guard let avatar = store.user?.avatar?.url else { return }
        let username = store.user?.username ?? ""
        let nickname = store.user?.nicknameWithDefault.1 ?? ""
        let title = "\(nickname)（\(username)）"
        let content = store.user?.bio ?? R.string.localizable.noneBio.localizedString
        store.send(.target(
            HiNav.shared.popupDeepLink(
                PopupType.share.rawValue,
                [
                    Parameter.title: title,
                    Parameter.content: content,
                    Parameter.avatar: avatar.absoluteString,
                    Parameter.url: url
                ].jsonString() ?? ""
            )
        ))
    }
    
}
