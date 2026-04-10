//
//  Login.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/18.
//

import Foundation
import ObjectMapper
import HiBase

public struct Login: ModelType {
    
    public var id = ""
    public var scope: String?
    public var tokenType: String?
    public var accessToken: String?
    public var expiresIn: Int?
    
    public var isValid: Bool { id.isNotEmpty && accessToken?.isNotEmpty ?? false}
    
    public init() { }
    
    public init?(map: ObjectMapper.Map) { }
    
    public mutating func mapping(map: ObjectMapper.Map) {
        id              <- (map["id_token"], StringTransform.shared)
        scope           <- (map["scope"], StringTransform.shared)
        tokenType       <- (map["token_type"], StringTransform.shared)
        accessToken     <- (map["access_token"], StringTransform.shared)
        expiresIn       <- (map["expires_in"], IntTransform.shared)
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.scope == rhs.scope &&
        lhs.tokenType == rhs.tokenType &&
        lhs.accessToken == rhs.accessToken &&
        lhs.expiresIn == rhs.expiresIn
    }
    
}
