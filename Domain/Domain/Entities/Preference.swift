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
    public var privateKey: String?
    public var colorTheme: ColorTheme?
    public var searchType: SearchType?
    public var trendingSince: TrendingSince?
    public var localization: Localization?
    public var searchKeywords = [String].init()
    public var searchLanguage: Language?
    public var trendingLanguage: Language?
    public var accessToken: AccessToken?
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
        privateKey          <- (map["privateKey"], StringTransform.shared)
        colorTheme          <- (map["colorTheme"], EnumTypeCastTransform<ColorTheme>())
        searchType          <- (map["searchType"], EnumTypeCastTransform<SearchType>())
        trendingSince       <- (map["trendingSince"], EnumTypeCastTransform<TrendingSince>())
        localization        <- (map["localization"], EnumTypeCastTransform<Localization>())
        searchKeywords      <- (map["searchKeywords"], StringTransform.shared)
        searchLanguage      <- map["searchLanguage"]
        trendingLanguage    <- map["trendingLanguage"]
        accessToken         <- map["accessToken"]
        user                <- map["user"]
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.isDark == rhs.isDark &&
        lhs.privateKey == rhs.privateKey &&
        lhs.colorTheme == rhs.colorTheme &&
        lhs.localization == rhs.localization &&
        lhs.searchType == rhs.searchType &&
        lhs.searchLanguage == rhs.searchLanguage &&
        lhs.searchKeywords == rhs.searchKeywords &&
        lhs.trendingSince == rhs.trendingSince &&
        lhs.trendingLanguage == rhs.trendingLanguage &&
        lhs.accessToken == rhs.accessToken &&
        lhs.user == rhs.user
    }

}
