//
//  DynamicAPI.swift
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

enum DynamicAPI {
    case request(path: String, parameters: [String: String]?)
}

extension DynamicAPI: TargetType {
    
    var baseURL: URL { fatalError() }

    var path: String {
        switch self {
        case let .request(path, _): return path
        }
    }

    var method: Moya.Method { .get }

    var headers: [String: String]? {
        if let accessToken = NetworkPlatform.preference?.accessToken?.id, accessToken.isNotEmpty {
            return [Parameter.authorization: "token \(accessToken)"]
        }
        return nil
    }

    var task: Task {
        switch self {
        case let .request(_, parameters):
            return .requestParameters(parameters: parameters ?? [:], encoding: URLEncoding.default)
        }
    }

    var validationType: ValidationType { .none }

    var sampleData: Data { .init() }

}
