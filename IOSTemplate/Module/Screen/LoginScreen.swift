//
//  LoginScreen.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/3/4.
//

import SwiftUI
import ComposableArchitecture
import DependenciesAdditions
import SFSafeSymbols
import SwifterSwift
import AlertToast_Hi
import HiCore
import HiSwiftUI
import HiLog

struct LoginScreen: View {
    
    @Perception.Bindable var store: StoreOf<LoginReducer>
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.route.push, action: \.route.push)) {
                content()
                .navigationTitle(R.string.localizable.login.localizedStringKey)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemSymbol: .xmark)
                                .font(.system(size: 15))
                                .foregroundStyle(Color.primary)
                        }
                    }
                }
                .toolbarBackground(Color.clear, for: .navigationBar)
                .onAppear {
                    stats(.beginPageView(name: self.className))
                }
                .onDisappear {
                    stats(.endPageView(name: self.className))
                }
            } destination: {
                Push.destination($0)
            }
            .environment(\.colorScheme, (store.profile.isDark ?? false) ? .dark : .light)
            .withRouteHandling(
                route: store.scope(state: \.route, action: \.route),
                alert: $store.scope(state: \.route.alert, action: \.route.alert),
                sheet: $store.scope(state: \.route.sheet, action: \.route.sheet),
                login: $store.scope(state: \.route.login, action: \.route.login),
                search: $store.scope(state: \.route.search, action: \.route.search),
                trendingOptions: $store.scope(state: \.route.trendingOptions, action: \.route.trendingOptions)
            )
        }
    }
    
    // swiftlint:disable function_body_length
    @ViewBuilder
    func content() -> some View {
        VStack {
            Spacer()
            R.image.appLogo.swiftUIImage
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth / 3.4)
                .clipShape(.circle)
            Text(R.string.constant.loginSlogan())
                .font(.system(size: 20))
                .foregroundStyle(.primary)
                .padding(.top, 10)
            TextField(
                R.string.localizable.loginPersonalToken.localizedString,
                text: $store.personalToken.sending(\.personalToken)
            )
            .font(.system(size: 17))
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .padding(.leading, 10)
            .frame(width: screenWidth * 0.9, height: 44)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.secondary.opacity(0.4), lineWidth: 1)
            )
            .padding(.top, 20)
            Button {
                store.send(.login)
            } label: {
                Text(R.string.localizable.login.localizedStringKey)
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 46)
                    .background(Color.accentColor)
                    .clipShape(.rect(cornerRadius: 8))
            }
            .buttonStyle(.plain)
            .disabled(store.personalToken.isEmpty)
            .padding(.horizontal, screenWidth * 0.05)
            .padding(.top, 20)
            
            Text(R.string.localizable.loginPrivacyMessage.localizedStringKey)
                .font(.system(size: 11))
                .foregroundStyle(Color.secondary)
                .padding(.horizontal, screenWidth * 0.05)
                .padding(.top, 2)
            Spacer()
            R.image.github_icon.swiftUIImage
                .padding(.bottom, 10)
                .onTapGesture {
                    store.send(.oauth)
                }
            Text(R.string.localizable.loginAuth.localizedStringKey)
                .font(.system(size: 12))
                .foregroundStyle(Color.primary.opacity(0.8))
                .padding(.bottom, 10)
        }
    }
    // swiftlint:enable function_body_length
    
}

#Preview {
    LoginScreen(store: Store(initialState: LoginReducer.State.init(), reducer: {
        LoginReducer()
    }))
}

