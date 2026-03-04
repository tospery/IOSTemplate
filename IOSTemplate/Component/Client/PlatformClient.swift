//
//  PlatformClient.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/3/4.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import Domain
import NetworkPlatform
import RealmPlatform
import RealmSwift

@DependencyClient
struct PlatformClient {
    
    var network: @Sendable () async -> Domain.ServiceProvider = {
        await NetworkPlatform.ServiceProvider(environment: environment)
    }
    var database: @Sendable () async -> Domain.ServiceProvider = {
        RealmPlatform.ServiceProvider(configuration: .defaultConfiguration)
    }
    
}

extension PlatformClient: DependencyKey {
    static var liveValue: Self {
        .init()
    }
}

extension DependencyValues {
    var platformClient: PlatformClient {
        get { self[PlatformClient.self] }
        set { self[PlatformClient.self] = newValue }
    }
}
