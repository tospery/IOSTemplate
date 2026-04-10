//
//  Repo.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/18.
//

import Foundation
import ObjectMapper
import HiBase

public struct Repo: ModelType {
    
    public var id = ""
    public var nodeId: String?
    public var url: String?
    public var desc: String?
    public var language: String?
    public var languageColor: String?
    public var archiveUrl: String?
    public var assigneesUrl: String?
    public var blobsUrl: String?
    public var branchesUrl: String?
    public var cloneUrl: String?
    public var collaboratorsUrl: String?
    public var commentsUrl: String?
    public var commitsUrl: String?
    public var compareUrl: String?
    public var contentsUrl: String?
    public var contributorsUrl: String?
    public var createdAt: String?
    public var defaultBranch: String?
    public var deploymentsUrl: String?
    public var downloadsUrl: String?
    public var eventsUrl: String?
    public var forksUrl: String?
    public var gitCommitsUrl: String?
    public var gitRefsUrl: String?
    public var gitTagsUrl: String?
    public var gitUrl: String?
    public var homepage: String?
    public var hooksUrl: String?
    public var htmlUrl: String?
    public var issueCommentUrl: String?
    public var issueEventsUrl: String?
    public var issuesUrl: String?
    public var keysUrl: String?
    public var labelsUrl: String?
    public var languagesUrl: String?
    public var mergesUrl: String?
    public var milestonesUrl: String?
    public var mirrorUrl: String?
    public var notificationsUrl: String?
    public var pullsUrl: String?
    public var pushedAt: String?
    public var releasesUrl: String?
    public var sshUrl: String?
    public var stargazersUrl: String?
    public var statusesUrl: String?
    public var subscribersUrl: String?
    public var subscriptionUrl: String?
    public var svnUrl: String?
    public var tagsUrl: String?
    public var teamsUrl: String?
    public var tempCloneToken: String?
    public var treesUrl: String?
    public var updatedAt: String?
    public var name: String?
    public var fullname: String?
    public var ownerAuthor: String?
    public var ownerAvatar: String?
    public var `private`: Bool?
    public var archived: Bool?
    public var disabled: Bool?
    public var fork: Bool?
    public var hasDownloads: Bool?
    public var hasIssues: Bool?
    public var hasPages: Bool?
    public var hasProjects: Bool?
    public var hasWiki: Bool?
    public var currentPeriodStars: Int?
    public var networkCount: Int?
    public var openIssues: Int?
    public var subscribers: Int?
    public var size: Int?
    public var watchers: Int?
    public var forks: Int?
    public var stars: Int?
    public var ranking: Int?
    public var owner: User?
    public var builtBy = [BaseUser].init()
    // 扩展字段
    public var sortNumber: Int?
    public var pageType: PageType?

    public init() { }
    
    public init?(map: ObjectMapper.Map) { }
    
    public mutating func mapping(map: ObjectMapper.Map) {
        id                  <- (map["id"], StringTransform.shared)
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
        ownerAuthor         <- (map["author"], StringTransform.shared)
        ownerAvatar         <- (map["avatar"], StringTransform.shared)
        fullname            <- (map["full_name"], StringTransform.shared)
        if htmlUrl?.isEmpty ?? true {
            htmlUrl         <- (map["url"], StringTransform.shared)
        }
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
        pageType            <- (map["pageType"], EnumTypeCastTransform<PageType>())
        networkCount        <- (map["network_count"], IntTransform.shared)
        size                <- (map["size"], IntTransform.shared)
        subscribers         <- (map["subscribers_count"], IntTransform.shared)
        openIssues          <- (map["open_issues"], IntTransform.shared)
        sortNumber          <- (map["sortNumber"], IntTransform.shared)
        if openIssues == nil {
            openIssues      <- (map["open_issues_count"], IntTransform.shared)
        }
        watchers            <- (map["watchers"], IntTransform.shared)
        if watchers == nil {
            watchers        <- (map["watchers_count"], IntTransform.shared)
        }
        forks               <- (map["forks"], IntTransform.shared)
        if forks == nil {
            forks           <- (map["forks_count"], IntTransform.shared)
        }
        stars               <- (map["stars"], IntTransform.shared)
        if stars == nil {
            stars           <- (map["stargazers_count"], IntTransform.shared)
        }
        builtBy             <- map["builtBy"]
        owner               <- map["owner"]
        if owner == nil {
            owner = .init()
        }
        if !(owner?.isValid ?? false) {
            owner?.username = ownerAuthor
            owner?.avatar = ownerAvatar
        }
        if fullname?.isEmpty ?? true {
            fullname = "\(owner?.username ?? "")/\(name ?? "")"
        }
        if id.isEmpty {
            id = nodeId ?? fullname ?? url ?? ""
        }
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.subscribers == rhs.subscribers &&
        lhs.openIssues == rhs.openIssues &&
        lhs.networkCount == rhs.networkCount &&
        lhs.currentPeriodStars == rhs.currentPeriodStars &&
        lhs.hasIssues == rhs.hasIssues &&
        lhs.nodeId == rhs.nodeId &&
        lhs.url == rhs.url &&
        lhs.desc == rhs.desc &&
        lhs.updatedAt == rhs.updatedAt &&
        lhs.ranking == rhs.ranking &&
        lhs.stars == rhs.stars &&
        lhs.forks == rhs.forks &&
        lhs.watchers == rhs.watchers &&
        lhs.sortNumber == rhs.sortNumber &&
        lhs.size == rhs.size &&
        lhs.owner == rhs.owner &&
        lhs.builtBy == rhs.builtBy
    }
    
    public func copyWith(id: String) -> Repo {
        var myRepo = self
        myRepo.id = id
        return myRepo
    }
    
    public func copyWith(pageType: PageType?) -> Repo {
        var myRepo = self
        myRepo.pageType = pageType
        return myRepo
    }
    
    public func copyWith(sortNumber: Int?) -> Repo {
        var myRepo = self
        myRepo.sortNumber = sortNumber
        return myRepo
    }

}

