//
//  LoginService.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/19.
//

import Foundation
import Combine

public protocol LoginService {

    /// 用户信息
    /// - https://projecttemplate.authing.cn/api/v3/signin
    /// - https://api-explorer.authing.cn/?tag=tag/%E7%99%BB%E5%BD%95/API%20%E5%88%97%E8%A1%A8/operation/SignInV3Controller_signInByCredentials
    func login(account: String, password: String) -> AnyPublisher<Login, Error>
    
}
