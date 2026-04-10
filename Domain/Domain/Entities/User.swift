//
//  User.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/15.
//

import Foundation
import ObjectMapper
import HiBase

public struct User: UserType {
    
    public var id = ""
    public var phoneVerified: Bool?
    public var emailVerified: Bool?
    public var resetPasswordOnNextLogin: Bool?
    public var loginsCount: Int?
    public var passwordSecurityLevel: Int?
    public var name: String?
    public var username: String?
    public var nickname: String?
    public var phone: String?
    public var email: String?
    public var avatar: String?
    public var country: String?
    public var province: String?
    public var city: String?
    public var address: String?
    public var streetAddress: String?
    public var postalCode: String?
    public var company: String?
    public var identityNumber: String?
    public var lastLoginApp: String?
    public var birthdate: String?
    public var createdAt: String?
    public var updatedAt: String?
    public var signedUp: String?
    public var lastLogin: String?
    public var gender: UserGender?
    public var status: UserStatus?
    public var source: UserSource?
    public var registerSource = [String].init()

    public var isValid: Bool { (!id.isEmpty) && !(username?.isEmpty ?? true) }

    
    public init() { }
    
    public init?(map: ObjectMapper.Map) { }
    
    public mutating func mapping(map: ObjectMapper.Map) {
        id                          <- (map["userId"], StringTransform.shared)
        phoneVerified               <- (map["phoneVerified"], BoolTransform.shared)
        emailVerified               <- (map["emailVerified"], BoolTransform.shared)
        resetPasswordOnNextLogin    <- (map["resetPasswordOnNextLogin"], BoolTransform.shared)
        loginsCount                 <- (map["loginsCount"], IntTransform.shared)
        passwordSecurityLevel       <- (map["passwordSecurityLevel"], IntTransform.shared)
        name                        <- (map["name"], StringTransform.shared)
        username                    <- (map["username"], StringTransform.shared)
        nickname                    <- (map["nickname"], StringTransform.shared)
        phone                       <- (map["phone"], StringTransform.shared)
        email                       <- (map["email"], StringTransform.shared)
        avatar                      <- (map["photo"], StringTransform.shared)
        country                     <- (map["country"], StringTransform.shared)
        province                    <- (map["province"], StringTransform.shared)
        city                        <- (map["city"], StringTransform.shared)
        address                     <- (map["address"], StringTransform.shared)
        streetAddress               <- (map["streetAddress"], StringTransform.shared)
        postalCode                  <- (map["postalCode"], StringTransform.shared)
        company                     <- (map["company"], StringTransform.shared)
        identityNumber              <- (map["identityNumber"], StringTransform.shared)
        lastLoginApp                <- (map["lastLoginApp"], StringTransform.shared)
        birthdate                   <- (map["birthdate"], StringTransform.shared)
        createdAt                   <- (map["createdAt"], StringTransform.shared)
        updatedAt                   <- (map["updatedAt"], StringTransform.shared)
        signedUp                    <- (map["signedUp"], StringTransform.shared)
        lastLogin                   <- (map["lastLogin"], StringTransform.shared)
        gender                      <- (map["gender"], EnumTypeCastTransform<UserGender>())
        status                      <- (map["status"], EnumTypeCastTransform<UserStatus>())
        source                      <- (map["userSourceType"], EnumTypeCastTransform<UserSource>())
        registerSource              <- (map["registerSource"], StringTransform.shared)
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.username == rhs.username &&
        lhs.nickname == rhs.nickname &&
        lhs.avatar == rhs.avatar &&
        lhs.identityNumber == rhs.identityNumber &&
        lhs.phone == rhs.phone &&
        lhs.email == rhs.email &&
        lhs.company == rhs.company &&
        lhs.country == rhs.country &&
        lhs.province == rhs.province &&
        lhs.city == rhs.city &&
        lhs.address == rhs.address &&
        lhs.streetAddress == rhs.streetAddress &&
        lhs.updatedAt == rhs.updatedAt &&
        lhs.birthdate == rhs.birthdate &&
        lhs.status == rhs.status
    }
    
    public func copyWith(id: String) -> User {
        var myUser = self
        myUser.id = id
        return myUser
    }
    
}
