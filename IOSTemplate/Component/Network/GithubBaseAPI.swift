//
//  GithubBaseAPI.swift
//  SWHub
//
//  Created by 杨建祥 on 2022/11/27.
//

import Foundation
import Moya
import SwifterSwift
import HiIOS

enum GithubBaseAPI {
    case login(token: String)
}

extension GithubBaseAPI: TargetType {

    var baseURL: URL {
        return UIApplication.shared.baseApiUrl.url!
    }

    var path: String {
        switch self {
        case .login: return "/user"
        }
    }

    var method: Moya.Method { .get }

    var headers: [String: String]? {
        switch self {
        case let .login(token):
            return [Parameter.authorization: "token \(token)"]
        }
    }

    var task: Task {
        var parameters = envParameters
        var encoding: ParameterEncoding = URLEncoding.default
        return .requestParameters(parameters: parameters, encoding: encoding)
    }

    var validationType: ValidationType { .none }

    var sampleData: Data {
        Data.init()
    }

}
