//
//  AuthorizationClient.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/11/12.
//

import Combine
import SafariServices
import AuthenticationServices
import ComposableArchitecture
import Domain
import HiBase
import HiCore
import HiSwiftUI
import RswiftResources
import SwifterSwift

@DependencyClient
struct AuthorizationClient {
    let oauthCode: @MainActor @Sendable (AuthorizationPresentationContextProvider) async -> Result<String, Error>
    let oauthToken: @Sendable () async -> Result<Data, Error>
}

extension AuthorizationClient: DependencyKey {
    static var liveValue: Self {
        .init { presentation in
            guard let url = R.string.constant.appAuthorizeLink(
                Platform.github.appId
            ).url else {
                return .failure(HiError.unknown)
            }
            let scheme = UIApplication.shared.urlScheme
            guard scheme.isNotEmpty else {
                return .failure(HiError.unknown)
            }
            return await withCheckedContinuation { continuation in
                var session: ASWebAuthenticationSession?
                let handler: (URL?, Error?) -> Void = { callbackURL, error in
                    if let error = error {
                        session?.cancel()
                        continuation.resume(returning: .failure(error))
                        return
                    }
                    guard let code = callbackURL?.queryValue(for: Parameter.code) else {
                        session?.cancel()
                        continuation.resume(returning: .failure(APPError.oauth))
                        return
                    }
                    continuation.resume(returning: .success(code))
                }
                session = ASWebAuthenticationSession(
                    url: url,
                    callbackURLScheme: scheme,
                    completionHandler: handler
                )
                session?.presentationContextProvider = presentation
                session?.prefersEphemeralWebBrowserSession = true
                session?.start()
            }
        } oauthToken: {
            return .failure(HiError.unknown)
        }

    }
}

extension DependencyValues {
    var authorizationClient: AuthorizationClient {
        get { self[AuthorizationClient.self] }
        set { self[AuthorizationClient.self] = newValue }
    }
}

class AuthorizationPresentationContextProvider: NSObject, ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        UIApplication.shared.window
    }
}
