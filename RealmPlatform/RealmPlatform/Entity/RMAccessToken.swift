//
//  RMAccessToken.swift
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

class RMAccessToken: Object, Mappable {
    
    @Persisted(primaryKey: true) var id: String
    @Persisted var tokenType: String?
    @Persisted var scope: String?
    
    override init() {
        super.init()
    }
    
    required init?(map: ObjectMapper.Map) {
        super.init()
        id                          <- (map["access_token"], StringTransform.shared)
    }
    
    func mapping(map: ObjectMapper.Map) {
        performMapping {
            id                      >>> map["access_token"]
            tokenType               <- (map["token_type"], StringTransform.shared)
            scope                   <- (map["scope"], StringTransform.shared)
        }
    }
    
    override class func propertiesMapping() -> [String : String] {
        [
            "id":"access_token",
            "tokenType":"token_type"
        ]
    }
}

extension RMAccessToken: DomainConvertibleType {
    func asDomain() -> AccessToken {
        .init(JSON: toJSON())!
    }
}

extension AccessToken: RealmRepresentable {
    internal var uid: String { "" }
    
    func asRealm() -> RMAccessToken {
        .init(JSON: toJSON())!
    }
}
