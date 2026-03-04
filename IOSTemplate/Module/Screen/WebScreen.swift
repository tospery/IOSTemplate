//
//  WebScreen.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/3/4.
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
import SwiftUI_WebView_Hi
import HiLog
import WebKit

struct WebScreen: View {
    @StateObject var webViewStore = WebViewStore()
    @Perception.Bindable var store: StoreOf<WebReducer>

    var body: some View {
        WithPerceptionTracking {
            VStack(alignment: .leading, spacing: 0) {
                Color.accentColor
                    .frame(height: 1)
                    .frame(width: screenWidth * self.webViewStore.estimatedProgress)
                    .opacity(self.webViewStore.estimatedProgress == 1.0 ? 0.0 : 1.0)
                WebView(webView: webViewStore.webView)
                    .navigationTitle(
                        (webViewStore.title?.isEmpty ?? true)
                        ? R.string.localizable.loading.localizedString
                        : webViewStore.title!
                    )
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar(.hidden, for: .tabBar)
                    .ignoresSafeArea()
                    .onAppear {
                        stats(.beginPageView(name: self.className))
                        self.webViewStore.webView.load(
                            URLRequest(url: store.url.url ?? UIApplication.shared.baseWebUrl.url!)
                        )
                    }
                    .onDisappear {
                        stats(.endPageView(name: self.className))
                    }
            }
        }
    }
    
}
