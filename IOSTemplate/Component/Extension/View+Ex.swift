//
//  View+Ex.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/11/20.
//

import SwiftUI
import AlertToast_Hi
import HiSwiftUI
import Combine
import ComposableArchitecture
import HiBase

extension View {
    
    // swiftlint:disable function_parameter_count
    func withRouteHandling(
        route: Store<RouteReducer.State, RouteReducer.Action>,
        alert: Binding<Store<AlertState<WHAlertAction>, WHAlertAction>?>,
        sheet: Binding<Store<ConfirmationDialogState<WHAlertAction>, WHAlertAction>?>,
        login: Binding<Store<LoginReducer.State, LoginReducer.Action>?>,
//        search: Binding<Store<SearchReducer.State, SearchReducer.Action>?>,
//        trendingOptions: Binding<Store<TrendingOptionsReducer.State, TrendingOptionsReducer.Action>?>
    ) -> some View {
        self
            .fullScreenCover(item: login) { LoginScreen(store: $0) }
//            .fullScreenCover(item: search) { SearchScreen(store: $0) }
//            .fullScreenCover(item: trendingOptions) { TrendingOptionsScreen(store: $0) }
            .alert(alert)
            .confirmationDialog(sheet)
            .toastActivity(isPresenting: .init(
                get: { route.isActivating },
                set: { route.send(.binding(.set(\.isActivating, $0))) }
            ))
            .toastMessage(
                isPresenting: .init(
                    get: { route.showToast },
                    set: { route.send(.binding(.set(\.showToast, $0))) }
                ),
                message: route.toastMessage
            )
//            .popup(item: .init(
//                get: { route.popup },
//                set: { route.send(.popup($0)) }
//            )) { state in
//                PopupManager.shared.popupView(for: state)
//            } customize: { param in
//                PopupManager.shared.popupParameters(for: route.popup, with: param)
//            }
    }
    // swiftlint:enable function_parameter_count
    
    func toastActivity(isPresenting: Binding<Bool>) -> some View {
        self.toast(isPresenting: isPresenting) {
            AlertToast(
                displayMode: .alert,
                type: .loading,
                style: .style(
                    backgroundColor: .primary,
                    indicatorColor: (preferenceService.value?.isDark ?? false) ? .black : .white
                )
            )
        }
    }
    
    func toastMessage(isPresenting: Binding<Bool>, message: String?) -> some View {
        self.toast(isPresenting: isPresenting) {
            AlertToast(
                displayMode: .hud,
                type: .regular,
                title: message
            )
        }
    }
    
}
