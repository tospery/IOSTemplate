//
//  MigrationReducer.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/3/28.
//

import Foundation
import ComposableArchitecture
import Domain
import PersistencePlatorm
import HiSwiftUI

@Reducer
struct MigrationReducer {
    @CasePathable
    enum Route: Equatable {
        case dropDialog
    }

    @ObservableState
    struct State: Equatable {
        var route: Route?
        var status = ProcessingStatus.loading
        /// 最近一次成功迁移后的 schema 版本（便于调试展示）。
        var appliedSchemaVersion: UInt64?
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case setNavigation(Route?)
        case load
        case prepareDatabaseDone(error: APPError?, schemaVersion: UInt64?)
        case dropDatabase
        case dropDatabaseDone(APPError?)
        case databaseInitialized(Result<Domain.Preference, Error>)
        // case models(Result<[Model], Error>)
    }

    // @Dependency(\.platformClient) private var platformClient
    @Dependency(\.platformClient) var platformClient
    private enum CancelID { case load }

    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                return .none

            case .setNavigation(let route):
                state.route = route
                return .none

            case .load:
                state.status = .loading
                RealmBootstrap.prepareSeedFileIfNeed()
                RealmBootstrap.installDefaultRealmConfiguration()
                return .run { send in
                    await send(.databaseInitialized(
                        await self.platformClient.persistence().preferenceService().preference().asResult()
                    ))
                }.cancellable(id: CancelID.load)
                
            case let .databaseInitialized(.success(preference)):
                Appdata.shared.inject(preference)
                Runtime.shared.work()
                Library.shared.setup()
                Appearance.shared.config()
                logEnvironment()
//                let str = "http://m.iostemplate.com/about/ssso?showlogo=true&numbers=1"
//                let aaa = str.deepLink
                state.status = .success
                return .none
            case let .databaseInitialized(.failure(error)):
                // log("样本数据库失败: \(error)")
                return .none

            case .prepareDatabaseDone(let error, let schemaVersion):
                state.appliedSchemaVersion = schemaVersion
                if let error {
                    state.status = .failure(error)
                    return .none
                }
                state.status = .success
                return .none

            case .dropDatabase:
                return .none

            case .dropDatabaseDone:
                return .none
            }
        }
    }
}
