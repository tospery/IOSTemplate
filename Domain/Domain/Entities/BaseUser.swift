//
//  BaseUser.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/18.
//

import Foundation
import ObjectMapper
import HiBase

public struct BaseUser: ModelType {
    
    public var id = ""
    public var username: String?
    public var avatar: String?
    public var url: String?
    
    public init() { }
    
    public init?(map: ObjectMapper.Map) { }
    
    public mutating func mapping(map: ObjectMapper.Map) {
        username            <- (map["username"], StringTransform.shared)
        if username == nil {
            username        <- (map["login"], StringTransform.shared)
        }
        if username == nil {
            username        <- (map["display_login"], StringTransform.shared)
        }
        id                  <- (map["id"], StringTransform.shared)
        avatar              <- (map["avatar"], StringTransform.shared)
        if avatar == nil {
            avatar          <- (map["avatar_url"], StringTransform.shared)
        }
        url                 <- (map["url"], StringTransform.shared)
        if url == nil {
            url             <- (map["href"], StringTransform.shared)
        }
        if id.isEmpty {
            id = username ?? url ?? ""
        }
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.url == rhs.url &&
        lhs.avatar == rhs.avatar &&
        lhs.username == rhs.username
    }
    
}
