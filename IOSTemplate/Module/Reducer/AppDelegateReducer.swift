//
//  AppDelegateReducer.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/3/28.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct AppDelegateReducer {
    
    @ObservableState
    struct State: Equatable {
        var migration = MigrationReducer.State.init()
    }

    enum Action {
        case onLaunchFinish
        case removeExpiredImageURLs

        case migration(MigrationReducer.Action)
    }

//    @Dependency(\.databaseClient) private var databaseClient
//    @Dependency(\.libraryClient) private var libraryClient
//    @Dependency(\.cookieClient) private var cookieClient

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            default:
                return .none
//            case .onLaunchFinish:
//                return .merge(
//                    .run(operation: { _ in libraryClient.initializeLogger() }),
//                    .run(operation: { _ in libraryClient.initializeWebImage() }),
//                    .run(operation: { _ in cookieClient.removeYay() }),
//                    .run(operation: { _ in cookieClient.syncExCookies() }),
//                    .run(operation: { _ in cookieClient.ignoreOffensive() }),
//                    .run(operation: { _ in cookieClient.fulfillAnotherHostField() }),
//                )
//
//            case .removeExpiredImageURLs:
//                return .run(operation: { _ in await databaseClient.removeExpiredImageURLs() })
//
//            case .migration:
//                return .none
            }
        }
        Scope(state: \.migration, action: \.migration) { MigrationReducer.init() }
        // Scope(state: \.migrationState, action: \.migration, child: MigrationReducer.init)
    }
}
