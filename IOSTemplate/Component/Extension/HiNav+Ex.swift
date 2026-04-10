//
//  HiNav+Ex.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/11/14.
//

import Foundation
import Combine
import SwiftUI
import ComposableArchitecture
import SwifterSwift
import HiBase
import HiCore
import HiNav
import HiSwiftUI
import HiLog
import Domain

@Reducer(state: .equatable)
enum Push {
    case about(AboutReducer)
    case settings(SettingsReducer)
    case colorThemeList(ColorThemeListReducer)
    case localizationList(LocalizationListReducer)
    case page(PageReducer)
    case languageList(LanguageListReducer)
    case user(UserReducer)
    case web(WebReducer)
    
    @ViewBuilder
    static func destination(_ store: Store<Push.State, Push.Action>) -> some View {
        switch store.case {
        case let .about(store): AboutScreen(store: store)
        case let .settings(store): SettingsScreen(store: store)
        case let .colorThemeList(store): ColorThemeListScreen(store: store)
        case let .localizationList(store): LocalizationListScreen(store: store)
        case let .page(store): PageScreen(store: store)
        case let .languageList(store): LanguageListScreen(store: store)
        case let .user(store): UserScreen(store: store)
        case let .web(store): WebScreen(store: store)
        }
    }
}

extension HiNavHost {
    
    static var trending: HiNavHost { "trending" }
    static var eventList: HiNavHost { "events" }
    static var favorite: HiNavHost { "favorite" }
    static var personal: HiNavHost { "personal" }
    
    static var page: HiNavHost { "page" }
    static var userList: HiNavHost { "users" }
    static var repoList: HiNavHost { "repos" }
    static var languageList: HiNavHost { "languages" }
    
    static var about: HiNavHost { TileId.about.rawValue.lowercased() }
    static var settings: HiNavHost { TileId.settings.rawValue.lowercased() }
    static var urlSchemes: HiNavHost { TileId.urlSchemes.rawValue.lowercased() }
    static var colorTheme: HiNavHost { TileId.colorTheme.rawValue.lowercased() }
    static var localization: HiNavHost { TileId.localization.rawValue.lowercased() }
    
    static let webValues = [
        about, settings
    ]
}

extension HiNavPath { }


extension HiNav: @retroactive HiNavCompatible {
    
    public func isLegalHost(host: HiNavHost) -> Bool {
        true
    }
    
    public func allowedPaths(host: HiNavHost) -> [HiNavPath] {
        []
    }
    
    public func isLogined() -> Bool {
        preferenceService.value?.loginedUser?.isValid ?? false
    }
    
    public func needLogin(host: HiNavHost, path: HiNavPath?) -> Bool {
        switch host {
        case .eventList, .favorite, .page: return true
        default: return false
        }
    }
    
