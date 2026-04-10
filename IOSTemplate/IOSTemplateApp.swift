//
//  IOSTemplateApp.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/3/8.
//

import SwiftUI
import ComposableArchitecture
import SFSafeSymbols
import AlertToast_Hi
import HiSwiftUI
import HiBase
import HiNav
import HiLog
import Domain

@main
struct WillHubApp: App {
    
    @Shared(.preference) var preference = .default
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        Appdata.shared.inject(preference)
        Runtime.shared.work()
        Library.shared.setup()
        Appearance.shared.config()
        logEnvironment()
    }

    var body: some Scene {
        WindowGroup {
            RootScreen(store: Store(initialState: RootReducer.State.init(), reducer: {
                RootReducer()
            }))
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                logEnvironment()
                handleClipboard()
            }
        }
    }
    
    func handleClipboard() {
//        guard let text = UIPasteboard.general.string, text.isNotEmpty else { return }
//        guard text.isValidInternalWebUrl else { return }
//        guard let url = text.url else { return }
//        var paths = url.pathComponents
//        paths.removeAll("/")
//        var owner = ""
//        var repo = ""
//        if paths.count == 1 {
//            owner = paths.first!
//        } else if paths.count == 2 {
//            owner = paths.first!
//            repo = paths.last!
//        } else {
//            return
//        }
//        if owner.isEmpty {
//            return
//        }
//        let string = HiNav.shared.popupDeepLink(PopupType.clipboard.rawValue, [
//            Parameter.owner: owner,
//            Parameter.repo: repo
//        ].jsonString() ?? "")
//        guard let link = string.url else { return }
//        UIApplication.shared.open(link, options: [:])
    }

}
