//
//  Event.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/18.
//

import Foundation
import ObjectMapper
import HiBase

public struct Event: ModelType {
    
    public var id = ""
    public var createdAt: String?
    public var `public`: Bool?
    public var type: EventType?
    
    public init() { }
    
    public init?(map: ObjectMapper.Map) { }
    
    public mutating func mapping(map: ObjectMapper.Map) {
        id              <- (map["id"], StringTransform.shared)
        createdAt       <- (map["created_at"], StringTransform.shared)
        `public`        <- (map["public"], BoolTransform.shared)
        type            <- (map["type"], EnumTypeCastTransform<EventType>())
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.createdAt == rhs.createdAt &&
        lhs.public == rhs.public &&
        lhs.type == rhs.type
    }
    
}
