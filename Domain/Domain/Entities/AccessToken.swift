//
//  AccessToken.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/18.
//

import Foundation
import ObjectMapper
import HiBase

public struct AccessToken: ModelType {
    
    public var id = ""
    public var tokenType: String?
    public var scope: String?
    
    public var isValid: Bool { id.isNotEmpty && tokenType?.isNotEmpty ?? false}
    
    public init() { }
    
    public init(id: String) { self.id = id }
    
    public init?(map: ObjectMapper.Map) { }
    
    public mutating func mapping(map: ObjectMapper.Map) {
        id              <- (map["access_token"], StringTransform.shared)
        tokenType       <- (map["token_type"], StringTransform.shared)
        scope           <- (map["scope"], StringTransform.shared)
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.tokenType == rhs.tokenType &&
        lhs.scope == rhs.scope
    }
    
}
