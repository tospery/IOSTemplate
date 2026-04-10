//
//  RMBaseRepo.swift
//  DatabasePlatform
//
//  Created by 杨建祥 on 2024/5/15.
//

import Foundation
import ObjectMapper
import RealmSwift
import Domain
import HiBase
import HiRealm

class RMBaseRepo: Object, Mappable {
    
    @Persisted(primaryKey: true) var id: String
    @Persisted var url: String?
    @Persisted var name: String?
    @Persisted var desc: String?
    
    override init() {
        super.init()
    }
    
    required init?(map: ObjectMapper.Map) {
        super.init()
        id              <- (map["id"], StringTransform.shared)
        if id.isEmpty {
            id          <- (map["url"], StringTransform.shared)
        }
    }
    
    func mapping(map: ObjectMapper.Map) {
        performMapping {
            id                      >>> map["id"]
            url                     <- (map["url"], StringTransform.shared)
            name                    <- (map["name"], StringTransform.shared)
            desc                    <- (map["description"], StringTransform.shared)
            if id.isEmpty {
                (url ?? "")         >>> map["id"]
            }
        }
    }
    
    override class func propertiesMapping() -> [String: String] {
        [
            "desc": "description"
        ]
    }
}

extension RMBaseRepo: DomainConvertibleType {
    func asDomain() -> BaseRepo {
        .init(JSON: toJSON())!
    }
}

extension BaseRepo: RealmRepresentable {
    internal var uid: String { "" }
    
    func asRealm() -> RMBaseRepo {
        .init(JSON: toJSON())!
    }

}

