//
//  Preference.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/12.
//

import Foundation
import ObjectMapper
import HiBase

public struct Preference: ProfileType {
    
    public var id = ""
    public var isDark: Bool?
    public var privateKey: String?
    public var localization: Localization?
    public var searchKeywords = [String].init()
    public var accessToken: AccessToken?
    public var user: User?
    
    public var accentColor: String { UIColor.red.hexString }
    
    public var loginedUser: (any HiBase.UserType)? {
        get { return user }
        set { user = newValue as? User }
    }
    
    public static let `default` = Preference.init(JSON: [ "id": "default" ])!
    
    public init() { }
    
    public init?(map: ObjectMapper.Map) { }
    
    public mutating func mapping(map: ObjectMapper.Map) {
        id                  <- (map["id"], StringTransform.shared)
        isDark              <- (map["isDark"], BoolTransform.shared)
        privateKey          <- (map["privateKey"], StringTransform.shared)
        localization        <- (map["localization"], EnumTypeCastTransform<Localization>())
        searchKeywords      <- (map["searchKeywords"], StringTransform.shared)
        accessToken         <- map["accessToken"]
        user                <- map["user"]
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.isDark == rhs.isDark &&
        lhs.privateKey == rhs.privateKey &&
        lhs.localization == rhs.localization &&
        lhs.searchKeywords == rhs.searchKeywords &&
        lhs.accessToken == rhs.accessToken &&
        lhs.user == rhs.user
    }

}
