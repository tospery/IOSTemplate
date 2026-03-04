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
}

extension TrendingAPI: TargetType {

    var baseURL: URL { "https://gtrend.yapie.me".url! }

    var path: String {
        switch self {
        case .languages: return "/languages"
        }
    }

    var method: Moya.Method { .get }

    var headers: [String: String]? { nil }

    var task: Task {
        let parameters = NetworkPlatform.environment
        let encoding: ParameterEncoding = URLEncoding.default
//        switch self {
//        case .users(let language, let trendingSince),
//             .repos(let language, let trendingSince):
//            if let lang = language?.id, lang != "*" {
//                parameters[Parameter.language] = lang
//            }
//            parameters[Parameter.since] = trendingSince?.rawValue
//        default:
//            break
//        }
        return .requestParameters(parameters: parameters, encoding: encoding)
    }

    var validationType: ValidationType { .none }

    var sampleData: Data { Data.init() }

}
