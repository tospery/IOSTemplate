//
//  ApplicationClient.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/3/8.
//

import UIKit
import Combine
import SafariServices
import AuthenticationServices
import ComposableArchitecture
import Domain
import HiBase
import HiCore
import HiSwiftUI

@DependencyClient
struct ApplicationClient {
    
    /// Returns a Boolean value that indicates whether an app is available to handle a URL scheme.
    @MainActor
    public func canOpenURL(_ url: URL) -> Bool {
        UIApplication.shared.canOpenURL(url)
    }

    /// Attempts to asynchronously open the resource at the specified URL.
    @MainActor
    public func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any] = [:]) async -> Bool {
        await UIApplication.shared.open(url, options: options)
    }
    
}

extension ApplicationClient: DependencyKey {
    static var liveValue: Self { .init() }
}

extension DependencyValues {
    var applicationClient: ApplicationClient {
        get { self[ApplicationClient.self] }
        set { self[ApplicationClient.self] = newValue }
    }
}
