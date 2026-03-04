//
//  AccessTokenService.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/19.
//

import Foundation
import Combine
import Moya
import HiCore
import Domain

final class AccessTokenService: Domain.AccessTokenService {
    
    private let environment: [String: Any]

    init(environment: [String: Any]) {
        self.environment = environment
    }

    func accessToken(code: String) -> AnyPublisher<Domain.AccessToken, any Error> {
        multiNetworking.requestObject(
            MultiTarget.init(GithubMainAPI.token(code: code)),
            type: AccessToken.self
        )
    }

}
