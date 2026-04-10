//
//  DatabaseMigrationService.swift
//  Domain
//
//  Created by 杨建祥 on 2026/3/29.
//

import Foundation

/// 应用内 Realm（或其它本地库）的启动准备：安装配置、触发迁移、校验版本等。
/// 由 Persistence 子模块实现；Network 侧不应使用。
public protocol DatabaseMigrationService: Sendable {

    /// 使用当前应用的 schema 配置打开默认 Realm，必要时执行迁移。
    func prepareDefaultDatabase() async -> Result<DatabaseMigrationReport, Error>
}

public struct DatabaseMigrationReport: Equatable, Sendable {
    public var schemaVersion: UInt64

    public init(schemaVersion: UInt64) {
        self.schemaVersion = schemaVersion
    }
}
