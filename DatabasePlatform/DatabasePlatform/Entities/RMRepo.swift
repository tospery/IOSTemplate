//
//  RMRepo.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/18.
//

import Foundation
import ObjectMapper
import RealmSwift
import Domain
import HiBase
import HiRealm

class RMRepo: Object, Mappable {
    
    @Persisted(primaryKey: true) var id: String
    @Persisted var nodeId: String?
    @Persisted var url: String?
    @Persisted var desc: String?
    @Persisted var language: String?
    @Persisted var languageColor: String?
    @Persisted var archiveUrl: String?
    @Persisted var assigneesUrl: String?
    @Persisted var blobsUrl: String?
    @Persisted var branchesUrl: String?
    @Persisted var cloneUrl: String?
    @Persisted var collaboratorsUrl: String?
    @Persisted var commentsUrl: String?
    @Persisted var commitsUrl: String?
    @Persisted var compareUrl: String?
    @Persisted var contentsUrl: String?
    @Persisted var contributorsUrl: String?
    @Persisted var createdAt: String?
    @Persisted var defaultBranch: String?
    @Persisted var deploymentsUrl: String?
    @Persisted var downloadsUrl: String?
    @Persisted var eventsUrl: String?
    @Persisted var forksUrl: String?
    @Persisted var gitCommitsUrl: String?
    @Persisted var gitRefsUrl: String?
    @Persisted var gitTagsUrl: String?
    @Persisted var gitUrl: String?
    @Persisted var homepage: String?
    @Persisted var hooksUrl: String?
    @Persisted var htmlUrl: String?
    @Persisted var issueCommentUrl: String?
    @Persisted var issueEventsUrl: String?
    @Persisted var issuesUrl: String?
    @Persisted var keysUrl: String?
    @Persisted var labelsUrl: String?
    @Persisted var languagesUrl: String?
    @Persisted var mergesUrl: String?
    @Persisted var milestonesUrl: String?
    @Persisted var mirrorUrl: String?
    @Persisted var notificationsUrl: String?
    @Persisted var pullsUrl: String?
    @Persisted var pushedAt: String?
    @Persisted var releasesUrl: String?
    @Persisted var sshUrl: String?
    @Persisted var stargazersUrl: String?
    @Persisted var statusesUrl: String?
    @Persisted var subscribersUrl: String?
    @Persisted var subscriptionUrl: String?
    @Persisted var svnUrl: String?
    @Persisted var tagsUrl: String?
    @Persisted var teamsUrl: String?
    @Persisted var tempCloneToken: String?
    @Persisted var treesUrl: String?
    @Persisted var updatedAt: String?
    @Persisted var name: String?
    @Persisted var fullname: String?
    @Persisted var ownerAuthor: String?
    @Persisted var ownerAvatar: String?
    @Persisted var `private`: Bool?
    @Persisted var archived: Bool?
    @Persisted var disabled: Bool?
    @Persisted var fork: Bool?
    @Persisted var hasDownloads: Bool?
    @Persisted var hasIssues: Bool?
    @Persisted var hasPages: Bool?
    @Persisted var hasProjects: Bool?
    @Persisted var hasWiki: Bool?
    @Persisted var currentPeriodStars: Int?
    @Persisted var networkCount: Int?
    @Persisted var openIssues: Int?
    @Persisted var subscribers: Int?
    @Persisted var size: Int?
    @Persisted var watchers: Int?
    @Persisted var forks: Int?
    @Persisted var stars: Int?
    @Persisted var ranking: Int?
    @Persisted var owner: RMBaseUser?
    @Persisted var builtBy: RealmSwift.List<RMBaseUser>
    @Persisted var sortNumber: Int?
    @Persisted var pageType: RMPageType?
    
    override init() {
        super.init()
    }
    
    required init?(map: ObjectMapper.Map) {
        super.init()
        id                      <- (map["id"], StringTransform.shared)
        if id.isEmpty {
            id                  <- (map["node_id"], StringTransform.shared)
        }
        if id.isEmpty {
            id                  <- (map["full_name"], StringTransform.shared)
        }
        if id.isEmpty {
            id                  <- (map["url"], StringTransform.shared)
        }
    }
    
