//
//  Preference.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/12.
//

import Foundation
import ObjectMapper
import HiBase

public struct Preference: PreferenceType {
    
    public var id = ""
    public var isDark: Bool?
    public var colorTheme: ColorTheme?
    public var localization: Localization?
    public var login: Login?
    public var user: User?
    
    public var accentColor: String { (colorTheme ?? .red).color.hexString }
    
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
        colorTheme          <- (map["colorTheme"], EnumTypeCastTransform<ColorTheme>())
        localization        <- (map["localization"], EnumTypeCastTransform<Localization>())
        login               <- map["login"]
        user                <- map["user"]
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.isDark == rhs.isDark &&
        lhs.colorTheme == rhs.colorTheme &&
        lhs.localization == rhs.localization &&
        lhs.login == rhs.login &&
        lhs.user == rhs.user
    }

}
