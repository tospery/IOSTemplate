//
//  PTUser.swift
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

class RMUser: Object, Mappable {
    
    @Persisted(primaryKey: true) var id: String
    @Persisted var phoneVerified: Bool?
    @Persisted var emailVerified: Bool?
    @Persisted var resetPasswordOnNextLogin: Bool?
    @Persisted var loginsCount: Int?
    @Persisted var passwordSecurityLevel: Int?
    @Persisted var name: String?
    @Persisted var username: String?
    @Persisted var nickname: String?
    @Persisted var phone: String?
    @Persisted var email: String?
    @Persisted var avatar: String?
    @Persisted var country: String?
    @Persisted var province: String?
    @Persisted var city: String?
    @Persisted var address: String?
    @Persisted var streetAddress: String?
    @Persisted var postalCode: String?
    @Persisted var company: String?
    @Persisted var identityNumber: String?
    @Persisted var lastLoginApp: String?
    @Persisted var birthdate: String?
    @Persisted var createdAt: String?
    @Persisted var updatedAt: String?
    @Persisted var signedUp: String?
    @Persisted var lastLogin: String?
    @Persisted var gender: RMUserGender?
    @Persisted var status: RMUserStatus?
    @Persisted var source: RMUserSource?
    @Persisted var registerSource: RealmSwift.List<String>
    
    override init() {
        super.init()
    }
    
    required init?(map: ObjectMapper.Map) {
        super.init()
        id                                  <- (map["userId"], StringTransform.shared)
    }
    
    func mapping(map: ObjectMapper.Map) {
        performMapping {
            id                              >>> map["userId"]
            phoneVerified                   <- (map["phoneVerified"], BoolTransform.shared)
            emailVerified                   <- (map["emailVerified"], BoolTransform.shared)
            resetPasswordOnNextLogin        <- (map["resetPasswordOnNextLogin"], BoolTransform.shared)
            loginsCount                     <- (map["loginsCount"], IntTransform.shared)
            passwordSecurityLevel           <- (map["passwordSecurityLevel"], IntTransform.shared)
            name                            <- (map["name"], StringTransform.shared)
            username                        <- (map["username"], StringTransform.shared)
            nickname                        <- (map["nickname"], StringTransform.shared)
            phone                           <- (map["phone"], StringTransform.shared)
            email                           <- (map["email"], StringTransform.shared)
            avatar                          <- (map["avatar"], StringTransform.shared)
            country                         <- (map["country"], StringTransform.shared)
            province                        <- (map["province"], StringTransform.shared)
            city                            <- (map["city"], StringTransform.shared)
            address                         <- (map["address"], StringTransform.shared)
            streetAddress                   <- (map["streetAddress"], StringTransform.shared)
            postalCode                      <- (map["postalCode"], StringTransform.shared)
            company                         <- (map["company"], StringTransform.shared)
            identityNumber                  <- (map["identityNumber"], StringTransform.shared)
            lastLoginApp                    <- (map["lastLoginApp"], StringTransform.shared)
            birthdate                       <- (map["birthdate"], StringTransform.shared)
            createdAt                       <- (map["createdAt"], StringTransform.shared)
            updatedAt                       <- (map["updatedAt"], StringTransform.shared)
            signedUp                        <- (map["signedUp"], StringTransform.shared)
            lastLogin                       <- (map["lastLogin"], StringTransform.shared)
            gender                          <- (map["gender"], EnumTypeCastTransform<RMUserGender>())
            status                          <- (map["status"], EnumTypeCastTransform<RMUserStatus>())
            source                          <- (map["userSourceType"], EnumTypeCastTransform<RMUserSource>())
            registerSource                  <- (map["registerSource"], StringTransform.shared)
        }
    }
    
    override class func propertiesMapping() -> [String: String] {
        [
            "id": "userId",
            "source": "userSourceType"
        ]
    }
}

extension RMUser: DomainConvertibleType {
    func asDomain() -> Domain.User {
        .init(JSON: toJSON())!
    }
}

extension Domain.User: RealmRepresentable {
    internal var uid: String { "" }
    
    func asRealm() -> RMUser {
        .init(JSON: toJSON())!
    }
}
