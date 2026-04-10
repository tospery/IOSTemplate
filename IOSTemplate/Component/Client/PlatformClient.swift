//
//  PlatformClient.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/3/28.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import Domain
import NetworkPlatform
import PersistencePlatorm
import RealmSwift

@DependencyClient
struct PlatformClient {
    
//    var network: @Sendable () async -> Domain.ServiceProvider = {
//        NetworkPlatform.ServiceProvider(environment: environment)
//    }
//    var persistence: @Sendable () async -> Domain.ServiceProvider = {
//        PersistencePlatorm.ServiceProvider(configuration: .defaultConfiguration)
//    }
    
    let network: @Sendable () async -> Domain.ServiceProvider
    let persistence: @Sendable () async -> Domain.ServiceProvider
    
}

extension PlatformClient: DependencyKey {
    static var liveValue: Self {
        .init(network: {
            NetworkPlatform.ServiceProvider(environment: environment)
        }, persistence: {
            PersistencePlatorm.ServiceProvider(configuration: .defaultConfiguration)
        })
    }
}

extension DependencyValues {
    var platformClient: PlatformClient {
        get { self[PlatformClient.self] }
        set { self[PlatformClient.self] = newValue }
    }
}
