//
//  RMEnumType.swift
//  RealmPlatform
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

// MARK: - RMTrendingSince
enum RMEventType: String, Codable, PersistableEnum {
    case unknown = ""
    case watch = "WatchEvent"
    case fork = "ForkEvent"
    case create = "CreateEvent"
    case delete = "DeleteEvent"
    case member = "MemberEvent"
    case push = "PushEvent"
    case release = "ReleaseEvent"
    case issues = "IssuesEvent"
    case issueComment = "IssueCommentEvent"
    case commitComment = "CommitCommentEvent"
    case orgBlock = "OrgBlockEvent"
    case `public` = "PublicEvent"
    case pullRequest = "PullRequestEvent"
    case pullRequestReviewComment = "PullRequestReviewCommentEvent"
}

extension RMEventType: DomainConvertibleType {
    func asDomain() -> EventType {
        .init(rawValue: self.rawValue)!
    }
}

extension EventType: RealmRepresentable {
    internal var uid: String { "" }
    
    func asRealm() -> RMEventType {
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