    // swiftlint:disable function_body_length
    public func resolution(_ target: String) -> Any? {
        log("target: \(target)")
        if target.isValidWebUrl {
            if target.isValidUnivLink {
                return nil
            }
            
            let isFile = target.url?.queryParameters?.bool(for: Parameter.isFile)
            var params = target.url?.queryParameters ?? [:]
            params.removeValue(forKey: Parameter.isFile)
            var url = target.url?.deletingAllQueryParameters()
            if params.count != 0 {
                url = url?.myAppendingQueryParameters(params)
            }
            let urlString = url?.absoluteString ?? ""
            
            guard urlString.isValidInternalWebUrl else {
                return IOSTemplate.Push.State.web(.init(url: self.deepLink(host: .web, parameters: [
                    Parameter.url: urlString
                ])))
            }
            var native = ""
            var paths = urlString.url?.pathComponents ?? []
            paths.removeAll("/")
            
            if paths.count == 1 {
                native = self.deepLink(host: .user, parameters: [
                    Parameter.owner: paths[0]
                ])
            } else if paths.count == 2 {
//                native = self.deepLink(host: .repo, parameters: [
//                    Parameter.owner: paths[0],
//                    Parameter.repo: paths[1]
//                ])
            } else if paths.count == 3 {
//                if paths.last == HiNavHost.contentList {
//                    native = self.deepLink(host: .contentList, parameters: [
//                        Parameter.owner: paths[0],
//                        Parameter.repo: paths[1],
//                        Parameter.ref: urlString.url?.queryParameters?.string(for: Parameter.ref) ?? ""
//                    ])
//                } else if paths.last == HiNavHost.issueList || paths.last == HiNavHost.pullList {
//                    native = self.deepLink(host: .page, parameters: [
//                        Parameter.owner: paths[0],
//                        Parameter.repo: paths[1],
//                        Parameter.pages: PageType.stateValues.map { $0.rawValue }.jsonString() ?? "",
//                        Parameter.title: (paths.last ?? "").capitalizedFirstCharacter.localizedString
//                    ])
//                }
            } else {
//                if paths[2].lowercased() == "blob" || paths[2].lowercased() == "tree" {
//                    if target.isValidMarkdownUrl {
//                        native = self.deepLink(host: .markdown, parameters: [
//                            Parameter.url: urlString
//                        ])
//                    } else if target.isValidImageUrl {
//                        native = self.deepLink(host: .web, parameters: [
//                            Parameter.url: urlString.decorateURLStringForRaw
//                        ])
//                    } else if target.isValidPDFUrl {
//                        native = self.deepLink(host: .pdf, parameters: [
//                            Parameter.url: urlString.decorateURLStringForRaw
//                        ])
//                    } else {
//                        if isFile == true {
//                            native = self.deepLink(host: .code, parameters: [
//                                Parameter.url: urlString.decorateURLStringForRaw
//                            ])
//                        } else {
//                            let last = paths.last?.lowercased() ?? ""
//                            let parts = last.components(separatedBy: ".")
//                            log("last: \(last), parts: \(parts)")
//                            if parts.count <= 1 {
//                                stats(.parseFileOrDirectory(urlString: target))
//                                if ["license", "readme", "cloudify_server"].contains(last) || last.hasSuffix("file") {
//                                    native = self.deepLink(host: .code, parameters: [
//                                        Parameter.url: urlString.decorateURLStringForRaw
//                                    ])
//                                } else {
//                                    native = self.deepLink(host: .contentList, parameters: [
//                                        Parameter.owner: paths[0],
//                                        Parameter.repo: paths[1],
//                                        Parameter.subpath: paths[4...].joined(separator: "/"),
//                                        Parameter.ref: urlString.url?.queryParameters?
//                                            .string(for: Parameter.ref) ?? paths[3]
//                                    ])
//                                }
//                            } else {
//                                native = self.deepLink(host: .code, parameters: [
//                                    Parameter.url: urlString.decorateURLStringForRaw
//                                ])
//                            }
//                        }
//                    }
//                } else if paths[2].lowercased() == HiNavHost.branchList && paths[3].lowercased() == "all" {
//                    native = self.popupDeepLink(PopupType.branchList.rawValue, [
//                        Parameter.owner: paths[0],
//                        Parameter.repo: paths[1]
//                    ].jsonString() ?? "")
//                }
            }
            if native.isNotEmpty {
                native = native.url?.myAppendingQueryParameters([Parameter.fromWeb: true.string]).absoluteString ?? ""
                return self.handleDeepLink(native)
            }
            return IOSTemplate.Push.State.web(.init(url: self.deepLink(host: .web, parameters: [
                Parameter.url: urlString
            ])))
        } else {
            guard target.isValidDeepLink else {
                return target
            }
            return self.handleDeepLink(target)
        }
    }
    // swiftlint:enable function_body_length
    
