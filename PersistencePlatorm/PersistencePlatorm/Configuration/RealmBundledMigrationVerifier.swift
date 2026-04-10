//
//  RealmBundledMigrationVerifier.swift
//  PersistencePlatorm
//
//  Created by 杨建祥 on 2026/3/29.
//

import Foundation
import RealmSwift

/// 对齐官方 `Migration` 示例中 `AppDelegate.performMigration()`：将 Bundle 内 `default-v0.realm`、`default-v1.realm` … 复制到沙盒，再按当前应用配置执行 `Realm.performMigration`。
///
/// 将各版本模板加入 App 的 **Copy Bundle Resources** 后，在调试或测试中调用 ``runIfAllTemplatesPresent(in:)``。
public enum RealmBundledMigrationVerifier {

    /// 若缺少任一 `default-v{0..<current}` 资源则直接返回；否则依次迁移并打开校验。
    public static func runIfAllTemplatesPresent(in bundle: Bundle = .main) throws {
        let current = Int(RealmBootstrap.currentSchemaVersion)
        guard current > 0 else { return }

        for old in 0..<current {
            let name = "default-v\(old)"
            guard bundle.url(forResource: name, withExtension: "realm") != nil else {
                return
            }
        }

        let baseURL = Realm.Configuration.defaultConfiguration.fileURL!
            .deletingLastPathComponent()

        for old in 0..<current {
            let url = try copyBundledTemplate(schema: old, bundle: bundle, destinationDirectory: baseURL)
            let configuration = RealmBootstrap.makeAppConfiguration(fileURL: url)
            try Realm.performMigration(for: configuration)
            _ = try Realm(configuration: configuration)
        }
    }

    private static func copyBundledTemplate(
        schema old: Int,
        bundle: Bundle,
        destinationDirectory: URL
    ) throws -> URL {
        let fileName = "default-v\(old)"
        let destination = destinationDirectory.appendingPathComponent("\(fileName).migration-self-test.realm")
        if FileManager.default.fileExists(atPath: destination.path) {
            try FileManager.default.removeItem(at: destination)
        }
        guard let bundleURL = bundle.url(forResource: fileName, withExtension: "realm") else {
            throw NSError(
                domain: "RealmBundledMigrationVerifier",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "缺少 bundle 资源 \(fileName).realm"]
            )
        }
        try FileManager.default.copyItem(at: bundleURL, to: destination)
        return destination
    }
}
