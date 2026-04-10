//
//  ShopScreen.swift
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
import HiLog

struct ShopScreen: View {
    
    @Perception.Bindable var store: StoreOf<ShopReducer>

    var body: some View {
        WithPerceptionTracking {
            ScrollView {
//                VStack(spacing: 0) {
//                    ForEach(store.list.models) { cell($0) }
//                }
                VStack {
                    Spacer()
                    Text("Shop")
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .frame(minHeight: screenHeight)
            }
            .background(Color.surface)
            .navigationTitle(R.string.localizable.shop.localizedStringKey)
            .navigationBarTitleDisplayMode(.inline)
            //.toolbar(.hidden, for: .tabBar)
            .onAppear {
                stats(.beginPageView(name: self.className))
                store.send(.load)
            }
            .onDisappear {
                stats(.endPageView(name: self.className))
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
