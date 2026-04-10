//
//  LoginService.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/19.
//

import Foundation
import Combine
import Moya
import HiCore
import Domain

final class LoginService: Domain.LoginService {
    
    private let environment: [String: Any]

    init(environment: [String: Any]) {
        self.environment = environment
    }

    func login(account: String, password: String) -> AnyPublisher<Domain.Login, any Error> {
        multiNetworking.requestObject(
            MultiTarget.init(AuthingAPI.login(account: account, password: password)),
            type: Domain.Login.self
        )
    }

}
