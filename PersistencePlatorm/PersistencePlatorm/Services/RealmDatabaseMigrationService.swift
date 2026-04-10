//
//  RealmDatabaseMigrationService.swift
//  PersistencePlatorm
//
//  Created by 杨建祥 on 2026/3/29.
//

import Foundation
import Domain
import RealmSwift

/// `DatabaseMigrationService` 的 Realm 实现：在后台线程打开默认 Realm 以完成迁移，避免阻塞主线程。
public struct RealmDatabaseMigrationService: DatabaseMigrationService {

    public init() {}

    public func prepareDefaultDatabase() async -> Result<DatabaseMigrationReport, Error> {
        await Task.detached(priority: .userInitiated) {
            do {
                RealmBootstrap.installDefaultRealmConfiguration()
                let configuration = Realm.Configuration.defaultConfiguration
                _ = try Realm(configuration: configuration)
                return .success(DatabaseMigrationReport(schemaVersion: configuration.schemaVersion))
            } catch {
                return .failure(error)
            }
        }.value
    }
}
