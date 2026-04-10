//
//  RealmBootstrap+MigrationTemplate.swift
//  PersistencePlatorm
//
//  Created by 杨建祥 on 2026/3/29.
//

import Foundation
import Domain
import RealmSwift

// MARK: - Errors

public enum RealmTemplateError: Error, Equatable {
    case invalidJSON
    case emptyLanguageList
    case unsupportedTemplateSchema(UInt64)
}

public enum RealmTemplateMigrationCheckError: Error, Equatable {
    case languagesMissing(expectedMinimum: Int, found: Int)
}

// MARK: - Template seed（主工程只构造 Domain 数据或传入 JSON Data）

extension RealmBootstrap {

    /// v0 模板库所需的 Domain 数据。
    public struct TemplateSeedV0: Sendable {
        public let languages: [Language]

        public init(languages: [Language]) {
            self.languages = languages
        }
    }

    /// 写入迁移模板时使用的种子数据（按 schema 版本扩展 `case`）。
    public enum TemplateSeed: Sendable {
        case v0(TemplateSeedV0)
    }

    /// 将 `languages_template_v0.json` 等（`[{ "urlParam", "name" }]`）解析为 ``Language``。
    public static func decodeLanguagesFromTemplateJSON(_ data: Data) throws -> [Language] {
        guard let raw = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
            throw RealmTemplateError.invalidJSON
        }
        let languages = raw.compactMap { Language(JSON: $0) }
        guard !languages.isEmpty else {
            throw RealmTemplateError.emptyLanguageList
        }
        return languages
    }

    /// 生成指定 **模板 schema 版本** 的配置（与 ``currentSchemaVersion`` 可不同，用于 `default-v0.realm` 等）。
    public static func makeTemplateConfiguration(fileURL: URL, schemaVersion: UInt64) -> Realm.Configuration {
        Realm.Configuration(
            fileURL: fileURL,
            schemaVersion: schemaVersion,
            migrationBlock: templateMigrationBlock(schemaVersion: schemaVersion),
            objectTypes: objectTypes
        )
    }

    /// 模板文件在「从更旧模板 schema 升到该版本」时使用的 `migrationBlock`。
    /// - v0：空实现；v1+：与线上库共用 ``RealmBootstrap/migrate(migration:oldSchemaVersion:)``。
    public static func templateMigrationBlock(schemaVersion: UInt64) -> MigrationBlock {
        if schemaVersion == 0 {
            return { _, _ in }
        }
        return { migration, oldSchemaVersion in
            migrate(migration: migration, oldSchemaVersion: oldSchemaVersion)
        }
    }

    /// 模板迁移完成后的校验闭包（`schemaVersion` 为模板文件自身的版本，如 0 表示 v0 库）。
    public static func templateMigrationCheck(schemaVersion: UInt64) -> (Realm) throws -> Void {
        switch schemaVersion {
        case 0:
            return { realm in
                let count = realm.objects(RMLanguage.self).count
                if count < 1 {
                    throw RealmTemplateMigrationCheckError.languagesMissing(expectedMinimum: 1, found: Int(count))
                }
            }
        default:
            return { _ in }
        }
    }

    /// 在写事务内将 Domain 种子写入 Realm（由 ``writeMigrationTemplateFile`` 调用）。
    public static func applyTemplateSeed(_ seed: TemplateSeed, to realm: Realm) {
        switch seed {
        case .v0(let s):
            for language in s.languages {
                realm.add(language.asRealm(), update: .modified)
            }
        }
    }

    public static func performTemplateMigrationCheck(on realm: Realm, schemaVersion: UInt64) throws {
        try templateMigrationCheck(schemaVersion: schemaVersion)(realm)
    }

    /// 创建迁移模板文件（如 `default-v0.realm`）：若 `fileURL` 已存在则先删除再写入。
    public static func writeMigrationTemplateFile(
        fileURL: URL,
        schemaVersion: UInt64,
        seed: TemplateSeed
    ) throws {
        switch seed {
        case .v0:
            guard schemaVersion == 0 else {
                throw RealmTemplateError.unsupportedTemplateSchema(schemaVersion)
            }
        }

        if FileManager.default.fileExists(atPath: fileURL.path) {
            try FileManager.default.removeItem(at: fileURL)
        }

        let configuration = makeTemplateConfiguration(fileURL: fileURL, schemaVersion: schemaVersion)
        let realm = try Realm(configuration: configuration)
        try realm.write {
            applyTemplateSeed(seed, to: realm)
        }
        try performTemplateMigrationCheck(on: realm, schemaVersion: schemaVersion)
    }
}
