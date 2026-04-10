//
//  EnumType.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/15.
//

import Foundation

public enum PageType: String, Identifiable, Codable, Hashable {
    case none
    case open, closed
    // repos（注：subscriptions表现为watchs）
    case trendingRepos, repositories, stars, subscriptions, forks
    // users（注：subscribers表现为watchers）
    case trendingUsers, followers, following, subscribers, stargazers, contributors
    // 用户详情页
    case milestone, company
    // 仓库详情页
    case readme
    
    public var id: String { rawValue }
    
    public static let trendingValues = [trendingRepos, trendingUsers]
    public static let userValues = [repositories, followers, following, stars, subscriptions]
    public static let repoValues = [subscribers, stargazers, contributors, forks]
    public static let stateValues = [open, closed]
}

public enum SearchType: String, Codable, CaseIterable {
    case repositories, users
    
    public var sorts: [String] {
        switch self {
        case .repositories: return ["stars", "forks", "updated"]
        case .users: return ["followers", "repositories"]
        }
    }
}

public enum OrderType: String, Codable {
    case asc, desc
}

public enum ColorTheme: String, Codable, Identifiable, CaseIterable {
    case red, pink, purple, deepPurple, indigo, blue, lightBlue, cyan, teal, green
    case lightGreen, lime, yellow, amber, orange, deepOrange, brown, gray, blueGray

    public var id: String { rawValue }
    
    public var color: UIColor {
        switch self {
        case .red: return UIColor.Material.red
        case .pink: return UIColor.Material.pink
        case .purple: return UIColor.Material.purple
        case .deepPurple: return UIColor.Material.deepPurple
        case .indigo: return UIColor.Material.indigo
        case .blue: return UIColor.Material.blue
        case .lightBlue: return UIColor.Material.lightBlue
        case .cyan: return UIColor.Material.cyan
        case .teal: return UIColor.Material.teal
        case .green: return UIColor.Material.green
        case .lightGreen: return UIColor.Material.lightGreen
        case .lime: return UIColor.Material.lime
        case .yellow: return UIColor.Material.yellow
        case .amber: return UIColor.Material.amber
        case .orange: return UIColor.Material.orange
        case .deepOrange: return UIColor.Material.deepOrange
        case .brown: return UIColor.Material.brown
        case .gray: return UIColor.Material.grey
        case .blueGray: return UIColor.Material.blueGrey
        }
    }
}

public enum TrendingSince: String, Codable, CaseIterable {
    case daily, weekly, montly
}

public enum Platform {
    case github, umeng, weixin, twitter
    
    public var appId: String {
        switch self {
        case .github: return "Ov23lidM0zEVqrRtjWoa"
        case .umeng: return "676a76d58f232a05f1e0121b"
        case .weixin: return "wx6dd917ddbbd49e78"
        case .twitter: return "QkxOY3Q3VHg5Z2hqSjVTdjdYTVI6MTpjaQ"
        }
    }
    
    public var appKey: String {
        switch self {
        case .github: return "901c33c7e5c507a727cb09c06af064d3b32f74d6"
        case .weixin: return "ad38452ba19b15af425426e38ef3c0fb"
        case .twitter: return "iUF_m5ErkFt35CLG0WrsPKU-3GsHf8ylDcKNNFVYGIpdGQP4pO"
        default: return ""
        }
    }
    
    public var appLink: String {
        switch self {
        case .weixin: return "https://c36e1a63a625c5b0456fc6550099a35a.share2dlink.com/"
        case .twitter: return "https://c36e1a63a625c5b0456fc6550099a35a.share2dlink.com"
        default: return ""
        }
    }

}

public struct Author {
    public static let owner = "tospery"
    public static let repo = "HiSwiftUI"
}
