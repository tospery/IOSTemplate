//
//  RMLanguage.swift
//  DatabasePlatform
//
//  Created by 杨建祥 on 2024/5/12.
//

import Foundation
import ObjectMapper
import RealmSwift
import Domain
import HiBase
import HiRealm

class RMLanguage: Object, Mappable {
    
    @Persisted(primaryKey: true) var id: String
    @Persisted var name: String?
    
    override init() {
        super.init()
    }
    
    required init?(map: ObjectMapper.Map) {
        super.init()
        id                          <- (map["urlParam"], StringTransform.shared)
    }
    
    func mapping(map: ObjectMapper.Map) {
        performMapping {
            id                      >>> map["urlParam"]
            name                    <- (map["name"], StringTransform.shared)
        }
    }
    
    override class func propertiesMapping() -> [String: String] {
        [
            "id": "urlParam"
        ]
    }

}

extension RMLanguage: DomainConvertibleType {
    func asDomain() -> Language {
        .init(JSON: toJSON())!
    }
}

extension Language: RealmRepresentable {
    internal var uid: String { "" }
    
    func asRealm() -> RMLanguage {
        .init(JSON: toJSON())!
    }

}
