//
//  BaseRepo.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/15.
//

import Foundation
import ObjectMapper
import HiBase

public struct BaseRepo: ModelType {
    
    public var id = ""
    public var url: String?
    public var name: String?
    public var desc: String?
    
    public init() { }
    
    public init?(map: ObjectMapper.Map) { }
    
    public mutating func mapping(map: ObjectMapper.Map) {
        id          <- (map["id"], StringTransform.shared)
        url         <- (map["url"], StringTransform.shared)
        name        <- (map["name"], StringTransform.shared)
        desc        <- (map["description"], StringTransform.shared)
        if id.isEmpty {
            id = url ?? ""
        }
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.url == rhs.url &&
        lhs.name == rhs.name &&
        lhs.desc == rhs.desc
    }
    
}
