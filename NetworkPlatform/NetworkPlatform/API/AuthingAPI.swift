//
//  AuthingAPI.swift
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

enum AuthingAPI {
    case login(account: String, password: String)
    case user(token: String)
}

extension AuthingAPI: TargetType {

    var baseURL: URL {
        return "https://projecttemplate.authing.cn".url!
    }

    var path: String {
        switch self {
        case .login: return "/api/v3/signin"
        case .user: return "/api/v3/get-profile"
        }
    }

    var method: Moya.Method {
        switch self {
        case .login: return .post
        default: return .get
        }
    }

    var headers: [String: String]? {
        var parameters = [Parameter.authingAppId: Platform.authing.appKey]
        switch self {
        case let .user(token):
            parameters[Parameter.authorization] = token
        default:
            break
        }
        return parameters
    }

    var task: Task {
        var parameters = NetworkPlatform.environment
        var encoding: ParameterEncoding = URLEncoding.default
        switch self {
        case let .login(account, password):
            parameters[Parameter.account] = account
            parameters[Parameter.password] = password
            encoding = JSONEncoding.default
        case .user:
            parameters[Parameter.withIdentities] = true
            parameters[Parameter.withCustomData] = true
            parameters[Parameter.withDepartmentIds] = true
        }
        return .requestParameters(parameters: parameters, encoding: encoding)
    }

    var validationType: ValidationType { .none }

    var sampleData: Data {
        Data.init()
    }

}
