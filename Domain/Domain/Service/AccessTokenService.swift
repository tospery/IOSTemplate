//
//  AccessTokenService.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/19.
//

import Foundation
import Combine

public protocol AccessTokenService {

    func accessToken(code: String) -> AnyPublisher<AccessToken, Error>
    
}
