//
//  LoginScreen.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/4/7.
//

import SwiftUI
import ComposableArchitecture
import SFSafeSymbols
import SwifterSwift
import AlertToast_Hi
import HiCore
import HiSwiftUI
import HiLog
import Domain
import RswiftResources

struct LoginScreen: View {
    
    @State var hasLoaded = false
    @Perception.Bindable var store: StoreOf<LoginReducer>
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.route.path, action: \.route.path)) {
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
                Path.destination($0)
            }
            .environment(\.colorScheme, (store.preference.isDark ?? false) ? .dark : .light)
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
    
    // swiftlint:disable function_body_length
    @ViewBuilder
    func content() -> some View {
        ZStack(alignment: .top) {
            backgroundView
//            ScrollView(showsIndicators: false) {
//                sloganView
//                inputView
//                loginButton
//                helperActions
//                agreementView
//                Spacer()
//                thirdPartyLogin
//            }
            VStack {
                sloganView
                inputView
                loginButton
                helperActions
                agreementView
                Spacer()
                thirdPartyLogin
            }
            .frame(maxWidth: .infinity)
            .frame(height: screenHeight - navigationContentTopConstant)
            // .frame(maxWidth: .infinity, maxHeight: .infinity)
            // .padding(.top, 10)
        }
//        VStack {
//            Spacer()
//            R.image.brand_icon.swiftUIImage
//                .resizable()
//                .scaledToFit()
//                .frame(width: screenWidth / 3.4)
//                .clipShape(.circle)
//            Text(R.string.constant.loginSlogan())
//                .font(.system(size: 20))
//                .foregroundStyle(.primary)
//                .padding(.top, 10)
//            TextField(
//                R.string.localizable.loginPersonalToken.localizedString,
//                text: $store.personalToken.sending(\.personalToken)
//            )
//            .font(.system(size: 17))
//            .textInputAutocapitalization(.never)
//            .autocorrectionDisabled()
//            .padding(.leading, 10)
//            .frame(width: screenWidth * 0.9, height: 44)
//            .background(
//                RoundedRectangle(cornerRadius: 8)
//                    .stroke(Color.secondary.opacity(0.4), lineWidth: 1)
//            )
//            .padding(.top, 20)
//            Button {
//                store.send(.login)
//            } label: {
//                Text(R.string.localizable.login.localizedStringKey)
//                    .font(.system(size: 18))
//                    .foregroundColor(.white)
//                    .frame(maxWidth: .infinity)
//                    .frame(height: 46)
//                    .background(Color.accentColor)
//                    .clipShape(.rect(cornerRadius: 8))
//            }
//            .buttonStyle(.plain)
//            .disabled(store.personalToken.isEmpty)
//            .padding(.horizontal, screenWidth * 0.05)
//            .padding(.top, 20)
//            
//            Text(R.string.localizable.loginPrivacyMessage.localizedStringKey)
//                .font(.system(size: 11))
//                .foregroundStyle(Color.secondary)
//                .padding(.horizontal, screenWidth * 0.05)
//                .padding(.top, 2)
//            Spacer()
//            R.image.github_icon.swiftUIImage
//                .padding(.bottom, 10)
//                .onTapGesture {
//                    store.send(.oauth)
//                }
//            Text(R.string.localizable.loginAuth.localizedStringKey)
//                .font(.system(size: 12))
//                .foregroundStyle(Color.primary.opacity(0.8))
//                .padding(.bottom, 10)
//        }
    }
    // swiftlint:enable function_body_length
    
    var backgroundView: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color.blue.opacity(0.2),
                Color.white
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
    
    var sloganView: some View {
        VStack {
            R.image.brand_icon.swiftUIImage
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth / 3.4)
                .clipShape(.circle)
            Text(R.string.localizable.loginSlogan())
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(.primary)
                .padding(.top, 10)
        }
        .padding(.top, metric(32))
    }
    
    var inputView: some View {
        VStack(spacing: 12) {
            HStack {
                TextField(R.string.localizable.loginPlaceholderAccount(), text: $store.account)
                    .font(.system(size: 17))
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding(.leading, 12)
                    .padding(.trailing, 12)
            }
            .frame(width: screenWidth * 0.9, height: 44)
            .background(Color.white)
            .clipShape(.rect(cornerRadius: 8))
            HStack {
                Group {
                    if store.isSecure {
                        SecureField(R.string.localizable.loginPlaceholderPassword(), text: $store.password)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                    } else {
                        TextField(R.string.localizable.loginPlaceholderPassword(), text: $store.password)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                    }
                }
                .padding(.leading, 12)
                Button {
                    store.isSecure.toggle()
                } label: {
                    Image(systemSymbol: store.isSecure ? .eyeSlash : .eye)
                }
                .padding(.trailing, 12)
            }
            .frame(width: screenWidth * 0.9, height: 44)
            .background(Color.white)
            .clipShape(.rect(cornerRadius: 8))
        }
        .padding(.top, metric(16))
    }
    
    var loginButton: some View {
        Button {
            // login action
        } label: {
            Text(R.string.localizable.login.localizedStringKey)
                .font(.system(size: 18))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 46)
                .background(Color.accentColor)
                .clipShape(.rect(cornerRadius: 8))
//            Text("登录")
//                .frame(maxWidth: .infinity)
//                .frame(height: 50)
//                .background(Color.blue)
//                .foregroundColor(.white)
//                .cornerRadius(25)
        }
        .buttonStyle(.plain)
        .disabled(store.account.isEmpty || store.password.isEmpty)
        .padding(.horizontal, screenWidth * 0.05)
        .padding(.top, 20)
    }
    
    var helperActions: some View {
        HStack {
            Button(R.string.localizable.loginForgot()) {
                
            }
                .foregroundColor(.gray)
            Spacer()
            Button {
                
            } label: {
                HStack(spacing: 4) {
                    Text(R.string.localizable.loginSMSCode())
                    Image(systemSymbol: .chevronRight)
                }
            }
            .foregroundColor(.gray)
        }
        .font(.system(size: 14))
        .padding(.horizontal, screenWidth * 0.05)
        .padding(.top, 8)
    }
    
    var agreementView: some View {
        HStack(alignment: .top, spacing: 6) {
            Button {
                store.isAgree.toggle()
            } label: {
                Image(systemSymbol: store.isAgree ? .checkmarkCircleFill : .circle)
                    .foregroundColor(store.isAgree ? .blue : .gray)
            }
            Text(agreementAttributedText())
                .font(.system(size: 12))
                .foregroundColor(.gray)
        }
        .padding(.horizontal, screenWidth * 0.05)
        .padding(.top, 12)
    }
    
    var thirdPartyLogin: some View {
        HStack(spacing: metric(32)) {
            Button {
                
            } label: {
                R.image.weixin_icon.swiftUIImage
                    .resizable()
                    .frame(width: metric(48), height: metric(48))
            }
            Button {
                
            } label: {
                R.image.alipay_icon.swiftUIImage
                    .resizable()
                    .frame(width: metric(48), height: metric(48))
            }
        }
        .padding(.bottom, safeArea.bottom)
    }
    
    private func agreementAttributedText() -> AttributedString {
        var text = AttributedString("勾选表示同意")
        var terms = AttributedString("《海尔智能家居服务条款》")
        terms.link = URL(string: "https://example.com/terms")
        terms.foregroundColor = .blue
        let and = AttributedString("和")
        var privacy = AttributedString("《个人信息保护政策》")
        privacy.link = URL(string: "https://example.com/privacy")
        privacy.foregroundColor = .blue
        let tail = AttributedString("，第三方授权信息仅为快捷登录使用，首次登录我们仍需获取您的手机号进行身份验证。")
        text.append(terms)
        text.append(and)
        text.append(privacy)
        text.append(tail)
        return text
    }
    
}
