//
//  RMEnumType.swift
//  DatabasePlatform
//
//  Created by 杨建祥 on 2024/5/15.
//

import Foundation
import Domain
import HiBase
import RealmSwift

// MARK: - PTPageType
enum RMPageType: String, Codable, CaseIterable, PersistableEnum {
    case none
    case open, closed
    case trendingRepos, repositories, stars, subscriptions, forks
    case trendingUsers, followers, following, subscribers, stargazers, contributors
    case milestone, company
    case readme
}

extension RMPageType: DomainConvertibleType {
    func asDomain() -> PageType {
        .init(rawValue: self.rawValue)!
    }
}

extension PageType: RealmRepresentable {
    internal var uid: String { "" }
    
    func asRealm() -> RMPageType {
        .init(rawValue: self.rawValue)!
    }
}

// MARK: - PTLocalization
enum RMLocalization: String, Codable, CaseIterable, PersistableEnum {
    case chinese    = "zh-Hans"
    case english    = "en"
}

extension RMLocalization: DomainConvertibleType {
    func asDomain() -> Localization {
        .init(rawValue: self.rawValue)!
    }
}

extension Localization: RealmRepresentable {
    internal var uid: String { "" }
    
    func asRealm() -> RMLocalization {
        .init(rawValue: self.rawValue)!
    }
}

// MARK: - PTColorTheme
enum RMColorTheme: String, Codable, CaseIterable, PersistableEnum {
    case red, pink, purple, deepPurple, indigo, blue, lightBlue, cyan, teal, green
    case lightGreen, lime, yellow, amber, orange, deepOrange, brown, gray, blueGray
}

extension RMColorTheme: DomainConvertibleType {
    func asDomain() -> ColorTheme {
        .init(rawValue: self.rawValue)!
    }
}

extension ColorTheme: RealmRepresentable {
    internal var uid: String { "" }
    
    func asRealm() -> RMColorTheme {
        .init(rawValue: self.rawValue)!
    }
}

// MARK: - PTUserStatus
enum RMUserStatus: String, Codable, CaseIterable, PersistableEnum {
    case activated = "Activated"
    case suspended = "Suspended"
    case deactivated = "Deactivated"
    case resigned = "Resigned"
    case archived = "Archived"
}

extension RMUserStatus: DomainConvertibleType {
    func asDomain() -> UserStatus {
        .init(rawValue: self.rawValue)!
    }
}

extension UserStatus: RealmRepresentable {
    internal var uid: String { "" }
    
    func asRealm() -> RMUserStatus {
        .init(rawValue: self.rawValue)!
    }
}

// MARK: - PTUserGender
enum RMUserGender: String, Codable, CaseIterable, PersistableEnum {
    case unknown = "U"
    case male = "M"
    case female = "F"
}

extension RMUserGender: DomainConvertibleType {
    func asDomain() -> UserGender {
        .init(rawValue: self.rawValue)!
    }
}

extension UserGender: RealmRepresentable {
    internal var uid: String { "" }
    
    func asRealm() -> RMUserGender {
        .init(rawValue: self.rawValue)!
    }
}

// MARK: - PTUserSource
enum RMUserSource: String, Codable, CaseIterable, PersistableEnum {
    case adminCreated, register, syncTask, excel
}

extension RMUserSource: DomainConvertibleType {
    func asDomain() -> UserSource {
        .init(rawValue: self.rawValue)!
    }
}

extension UserSource: RealmRepresentable {
    internal var uid: String { "" }
    
    func asRealm() -> RMUserSource {
        .init(rawValue: self.rawValue)!
    }
}
