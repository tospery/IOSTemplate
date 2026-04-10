//
//  RMBaseUser.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/18.
//

import Foundation
import ObjectMapper
import RealmSwift
import Domain
import HiBase
import HiRealm

class RMBaseUser: Object, Mappable {
    
    @Persisted(primaryKey: true) var id: String
    @Persisted var username: String?
    @Persisted var avatar: String?
    @Persisted var url: String?
    
    override init() {
        super.init()
    }
    
    required init?(map: ObjectMapper.Map) {
        super.init()
        id                      <- (map["id"], StringTransform.shared)
        if id.isEmpty {
            id                  <- (map["username"], StringTransform.shared)
        }
        if id.isEmpty {
            id                  <- (map["url"], StringTransform.shared)
        }
    }
    
    func mapping(map: ObjectMapper.Map) {
        performMapping {
            id                  >>> map["id"]
            username            <- (map["username"], StringTransform.shared)
            avatar              <- (map["avatar"], StringTransform.shared)
            url                 <- (map["url"], StringTransform.shared)
            if id.isEmpty {
                (username ?? url ?? "")     >>> map["id"]
            }
        }
    }
}

extension RMBaseUser: DomainConvertibleType {
    func asDomain() -> BaseUser {
        .init(JSON: toJSON())!
    }
}

extension BaseUser: RealmRepresentable {
    internal var uid: String { "" }
    
    func asRealm() -> RMBaseUser {
        .init(JSON: toJSON())!
    }
}
