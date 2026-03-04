//
//  RMUser.swift
//  RealmPlatform
//
//  Created by 杨建祥 on 2024/5/15.
//

import Foundation
import ObjectMapper
import RealmSwift
import Domain
import HiBase
import HiRealm

class RMUser: Object, Mappable {
    
    @Persisted(primaryKey: true) var id: String
    @Persisted var userid: String?
    @Persisted var href: String?
    @Persisted var sponsorUrl: String?
    @Persisted var url: String?
    @Persisted var bio: String?
    @Persisted var blog: String?
    @Persisted var company: String?
    @Persisted var createdAt: String?
    @Persisted var email: String?
    @Persisted var eventsUrl: String?
    @Persisted var followersUrl: String?
    @Persisted var followingUrl: String?
    @Persisted var gistsUrl: String?
    @Persisted var gravatarId: String?
    @Persisted var htmlUrl: String?
    @Persisted var location: String?
    @Persisted var nodeId: String?
    @Persisted var organizationsUrl: String?
    @Persisted var receivedEventsUrl: String?
    @Persisted var reposUrl: String?
    @Persisted var starredUrl: String?
    @Persisted var subscriptionsUrl: String?
    @Persisted var type: String?
    @Persisted var updatedAt: String?
    @Persisted var hireable: String?
    @Persisted var password: String?
    @Persisted var twitterUsername: String?
    @Persisted var siteAdmin: Bool?
    @Persisted var twoFactorAuthentication: Bool?
    @Persisted var followers: Int?
    @Persisted var following: Int?
    @Persisted var diskUsage: Int?
    @Persisted var privateGists: Int?
    @Persisted var publicGists: Int?
    @Persisted var publicRepos: Int?
    @Persisted var collaborators: Int?
    @Persisted var ownedPrivateRepos: Int?
    @Persisted var totalPrivateRepos: Int?
    @Persisted var ranking: Int?
    @Persisted var username: String?
    @Persisted var nickname: String?
    @Persisted var avatar: String?
    @Persisted var sortNumber: Int?
    @Persisted var pageType: RMPageType?
    
    override init() {
        super.init()
    }
    
    required init?(map: ObjectMapper.Map) {
        super.init()
        id                          <- (map["id"], StringTransform.shared)
        if id.isEmpty {
            id                      <- (map["username"], StringTransform.shared)
        }
        if id.isEmpty {
            id                      <- (map["email"], StringTransform.shared)
        }
        if id.isEmpty {
            id                      <- (map["name"], StringTransform.shared)
        }
    }
    
    func mapping(map: ObjectMapper.Map) {
        performMapping {
            id                      >>> map["id"]
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
            pageType                <- (map["pageType"], EnumTypeCastTransform<RMPageType>())
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
                (username ?? email ?? nickname ?? "")   >>> map["id"]
            }
        }
    }
    
    override class func propertiesMapping() -> [String: String] {
        [
            "siteAdmin": "site_admin",
            "twoFactorAuthentication": "two_factor_authentication",
            "diskUsage": "disk_usage",
            "privateGists": "private_gists",
            "publicRepos": "public_repos",
            "ownedPrivateRepos": "owned_private_repos",
            "totalPrivateRepos": "total_private_repos",
            "publicGists": "public_gists",
            "createdAt": "created_at",
            "eventsUrl": "events_url",
            "followersUrl": "followers_url",
            "followingUrl": "following_url",
            "gistsUrl": "gists_url",
            "gravatarId": "gravatar_id",
            "htmlUrl": "html_url",
            "nodeId": "node_id",
            "organizationsUrl": "organizations_url",
            "receivedEventsUrl": "received_events_url",
            "reposUrl": "repos_url",
            "starredUrl": "starred_url",
            "subscriptionsUrl": "subscriptions_url",
            "twitterUsername": "twitter_username",
            "updatedAt": "updated_at"
        ]
    }
}

extension RMUser: DomainConvertibleType {
    func asDomain() -> Domain.User {
        .init(JSON: toJSON())!
    }
}

extension Domain.User: RealmRepresentable {
    internal var uid: String { "" }
    
    func asRealm() -> RMUser {
        .init(JSON: toJSON())!
    }
}
