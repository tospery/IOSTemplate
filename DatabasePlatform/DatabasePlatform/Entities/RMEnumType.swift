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

// MARK: - RMPageType
enum RMPageType: String, Codable, PersistableEnum {
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

// MARK: - RMSearchType
enum RMSearchType: String, Codable, PersistableEnum {
    case repositories, users
    
    static let allValues = [repositories, users]
}

extension RMSearchType: DomainConvertibleType {
    func asDomain() -> SearchType {
        .init(rawValue: self.rawValue)!
    }
}

extension SearchType: RealmRepresentable {
    internal var uid: String { "" }
    
    func asRealm() -> RMSearchType {
        .init(rawValue: self.rawValue)!
    }
}

// MARK: - RMLocalization
enum RMLocalization: String, Codable, PersistableEnum {
    case chinese    = "zh-Hans"
    case english    = "en"
    
    public static let allValues = [chinese, english]
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

// MARK: - RMColorTheme
enum RMColorTheme: String, Codable, PersistableEnum {
    case red, pink, purple, deepPurple, indigo, blue, lightBlue, cyan, teal, green
    case lightGreen, lime, yellow, amber, orange, deepOrange, brown, gray, blueGray

    public static let allValues = [
        red, pink, purple, deepPurple, indigo, blue, lightBlue, cyan, teal, green,
        lightGreen, lime, yellow, amber, orange, deepOrange, brown, gray, blueGray
    ]
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

// MARK: - RMTrendingSince
enum RMTrendingSince: String, Codable, PersistableEnum {
    case daily, weekly, montly
    
    static let allValues = [daily, weekly, montly]
}

extension RMTrendingSince: DomainConvertibleType {
    func asDomain() -> TrendingSince {
        .init(rawValue: self.rawValue)!
    }
}

extension TrendingSince: RealmRepresentable {
    internal var uid: String { "" }
    
    func asRealm() -> RMTrendingSince {
        .init(rawValue: self.rawValue)!
    }
}
