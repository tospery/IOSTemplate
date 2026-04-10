//
//  TrendingAPI.swift
//  NetworkPlatform
//
//  Created by 杨建祥 on 2024/5/17.
//

import Foundation
import Moya
import SwifterSwift
import HiCore
import HiBase
import Domain

enum TrendingAPI {
    case languages
    case users(language: Language?, since: TrendingSince?)
    case repos(language: Language?, since: TrendingSince?)
}

extension TrendingAPI: TargetType {

    var baseURL: URL { "https://gtrend.yapie.me".url! }

    var path: String {
        switch self {
        case .languages: return "/languages"
        case .users: return "/developers"
        case .repos: return "/repositories"
        }
    }

    var method: Moya.Method { .get }

    var headers: [String: String]? { nil }

    var task: Task {
        var parameters = NetworkPlatform.environment
        let encoding: ParameterEncoding = URLEncoding.default
        switch self {
        case .users(let language, let trendingSince),
             .repos(let language, let trendingSince):
            if let lang = language?.id, lang != "*" {
                parameters[Parameter.language] = lang
            }
            parameters[Parameter.since] = trendingSince?.rawValue
        default:
            break
        }
        return .requestParameters(parameters: parameters, encoding: encoding)
    }

    var validationType: ValidationType { .none }

    var sampleData: Data { Data.init() }

}
