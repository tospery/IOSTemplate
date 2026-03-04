//
//  RMEvent.swift
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

class RMEvent: Object, Mappable {
    
    @Persisted(primaryKey: true) var id: String
    @Persisted var createdAt: String?
    @Persisted var `public`: Bool?
    @Persisted var type: RMEventType?
    
    override init() {
        super.init()
    }
    
    required init?(map: ObjectMapper.Map) {
        super.init()
        id                          <- (map["id"], StringTransform.shared)
    }
    
    func mapping(map: ObjectMapper.Map) {
        performMapping {
            id                      >>> map["id"]
            createdAt               <- (map["created_at"], StringTransform.shared)
            `public`                <- (map["public"], BoolTransform.shared)
            type                    <- (map["type"], EnumTypeCastTransform<RMEventType>())
        }
    }
    
    override class func propertiesMapping() -> [String: String] {
        [
            "createdAt": "created_at"
        ]
    }
}

extension RMEvent: DomainConvertibleType {
    func asDomain() -> Event {
        .init(JSON: toJSON())!
    }
}

extension Event: RealmRepresentable {
    internal var uid: String { "" }
    
    func asRealm() -> RMEvent {
        .init(JSON: toJSON())!
    }
}
