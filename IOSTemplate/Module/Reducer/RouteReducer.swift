//
//  AppRoute.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/10/6.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import HiBase
import HiCore
import HiNav
import HiSwiftUI
import Domain
import HiLog
import SwifterSwift

// swiftlint:disable type_body_length
@Reducer
struct RouteReducer {
    
    @ObservableState
    struct State: Equatable {
        @Shared(.preference) var preference = .default
        @Presents var login: LoginReducer.State?
        @Presents var alert: AlertState<WHAlertAction>?
        @Presents var sheet: ConfirmationDialogState<WHAlertAction>?
        var popup: PopupState?
        var push = StackState<IOSTemplate.Push.State>()
        var isActivating = false
        var showToast = false
        var toastMessage: String?
        var redirection: String?
        var data: Any?
        var shareURLString = ""
    
        static func == (lhs: State, rhs: State) -> Bool {
            lhs.preference == rhs.preference
            && lhs.login == rhs.login
            && lhs.alert == rhs.alert
            && lhs.sheet == rhs.sheet
            && lhs.popup == rhs.popup
            && lhs.push == rhs.push
            && lhs.isActivating == rhs.isActivating
            && lhs.showToast == rhs.showToast
            && lhs.toastMessage == rhs.toastMessage
            && lhs.redirection == rhs.redirection
            && compareAny(lhs.data, rhs.data)
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case login(PresentationAction<LoginReducer.Action>)
        case alert(PresentationAction<WHAlertAction>)
        case sheet(PresentationAction<WHAlertAction>)
        case popup(PopupState?)
        case push(StackActionOf<IOSTemplate.Push>)
        case toastMessage(String)
        case target(String)
    }
    
    @Dependency(\.continuousClock) var clock
    @Dependency(\.applicationClient) var application
    @Dependency(\.platformClient) var platformClient
    // @Dependency(\.clipboardClient) var clipboardClient
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
            case .login(.dismiss):
                guard let redirection = state.redirection, redirection.isNotEmpty else { return .none }
                state.redirection = nil
                if state.preference.hasLoginedUser {
                    log("登录成功，需重定向: \(redirection)")
                    return .run { send in
                        await send(.target(redirection))
                    }
                }
                return .none
            case .alert(.presented(.default)):
                if let effect = handleAlertForColorTheme(&state, action) {
                    return effect
                }
                if let effect = handleAlertForLocalization(&state, action) {
                    return effect
                }
                return .none
            case .sheet(.presented(.exit)):
                log("关闭了退出框")
                var preference = state.preference
                preference.user = nil
                preference.accessToken = nil
                // state.preference = preference // YJX_TODO
                return .run { send in
                    await send(.target(HiNav.shared.backDeepLink()))
                }
            case let .popup(popup):
                if let popupState = state.popup {
                    PopupManager.shared.remove(popupState)
//                    if state.type == PopupType.share.rawValue {
//                        return .run { send in
//                            await send(.target(HiNav.shared.toastMessageDeepLink(
//                                R.string.localizable.toastCopyMessage.localizedString
//                            )))
//                        }
//                    }
                }
                state.popup = popup
                return .none
//            case let .data(data):
//                state.data = data
//                return .none
            case let .push(.element(id: _, action: .settings(.target(target)))),
                let .push(.element(id: _, action: .about(.target(target)))),
                let .push(.element(id: _, action: .colorThemeList(.target(target)))),
                let .push(.element(id: _, action: .localizationList(.target(target)))),
                let .push(.element(id: _, action: .languageList(.target(target)))),
                let .push(.element(id: _, action: .page(.target(target)))),
                let .push(.element(id: _, action: .user(.target(target)))):
                return .run { send in
                    await send(.target(target))
                }
            case let .push(.element(id: _, action: .colorThemeList(.data(data)))),
                let .push(.element(id: _, action: .localizationList(.data(data)))):
                state.data = data
                return .none
            case let .toastMessage(message):
                state.toastMessage = message
                state.isActivating = false
                state.showToast = true
                return .none
            case let .target(target):
                let result = HiNav.shared.parse(target)
                let should = HiNav.shared.checkNeedLogin(target) && !HiNav.shared.isLogined()
                if let effect = self.routeForward(&state, action, target, result, should) {
                    return effect
                }
                if let effect = self.routeBack(&state, action, target, result, should) {
                    return effect
                }
                if let effect = self.routeExternalURL(&state, action, target, result, should) {
                    return effect
                }
                return .none
            default:
                // log("未处理的action: \(action)")
                return .none
            }
        }
        .forEach(\.push, action: \.push)
        .ifLet(\.$alert, action: \.alert)
        .ifLet(\.$sheet, action: \.sheet)
        .ifLet(\.$login, action: \.login) { LoginReducer() }
