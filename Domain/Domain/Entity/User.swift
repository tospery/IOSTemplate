//
//  User.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/15.
//

import Foundation
import ObjectMapper
import HiBase

public struct User: UserType {
    
    public var id = ""
    public var userid: String?
    public var href: String?
    public var sponsorUrl: String?
    public var url: String?
    public var bio: String?
    public var blog: String?
    public var company: String?
    public var createdAt: String?
    public var email: String?
    public var eventsUrl: String?
    public var followersUrl: String?
    public var followingUrl: String?
    public var gistsUrl: String?
    public var gravatarId: String?
    public var htmlUrl: String?
    public var location: String?
    public var nodeId: String?
    public var organizationsUrl: String?
    public var receivedEventsUrl: String?
    public var reposUrl: String?
    public var starredUrl: String?
    public var subscriptionsUrl: String?
    public var type: String?
    public var updatedAt: String?
    public var hireable: String?
    public var password: String?
    public var twitterUsername: String?
    public var siteAdmin: Bool?
    public var twoFactorAuthentication: Bool?
    public var followers: Int?
    public var following: Int?
    public var diskUsage: Int?
    public var privateGists: Int?
    public var publicGists: Int?
    public var publicRepos: Int?
    public var collaborators: Int?
    public var ownedPrivateRepos: Int?
    public var totalPrivateRepos: Int?
    public var ranking: Int?
    public var username: String?       // username|login
    public var nickname: String?       // name
    public var avatar: String?         // avatar|avatar_url
    // 扩展字段
    public var sortNumber: Int?
    public var pageType: PageType?

    public var isValid: Bool { (!id.isEmpty) && !(username?.isEmpty ?? true) }

    
    public init() { }
    
    public init?(map: ObjectMapper.Map) { }
    
    public mutating func mapping(map: ObjectMapper.Map) {
        id                      <- (map["id"], StringTransform.shared)
        siteAdmin               <- (map["site_admin"], BoolTransform.shared)
        twoFactorAuthentication <- (map["two_factor_authentication"], BoolTransform.shared)
        followers               <- (map["followers"], IntTransform.shared)
        following               <- (map["following"], IntTransform.shared)
        diskUsage               <- (map["disk_usage"], IntTransform.shared)
        privateGists            <- (map["private_gists"], IntTransform.shared)
        publicRepos             <- (map["public_repos"], IntTransform.shared)
        collaborators           <- (map["collaborators"], IntTransform.shared)
        ownedPrivateRepos       <- (map["owned_private_repos"], IntTransform.shared)
        totalPrivateRepos       <- (map["total_private_repos"], IntTransform.shared)
        ranking                 <- (map["ranking"], IntTransform.shared)
        publicGists             <- (map["public_gists"], IntTransform.shared)
        sortNumber              <- (map["sortNumber"], IntTransform.shared)
        pageType                <- (map["pageType"], EnumTypeCastTransform<PageType>())
        password                <- (map["password"], StringTransform.shared)
        href                    <- (map["href"], StringTransform.shared)
        nickname                <- (map["name"], StringTransform.shared)
        sponsorUrl              <- (map["sponsorUrl"], StringTransform.shared)
        url                     <- (map["url"], StringTransform.shared)
        bio                     <- (map["bio"], StringTransform.shared)
        blog                    <- (map["blog"], StringTransform.shared)
        company                 <- (map["company"], StringTransform.shared)
        createdAt               <- (map["created_at"], StringTransform.shared)
        email                   <- (map["email"], StringTransform.shared)
        eventsUrl               <- (map["events_url"], StringTransform.shared)
        followersUrl            <- (map["followers_url"], StringTransform.shared)
        followingUrl            <- (map["following_url"], StringTransform.shared)
        gistsUrl                <- (map["gists_url"], StringTransform.shared)
        gravatarId              <- (map["gravatar_id"], StringTransform.shared)
        hireable                <- (map["hireable"], StringTransform.shared)
        htmlUrl                 <- (map["html_url"], StringTransform.shared)
        location                <- (map["location"], StringTransform.shared)
        nodeId                  <- (map["node_id"], StringTransform.shared)
        organizationsUrl        <- (map["organizations_url"], StringTransform.shared)
        receivedEventsUrl       <- (map["received_events_url"], StringTransform.shared)
        reposUrl                <- (map["repos_url"], StringTransform.shared)
        starredUrl              <- (map["starred_url"], StringTransform.shared)
        subscriptionsUrl        <- (map["subscriptions_url"], StringTransform.shared)
        twitterUsername         <- (map["twitter_username"], StringTransform.shared)
        type                    <- (map["type"], StringTransform.shared)
        updatedAt               <- (map["updated_at"], StringTransform.shared)
        username                <- (map["username"], StringTransform.shared)
        if username == nil {
            username            <- (map["login"], StringTransform.shared)
        }
        avatar                  <- (map["avatar"], StringTransform.shared)
        if avatar == nil {
            avatar              <- (map["avatar_url"], StringTransform.shared)
        }
        if id.isEmpty {
            id                  = username ?? email ?? nickname ?? ""
        }
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.avatar == rhs.avatar &&
        lhs.username == rhs.username &&
        lhs.nickname == rhs.nickname &&
        lhs.bio == rhs.bio &&
        lhs.publicRepos == rhs.publicRepos &&
        lhs.followers == rhs.followers &&
        lhs.following == rhs.following &&
        lhs.company == rhs.company &&
        lhs.location == rhs.location &&
        lhs.email == rhs.email &&
        lhs.blog == rhs.blog &&
        lhs.ranking == rhs.ranking &&
        lhs.sortNumber == rhs.sortNumber &&
        lhs.updatedAt == rhs.updatedAt &&
        lhs.createdAt == rhs.createdAt
    }
    
    public func copyWith(id: String) -> User {
        var myUser = self
        myUser.id = id
        return myUser
    }
    
    public func copyWith(pageType: PageType?) -> User {
        var myUser = self
        myUser.pageType = pageType
        return myUser
    }
    
    public func copyWith(sortNumber: Int?) -> User {
        var myUser = self
        myUser.sortNumber = sortNumber
        return myUser
    }
    
}
