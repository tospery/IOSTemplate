//
//  EnumType.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/15.
//

import Foundation

public enum PageType: String, Identifiable, Codable, Hashable {
    case none
//    case open, closed
//    // repos（注：subscriptions表现为watchs）
//    case trendingRepos, repositories, stars, subscriptions, forks
//    // users（注：subscribers表现为watchers）
//    case trendingUsers, followers, following, subscribers, stargazers, contributors
//    // 用户详情页
//    case milestone, company
//    // 仓库详情页
//    case readme
    
    public var id: String { rawValue }
    
//    public static let trendingValues = [trendingRepos, trendingUsers]
//    public static let userValues = [repositories, followers, following, stars, subscriptions]
//    public static let repoValues = [subscribers, stargazers, contributors, forks]
//    public static let stateValues = [open, closed]
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

public enum UserStatus: String, Codable, CaseIterable {
    case activated = "Activated"
    case suspended = "Suspended"
    case deactivated = "Deactivated"
    case resigned = "Resigned"
    case archived = "Archived"
}

public enum UserGender: String, Codable, CaseIterable {
    case unknown = "U"
    case male = "M"
    case female = "F"
}

public enum UserSource: String, Codable, CaseIterable {
    case adminCreated, register, syncTask, excel
}

public enum Platform {
    case github, umeng, alicloud, authing
    
    public var appKey: String {
        switch self {
        case .umeng: return "69c91cb46f259537c787bc6e"
        case .alicloud: return "ccf96e47df6347578e8a6153fb01cbb6"
        case .authing: return "69bfeb740e494b9c4ec32383"
        default: return ""
        }
    }
    
    public var appLink: String {
        switch self {
        case .alicloud: return "https://c36e1a63a625c5b0456fc6550099a35a.share2dlink.com/"
        case .authing: return "https://c36e1a63a625c5b0456fc6550099a35a.share2dlink.com"
        default: return ""
        }
    }

}
