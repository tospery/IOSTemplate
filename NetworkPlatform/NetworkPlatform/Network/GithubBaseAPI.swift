//
//  GithubBaseAPI.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/19.
//

import Foundation
import Moya
import SwifterSwift
import HiCore
import HiBase
import Domain

enum GithubBaseAPI {
    // MARK: login
    case login(token: String)
    // MARK: user
    case user(owner: String)
    case userEvents(owner: String, pageIndex: Int, pageSize: Int)
    case repos(owner: String, pageIndex: Int, pageSize: Int)
    case starred(owner: String, pageIndex: Int, pageSize: Int)
    case followers(owner: String, pageIndex: Int, pageSize: Int)
    case following(owner: String, pageIndex: Int, pageSize: Int)
    case subscriptions(owner: String, pageIndex: Int, pageSize: Int)
    // MARK: repo
    case repo(owner: String, repo: String)
    case forks(owner: String, repo: String, pageIndex: Int, pageSize: Int)
    case stargazers(owner: String, repo: String, pageIndex: Int, pageSize: Int)
    case contributors(owner: String, repo: String, pageIndex: Int, pageSize: Int)
    case subscribers(owner: String, repo: String, pageIndex: Int, pageSize: Int)
    // MARK: branch
    case branches(owner: String, repo: String, page: Int)
    // MARK: contents
    case contents(owner: String, repo: String, subpath: String?, ref: String?)
    case readme(owner: String, repo: String, ref: String?)
    // MARK: star
    case checkStarring(owner: String, repo: String)
    case star(owner: String, repo: String)
    case unstar(owner: String, repo: String)
    // MARK: follow
    case checkFollowing(owner: String)
    case follow(owner: String)
    case unfollow(owner: String)
    // MARK: markdown
    case markdown(url: String, text: String)
    // MARK: other
    case modify(key: String, value: String)
}

extension GithubBaseAPI: TargetType {

    var baseURL: URL {
        return "https://api.github.com".url!
    }

    var path: String {
        switch self {
        case .markdown: return "/markdown"
        case .login, .modify: return "/user"
        case let .readme(owner, repo, _): return "/repos/\(owner)/\(repo)/readme"
        case .checkFollowing(let owner),
                .follow(let owner),
                .unfollow(let owner):
            return "/user/following/\(owner)"
        case .checkStarring(let owner, let repo),
                .star(let owner, let repo),
                .unstar(let owner, let repo):
            return "/user/starred/\(owner)/\(repo)"
        case let .userEvents(owner, _, _): return "/users/\(owner)/received_events"
        case let .branches(owner, repo, _): return "/repos/\(owner)/\(repo)/branches"
        case let .user(owner): return "/users/\(owner)"
        case let .repo(owner, repo): return "/repos/\(owner)/\(repo)"
        case let .repos(owner, _, _): return "/users/\(owner)/repos"
        case let .starred(owner, _, _): return "/users/\(owner)/starred"
        case let .followers(owner, _, _): return "/users/\(owner)/followers"
        case let .following(owner, _, _): return "/users/\(owner)/following"
        case let .subscriptions(owner, _, _): return "/users/\(owner)/subscriptions"
        case let .forks(owner, repo, _, _): return "/repos/\(owner)/\(repo)/forks"
        case let .stargazers(owner, repo, _, _): return "/repos/\(owner)/\(repo)/stargazers"
        case let .contributors(owner, repo, _, _): return "/repos/\(owner)/\(repo)/contributors"
        case let .subscribers(owner, repo, _, _): return "/repos/\(owner)/\(repo)/subscribers"
        case let .contents(owner, repo, subpath, _):
            return "/repos/\(owner)/\(repo)/contents/\(subpath ?? "")"
        }
    }

    var method: Moya.Method {
        switch self {
        case .markdown: return .post
        case .follow, .star: return .put
        case .unfollow, .unstar: return .delete
        case .modify: return .patch
        default: return .get
        }
    }

    var headers: [String: String]? {
        switch self {
        case let .login(token):
            return [Parameter.authorization: "token \(token)"]
        default:
            if let accessToken = NetworkPlatform.preference?.accessToken?.id, accessToken.isNotEmpty {
                return [Parameter.authorization: "token \(accessToken)"]
            }
            return nil
        }
    }

    var task: Task {
        var parameters = NetworkPlatform.environment
        var encoding: ParameterEncoding = URLEncoding.default
        switch self {
        case let .modify(key, value):
            parameters[key] = value
            encoding = JSONEncoding.default
        case let .markdown(url, text):
            parameters[Parameter.mode] = "gfm"
            parameters[Parameter.context] = "\(url.githubUsername)/\(url.githubReponame)"
            parameters[Parameter.text] = text
            encoding = JSONEncoding.default
        case let .readme(_, _, ref),
            let .contents(_, _, _, ref):
            parameters[Parameter.ref] = ref?.isNotEmpty ?? false ? ref : nil
        case let .repos(_, pageIndex, pageSize),
            let .starred(_, pageIndex, pageSize),
            let .followers(_, pageIndex, pageSize),
            let .following(_, pageIndex, pageSize),
            let .subscriptions(_, pageIndex, pageSize),
            let .userEvents(_, pageIndex, pageSize):
            parameters[Parameter.pageIndex] = pageIndex
            parameters[Parameter.pageSize] = pageSize
        case let .forks(_, _, pageIndex, pageSize),
            let .stargazers(_, _, pageIndex, pageSize),
            let .contributors(_, _, pageIndex, pageSize),
            let .subscribers(_, _, pageIndex, pageSize):
            parameters[Parameter.pageIndex] = pageIndex
            parameters[Parameter.pageSize] = pageSize
        case let .branches(_, _, page):
            parameters[Parameter.pageIndex] = page
            parameters[Parameter.pageSize] = 100
        default:
            return .requestPlain
        }
        return .requestParameters(parameters: parameters, encoding: encoding)
    }

    var validationType: ValidationType { .none }

    var sampleData: Data {
        Data.init()
    }

}