//        .ifLet(\.$search, action: \.search) { SearchReducer() }
//        .ifLet(\.$trendingOptions, action: \.trendingOptions) { TrendingOptionsReducer() }
    }
    
    func routeBack(
        _ state: inout State, _ action: Action, _ target: String, _ result: Any?, _ should: Bool
    ) -> Effect<Action>? {
        guard let back = result as? BackState else { return nil }
        if back.type == .auto || back.type == .popOne {
            _ = state.push.popLast()
            return .none
        }
        return .none
    }
    
    func routeForward(
        _ state: inout State, _ action: Action, _ target: String, _ result: Any?, _ should: Bool
    ) -> Effect<Action>? {
        if let effect = self.routeForwardPush(&state, action, target, result, should) {
            return effect
        }
        if let effect = self.routeForwardPresent(&state, action, target, result, should) {
            return effect
        }
        if let effect = self.routeForwardOpen(&state, action, target, result, should) {
            return effect
        }
        return nil
    }
    
    func routeForwardPresent(
        _ state: inout State, _ action: Action, _ target: String, _ result: Any?, _ should: Bool
    ) -> Effect<Action>? {
        if let login = result as? LoginReducer.State {
            state.login = login
            return .none
        }
//        if let trendingOptions = result as? TrendingOptionsReducer.State {
//            state.trendingOptions = trendingOptions
//            return .none
//        }
//        if let search = result as? SearchReducer.State {
//            state.search = search
//            return .none
//        }
        return nil
    }
    
    func routeForwardPush(
        _ state: inout State, _ action: Action, _ target: String, _ result: Any?, _ should: Bool
    ) -> Effect<Action>? {
        guard let path = result as? IOSTemplate.Push.State else { return nil }
        if should {
            log("未登录，需要登录后再继续: \(target)")
            state.redirection = target
            return .run { send in
                await send(.target(HiNav.shared.deepLink(host: .login)))
            }
        }
        state.push.append(path)
        return .none
    }
    
    func routeForwardOpen(
        _ state: inout State, _ action: Action, _ target: String, _ result: Any?, _ should: Bool
    ) -> Effect<Action>? {
        if let effect = self.routeForwardOpenToast(&state, action, target, result, should) {
            return effect
        }
        if let effect = self.routeForwardOpenAlert(&state, action, target, result, should) {
            return effect
        }
        if let effect = self.routeForwardOpenSheet(&state, action, target, result, should) {
            return effect
        }
        if let effect = self.routeForwardOpenPopup(&state, action, target, result, should) {
            return effect
        }
        return nil
    }
    
    func routeForwardOpenToast(
        _ state: inout State, _ action: Action, _ target: String, _ result: Any?, _ should: Bool
    ) -> Effect<Action>? {
        guard let toast = result as? ToastState else { return nil }
        if let active = toast.active {
            return .run { send in
                await send(.binding(.set(\.isActivating, active)))
            }
        }
        return .run { send in
            await send(.toastMessage(toast.message))
        }
    }
    
    func routeForwardOpenAlert(
        _ state: inout State, _ action: Action, _ target: String, _ result: Any?, _ should: Bool
    ) -> Effect<Action>? {
        guard let alert = result as? AlertState<WHAlertAction> else { return nil }
        state.alert = alert
        return .none
    }
    
    func routeForwardOpenSheet(
        _ state: inout State, _ action: Action, _ target: String, _ result: Any?, _ should: Bool
    ) -> Effect<Action>? {
        guard let sheet = result as? ConfirmationDialogState<WHAlertAction> else { return nil }
        state.sheet = sheet
        return .none
    }
    
    func routeForwardOpenPopup(
        _ state: inout State, _ action: Action, _ target: String, _ result: Any?, _ should: Bool
    ) -> Effect<Action>? {
        guard let popup = result as? PopupState else { return nil }
        state.popup = popup
        return .none
    }
    
    func routeExternalURL(
        _ state: inout State, _ action: Action, _ target: String, _ result: Any?, _ should: Bool
    ) -> Effect<Action>? {
        guard let urlString = result as? String else { return nil }
        return .run { send in
            guard let url = urlString.url else { return }
            if await self.application.canOpenURL(url) {
                _ = await self.application.open(url, options: [:])
            } else {
                log("无法处理外部链接：\(target)")
                // await self.clipboardClient.saveText(urlString)
                await send(.toastMessage(R.string.localizable.toastCopyMessage.localizedString))
            }
        }
    }
    
    func handleAlertForColorTheme(_ state: inout State, _ action: Action) -> Effect<Action>? {
        guard let colorTheme = state.data as? ColorTheme else { return nil }
        var preference = state.preference
        preference.colorTheme = colorTheme
        // state.preference = preference // YJX_TODO
        return .run { send in
            await send(.target(HiNav.shared.backDeepLink()))
            await send(.target(
                HiNav.shared.toastMessageDeepLink(R.string.localizable.toastThemeMessage.localizedString)
            ))
        }
    }
    
    func handleAlertForLocalization(_ state: inout State, _ action: Action) -> Effect<Action>? {
        guard let localization = state.data as? HiBase.Localization else { return nil }
        var preference = state.preference
        preference.localization = localization
        // state.preference = preference // YJX_TODO
        return .run { send in
            await send(.target(HiNav.shared.backDeepLink()))
            await send(.target(
                HiNav.shared.toastMessageDeepLink(R.string.localizable.toastLocalizationMessage.localizedString)
            ))
        }
    }
    
}
// swiftlint:enable type_body_length
