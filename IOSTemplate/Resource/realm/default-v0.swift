//
//  default-v0.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/10/15.
//

// #if REALM_SCHEMA_VERSION_0

import Foundation
import Combine
import RealmSwift
import DatabasePlatform
import Domain
import HiBase
import HiCore
import ObjectMapper

let schemaVersion = 0

let migrationBlock: MigrationBlock = { _, _ in }

func migrationCheck(_ configuration: Realm.Configuration) -> AnyPublisher<Void, Error> {
    let provider: Domain.ServiceProvider = DatabasePlatform.ServiceProvider(configuration: configuration)
    return Publishers.CombineLatest(
        //provider.urlSchemeService().urlSchemes(),
        provider.languageService().languages(),
        provider.preferenceService().preference()
    ).tryMap { languages, preference in
        //guard urlSchemes.count == 3 else { throw IOSTemplate.APPError.seedSchemesFailed }
        guard languages.count == 472 else { throw IOSTemplate.APPError.seedLanguagesFailed }
        guard preference?.isValid ?? false else { throw IOSTemplate.APPError.seedDefaultCurrentFailed }
        return ()
    }.eraseToAnyPublisher()
}

func exampleData(_ configuration: Realm.Configuration) -> AnyPublisher<Void, Error> {
    let provider: Domain.ServiceProvider = DatabasePlatform.ServiceProvider(configuration: configuration)
    // swiftlint:disable force_try
//    let urlSchemes = try! [URLScheme].init(
//        JSONString: String(
//            contentsOfFile: Bundle.main.path(forResource: "URLSchemeList", ofType: "json")!,
//            encoding: .utf8
//        )
//    )!
    let languages = try! [Language].init(
        JSONString: String(
            contentsOfFile: Bundle.main.path(forResource: "LanguageList", ofType: "json")!,
            encoding: .utf8
        )
    )!
    // swiftlint:enable force_try
//    let urlSchemesPublisher = provider.urlSchemeService().save(urlSchemes: urlSchemes)
//        .map { _ in () }
//        .eraseToAnyPublisher()
    let languagesPublisher = provider.languageService().save(languages: languages)
        .map { _ in () }
        .eraseToAnyPublisher()
    let preferencePublisher = provider.preferenceService().save(preference: .default)
        .map { _ in () }
        .eraseToAnyPublisher()
//    return urlSchemesPublisher
//        .append(languagesPublisher)
//        .append(preferencePublisher)
//        .eraseToAnyPublisher()
    return languagesPublisher
        .append(preferencePublisher)
        .eraseToAnyPublisher()
}

// #endif
