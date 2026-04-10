//
//  AlicloudAPI.swift
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

enum AlicloudAPI {
    case news(channel: String, pageIndex: Int, pageSize: Int)
}

extension AlicloudAPI: TargetType {

    var baseURL: URL { "https://jisunews.market.alicloudapi.com".url! }

    var path: String {
        switch self {
        case .news: return "/news/get"
        }
    }

    var method: Moya.Method { .get }

    var headers: [String: String]? {
        [
            Parameter.authorization.capitalizedFirstCharacter: "APPCODE \(Platform.alicloud.appKey)"
        ]
    }

    var task: Task {
        var parameters = NetworkPlatform.environment
        let encoding: ParameterEncoding = URLEncoding.default
        switch self {
        case let .news(channel, pageIndex, pageSize):
            parameters[Parameter.channel] = channel
            parameters[Parameter.pageIndex] = pageIndex
            parameters[Parameter.pageSize] = pageSize
        }
        return .requestParameters(parameters: parameters, encoding: encoding)
    }

    var validationType: ValidationType { .none }

    var sampleData: Data { Data.init() }

}