    // swiftlint:disable function_body_length
    func handleDeepLink(_ target: String) -> Any? {
        guard target.isValidDeepLink else { return nil }
        guard let url = target.url else { return nil }
        log("内部URL: \(url)")
        // let fromWeb = target.url?.queryParameters?.bool(for: Parameter.fromWeb) ?? false
        if target.isValidBackUrl {
            let type = url.queryParameters?.enum(for: Parameter.type, type: BackType.self) ?? .auto
            return BackState(type: type)
        }
        
        guard let host = url.host()?.lowercased() else { return nil }
        var forwardType = url.queryParameters?.enum(for: Parameter.forwardType, type: ForwardType.self)
        if forwardType == nil {
            if host == .login {
                forwardType = .present
            } else if target.isValidOpenUrl {
                forwardType = .open
            } else {
                forwardType = .push
            }
        }
        switch forwardType! {
        case .push:
            switch host {
            case HiNavHost.about: return IOSTemplate.Push.State.about(.init(url: target))
            case HiNavHost.settings: return IOSTemplate.Push.State.settings(.init(url: target))
            case HiNavHost.colorTheme: return IOSTemplate.Push.State.colorThemeList(.init(url: target))
            case HiNavHost.localization: return IOSTemplate.Push.State.localizationList(.init(url: target))
            case HiNavHost.page: return IOSTemplate.Push.State.page(.init(url: target))
            case HiNavHost.languageList: return IOSTemplate.Push.State.languageList(.init(url: target))
            case HiNavHost.user: return IOSTemplate.Push.State.user(.init(url: target))
            case HiNavHost.web: return IOSTemplate.Push.State.web(.init(url: target))
            default: break
            }
        case .present:
            if host == .login { return LoginReducer.State.init() }
        case .open:
            if target.isValidToastUrl {
                let message = url.queryParameters?.string(for: Parameter.message) ?? ""
                let active = url.queryParameters?.bool(for: Parameter.active)
                return ToastState.init(message: message, active: active)
            } else if target.isValidAlertUrl {
                let title = url.queryParameters?.string(for: Parameter.title) ?? ""
                let message = url.queryParameters?.string(for: Parameter.message) ?? ""
                var state = AlertState<WHAlertAction>.init {
                    TextState(title)
                } message: {
                    TextState(message)
                }
                let jsonString = url.queryParameters?.string(for: Parameter.actions) ?? ""
                let jsonObject = try? jsonString.data(using: .utf8)?.jsonObject()
                let myActions = jsonObject as? [String] ?? []
                state.buttons = myActions
                    .compactMap { WHAlertAction(string: $0) }
                    .map { action in
                        ButtonState<WHAlertAction>.init(
                            role: action.role,
                            action: action,
                            label: {
                                TextState(action.description)
                            }
                        )
                    }
                return state
            } else if target.isValidSheetUrl {
                let title = url.queryParameters?.string(for: Parameter.title) ?? ""
                let message = url.queryParameters?.string(for: Parameter.message) ?? ""
                var state = ConfirmationDialogState<WHAlertAction>.init {
                    TextState(title)
                } message: {
                    TextState(message)
                }
                let jsonString = url.queryParameters?.string(for: Parameter.actions) ?? ""
                let jsonObject = try? jsonString.data(using: .utf8)?.jsonObject()
                let myActions = jsonObject as? [String] ?? []
                state.buttons = myActions
                    .compactMap { WHAlertAction(string: $0) }
                    .map { action in
                        ButtonState<WHAlertAction>.init(
                            role: action.role,
                            action: action,
                            label: {
                                TextState(action.description)
                            }
                        )
                    }
                return state
            } else if target.isValidPopupUrl {
                let type = url.queryParameters?.string(for: Parameter.type) ?? ""
                let data = url.queryParameters?.string(for: Parameter.data)
                return PopupState.init(type: type, data: data)
            } else if target.isValidLogicUrl {
                guard let value = url.queryParameters?.string(for: Parameter.type) else { return nil }
                guard let type = LogicType(rawValue: value) else { return nil }
                return handleLogic(type, url.queryParameters?.string(for: Parameter.data) ?? "")
            }
        }
        return nil
    }
    // swiftlint:enable function_body_length
    
    func handleLogic(_ type: LogicType, _ data: String) -> Any? {
#if ALIYUN_ENABLE
        guard type == .contact else { return nil }
        guard let topName = UIViewController.topMost?.className, topName.isNotEmpty else { return nil }
        log("打开客服页面时，当前的topMost为：\(topName)")
        guard topName != "BCFeedbackViewController" else { return nil }

        let dict = data.dictionary
        let username = dict.string(for: Parameter.username) ?? ""
        
        let feedback = OCHelper.sharedInstance().feedbackKit
        feedback.extInfo = dict
        feedback.setUserNick(username)
        feedback.makeFeedbackViewController { viewController, error in
            if let error = error?.asHiError {
                guard let url = HiNav.shared.toastMessageDeepLink(error.localizedDescription).url else { return }
                UIApplication.shared.open(url, options: [:])
                return
            }
            viewController?.closeBlock = { parent in
                parent?.dismiss(animated: true)
            }
            let nav = NavigationController.init(rootViewController: viewController!)
            UIViewController.topMost?.present(nav, animated: true)
        }
#endif
        return nil
    }

}
