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

class RMLogin: Object, Mappable {
    
    @Persisted(primaryKey: true) var id: String
    @Persisted var scope: String?
    @Persisted var tokenType: String?
    @Persisted var accessToken: String?
    @Persisted var expiresIn: Int?
    
    override init() {
        super.init()
    }
    
    required init?(map: ObjectMapper.Map) {
        super.init()
        id                          <- (map["id_token"], StringTransform.shared)
    }
    
    func mapping(map: ObjectMapper.Map) {
        performMapping {
            id                      >>> map["id_token"]
            scope                   <- (map["scope"], StringTransform.shared)
            tokenType               <- (map["tokenType"], StringTransform.shared)
            accessToken             <- (map["accessToken"], StringTransform.shared)
            expiresIn               <- (map["expiresIn"], IntTransform.shared)
        }
    }
    
    override class func propertiesMapping() -> [String : String] {
        [
            "id":"id_token",
        ]
    }
}

extension RMLogin: DomainConvertibleType {
    func asDomain() -> Domain.Login {
        .init(JSON: toJSON())!
    }
}

extension Domain.Login: RealmRepresentable {
    internal var uid: String { "" }
    
    func asRealm() -> RMLogin {
        .init(JSON: toJSON())!
    }
}