    func mapping(map: ObjectMapper.Map) {
        performMapping {
            id                  >>> map["id"]
            nodeId              <- (map["node_id"], StringTransform.shared)
            url                 <- (map["url"], StringTransform.shared)
            name                <- (map["name"], StringTransform.shared)
            desc                <- (map["description"], StringTransform.shared)
            language            <- (map["language"], StringTransform.shared)
            languageColor       <- (map["languageColor"], StringTransform.shared)
            archiveUrl          <- (map["archive_url"], StringTransform.shared)
            assigneesUrl        <- (map["assignees_url"], StringTransform.shared)
            blobsUrl            <- (map["blobs_url"], StringTransform.shared)
            branchesUrl         <- (map["branches_url"], StringTransform.shared)
            cloneUrl            <- (map["clone_url"], StringTransform.shared)
            collaboratorsUrl    <- (map["collaborators_url"], StringTransform.shared)
            commentsUrl         <- (map["comments_url"], StringTransform.shared)
            commitsUrl          <- (map["commits_url"], StringTransform.shared)
            compareUrl          <- (map["compare_url"], StringTransform.shared)
            contentsUrl         <- (map["contents_url"], StringTransform.shared)
            contributorsUrl     <- (map["contributors_url"], StringTransform.shared)
            createdAt           <- (map["created_at"], StringTransform.shared)
            defaultBranch       <- (map["default_branch"], StringTransform.shared)
            deploymentsUrl      <- (map["deployments_url"], StringTransform.shared)
            downloadsUrl        <- (map["downloads_url"], StringTransform.shared)
            eventsUrl           <- (map["events_url"], StringTransform.shared)
            forksUrl            <- (map["forks_url"], StringTransform.shared)
            gitCommitsUrl       <- (map["git_commits_url"], StringTransform.shared)
            gitRefsUrl          <- (map["git_refs_url"], StringTransform.shared)
            gitTagsUrl          <- (map["git_tags_url"], StringTransform.shared)
            gitUrl              <- (map["git_url"], StringTransform.shared)
            homepage            <- (map["homepage"], StringTransform.shared)
            hooksUrl            <- (map["hooks_url"], StringTransform.shared)
            issueCommentUrl     <- (map["issue_comment_url"], StringTransform.shared)
            issueEventsUrl      <- (map["issue_events_url"], StringTransform.shared)
            issuesUrl           <- (map["issues_url"], StringTransform.shared)
            keysUrl             <- (map["keys_url"], StringTransform.shared)
            labelsUrl           <- (map["labels_url"], StringTransform.shared)
            language            <- (map["language"], StringTransform.shared)
            languagesUrl        <- (map["languages_url"], StringTransform.shared)
            mergesUrl           <- (map["merges_url"], StringTransform.shared)
            milestonesUrl       <- (map["milestones_url"], StringTransform.shared)
            mirrorUrl           <- (map["mirror_url"], StringTransform.shared)
            notificationsUrl    <- (map["notifications_url"], StringTransform.shared)
            pullsUrl            <- (map["pulls_url"], StringTransform.shared)
            pushedAt            <- (map["pushed_at"], StringTransform.shared)
            releasesUrl         <- (map["releases_url"], StringTransform.shared)
            sshUrl              <- (map["ssh_url"], StringTransform.shared)
            stargazersUrl       <- (map["stargazers_url"], StringTransform.shared)
            statusesUrl         <- (map["statuses_url"], StringTransform.shared)
            subscribersUrl      <- (map["subscribers_url"], StringTransform.shared)
            subscriptionUrl     <- (map["subscription_url"], StringTransform.shared)
            svnUrl              <- (map["svn_url"], StringTransform.shared)
            tagsUrl             <- (map["tags_url"], StringTransform.shared)
            teamsUrl            <- (map["teams_url"], StringTransform.shared)
            tempCloneToken      <- (map["temp_clone_token"], StringTransform.shared)
            treesUrl            <- (map["trees_url"], StringTransform.shared)
            updatedAt           <- (map["updated_at"], StringTransform.shared)
            htmlUrl             <- (map["html_url"], StringTransform.shared)
            fullname            <- (map["full_name"], StringTransform.shared)
            ownerAuthor         <- (map["author"], StringTransform.shared)
            ownerAvatar         <- (map["avatar"], StringTransform.shared)
            `private`           <- (map["private"], BoolTransform.shared)
            archived            <- (map["archived"], BoolTransform.shared)
            disabled            <- (map["disabled"], BoolTransform.shared)
            fork                <- (map["fork"], BoolTransform.shared)
            hasDownloads        <- (map["has_downloads"], BoolTransform.shared)
            hasIssues           <- (map["has_issues"], BoolTransform.shared)
            hasPages            <- (map["has_pages"], BoolTransform.shared)
            hasProjects         <- (map["has_projects"], BoolTransform.shared)
            hasWiki             <- (map["has_wiki"], BoolTransform.shared)
            ranking             <- (map["ranking"], IntTransform.shared)
            currentPeriodStars  <- (map["currentPeriodStars"], IntTransform.shared)
            pageType            <- (map["pageType"], EnumTypeCastTransform<RMPageType>())
            networkCount        <- (map["network_count"], IntTransform.shared)
            size                <- (map["size"], IntTransform.shared)
            subscribers         <- (map["subscribers_count"], IntTransform.shared)
            openIssues          <- (map["open_issues"], IntTransform.shared)
            watchers            <- (map["watchers"], IntTransform.shared)
            forks               <- (map["forks"], IntTransform.shared)
            stars               <- (map["stars"], IntTransform.shared)
            sortNumber          <- (map["sortNumber"], IntTransform.shared)
            owner               <- map["owner"]
            builtBy             <- (map["builtBy"], RealmListTransform<RMBaseUser>())
            if id.isEmpty {
                (nodeId ?? fullname ?? url ?? "")   >>> map["id"]
            }
        }
    }
    
