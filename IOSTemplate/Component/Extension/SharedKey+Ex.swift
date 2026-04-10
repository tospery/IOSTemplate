//
//  InMemoryKey+Ex.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/11/17.
//

import Foundation
import ComposableArchitecture
import RealmSwift
import HiBase
import Domain
import PersistencePlatorm

//extension SharedKey where Self == FileStorageKey<Domain.Preference> {
//    static var preference: Self {
//        fileStorage(.documentsDirectory.appending(component: "preference.json"))
//    }
//}

extension SharedKey where Self == RealmStorageKey<Preference, RMPreference> {
    static var preference: Self {
        realmStorage(
            .defaultConfiguration,
            primaryKey: Preference.default.id,
            toDomain: { $0.asDomain() },
            writeThrough: { $1.writeThrough(with: $0) }
        )
    }
}


//struct RealmSharedKey<Value: Sendable & Codable>: SharedKey {
//
//    // var id: ID { get }
//    
//    // MARK: - 配置项
//    static var defaultValue: Value {
//        fatalError("请在扩展中提供 defaultValue")
//    }
//
//    /// Realm 主键（默认 singleton，可自定义）
//    static var key: String {
//        "singleton"
//    }
//
//    /// Realm 配置（可覆盖）
//    static var configuration: Realm.Configuration {
//        .defaultConfiguration
//    }
//
//    // MARK: - Load
//
//    static func load() -> Value {
//        let realm = try! Realm(configuration: configuration)
//
//        guard let obj = realm.object(
//            ofType: RealmStorageObject.self,
//            forPrimaryKey: key
//        ) else {
//            return defaultValue
//        }
//
//        guard let data = obj.data,
//              let value = try? JSONDecoder().decode(Value.self, from: data)
//        else {
//            return defaultValue
//        }
//
//        return value
//    }
//
//    // MARK: - Save
//
//    static func save(_ value: Value) {
//        let realm = try! Realm(configuration: configuration)
//
//        let data = try! JSONEncoder().encode(value)
//
//        try! realm.write {
//            let obj = realm.object(
//                ofType: RealmStorageObject.self,
//                forPrimaryKey: key
//            ) ?? RealmStorageObject()
//
//            obj.id = key
//            obj.data = data
//
//            realm.add(obj, update: .modified)
//        }
//    }
//}
