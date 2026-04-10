//
//  UserService.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/19.
//

import Foundation
import Combine

public protocol UserService {
    
    /// 用户信息
    /// - https://projecttemplate.authing.cn/api/v3/get-profile?withCustomData=true&withIdentities=true&withDepartmentIds=true
    /// - https://api-explorer.authing.cn/?tag=tag/%E7%94%A8%E6%88%B7%E8%B5%84%E6%96%99/API%20%E5%88%97%E8%A1%A8/operation/ProfileV3Controller_getProfile
    func user(token: String) -> AnyPublisher<User, Error>
    
}