    override class func propertiesMapping() -> [String: String] {
        [
            "desc": "description",
            "archiveUrl": "archive_url",
            "assigneesUrl": "assignees_url",
            "blobsUrl": "blobs_url",
            "branchesUrl": "branches_url",
            "cloneUrl": "clone_url",
            "collaboratorsUrl": "collaborators_url",
            "commentsUrl": "comments_url",
            "commitsUrl": "commits_url",
            "compareUrl": "compare_url",
            "contentsUrl": "contents_url",
            "contributorsUrl": "contributors_url",
            "createdAt": "created_at",
            "defaultBranch": "default_branch",
            "deploymentsUrl": "deployments_url",
            "downloadsUrl": "downloads_url",
            "eventsUrl": "events_url",
            "forksUrl": "forks_url",
            "gitCommitsUrl": "git_commits_url",
            "gitRefsUrl": "git_refs_url",
            "gitTagsUrl": "git_tags_url",
            "gitUrl": "git_url",
            "hooksUrl": "hooks_url",
            "issueCommentUrl": "issue_comment_url",
            "issueEventsUrl": "issue_events_url",
            "issuesUrl": "issues_url",
            "keysUrl": "keys_url",
            "labelsUrl": "labels_url",
            "languagesUrl": "languages_url",
            "mergesUrl": "merges_url",
            "milestonesUrl": "milestones_url",
            "mirrorUrl": "mirror_url",
            "notificationsUrl": "notifications_url",
            "pullsUrl": "pulls_url",
            "pushedAt": "pushed_at",
            "releasesUrl": "releases_url",
            "sshUrl": "ssh_url",
            "stargazersUrl": "stargazers_url",
            "statusesUrl": "statuses_url",
            "subscribersUrl": "subscribers_url",
            "subscriptionUrl": "subscription_url",
            "svnUrl": "svn_url",
            "tagsUrl": "tags_url",
            "teamsUrl": "teams_url",
            "tempCloneToken": "temp_clone_token",
            "treesUrl": "trees_url",
            "updatedAt": "updated_at",
            "htmlUrl": "html_url",
            "fullname": "full_name",
            "hasDownloads": "has_downloads",
            "hasIssues": "has_issues",
            "hasPages": "has_pages",
            "hasProjects": "has_projects",
            "hasWiki": "has_wiki",
            "networkCount": "network_count",
            "subscribers": "subscribers_count",
            "openIssues": "open_issues",
            "ownerAuthor": "author",
            "ownerAvatar": "avatar"
        ]
    }
}

extension RMRepo: DomainConvertibleType {
    func asDomain() -> Repo {
        .init(JSON: toJSON())!
    }
}

extension Repo: RealmRepresentable {
    internal var uid: String { "" }
    
    func asRealm() -> RMRepo {
        .init(JSON: toJSON())!
    }
}
