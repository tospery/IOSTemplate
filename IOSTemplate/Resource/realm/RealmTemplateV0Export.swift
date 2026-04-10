//
//  RealmTemplateV0Export.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/3/29.
//

#if SCHEMA_VERSION_0

import Foundation
import Domain
import PersistencePlatorm

/// 主工程侧入口：只负责提供 **Domain 层数据** 或 JSON，具体 `RM*` 转换与 `default-v0.realm` 写入由 ``RealmBootstrap`` 完成。
public enum RealmTemplateV0Export {

    /// 使用已解析的 ``Language`` 列表生成 v0 模板库。
    public static func writeDefaultV0Template(
        languages: [Language],
        destinationURL: URL
    ) throws {
        try RealmBootstrap.writeMigrationTemplateFile(
            fileURL: destinationURL,
            schemaVersion: 0,
            seed: .v0(.init(languages: languages))
        )
    }

    /// 使用 `languages_template_v0.json` 格式的 JSON 数据（`[{ "urlParam", "name" }]`）。
    public static func writeDefaultV0Template(
        languagesJSON data: Data,
        destinationURL: URL
    ) throws {
        let languages = try RealmBootstrap.decodeLanguagesFromTemplateJSON(data)
        try writeDefaultV0Template(languages: languages, destinationURL: destinationURL)
    }

    /// 从 Bundle 读取 `languages_template_v0.json` 并写入目标路径（如沙盒内的 `default-v0.realm`）。
    public static func writeDefaultV0TemplateFromBundle(
        bundle: Bundle = .main,
        destinationURL: URL
    ) throws {
        guard let url = bundle.url(forResource: "languages_template_v0", withExtension: "json") else {
            throw NSError(
                domain: "RealmTemplateV0Export",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "缺少 languages_template_v0.json"]
            )
        }
        let data = try Data(contentsOf: url)
        try writeDefaultV0Template(languagesJSON: data, destinationURL: destinationURL)
    }
}

#endif
