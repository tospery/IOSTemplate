//
//  RMPreference.swift
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

final class RMPreference: Object, Mappable {
    
    @Persisted(primaryKey: true) var id: String
    @Persisted var isDark: Bool?
    @Persisted var privateKey: String?
    @Persisted var colorTheme: RMColorTheme?
    @Persisted var searchType: RMSearchType?
    @Persisted var trendingSince: RMTrendingSince?
    @Persisted var localization: RMLocalization?
    @Persisted var searchKeywords: RealmSwift.List<String>
    @Persisted var searchLanguage: RMLanguage?
    @Persisted var trendingLanguage: RMLanguage?
    @Persisted var accessToken: RMAccessToken?
    @Persisted var user: RMUser?
    
    override init() {
        super.init()
    }
    
    init?(map: ObjectMapper.Map) {
        super.init()
        id                          <- (map["id"], StringTransform.shared)
    }
    
    func mapping(map: ObjectMapper.Map) {
        performMapping {
            id                      >>> map["id"]
            isDark                  <- (map["isDark"], BoolTransform.shared)
            privateKey              <- (map["privateKey"], StringTransform.shared)
            colorTheme              <- (map["colorTheme"], EnumTypeCastTransform<RMColorTheme>())
            searchType              <- (map["searchType"], EnumTypeCastTransform<RMSearchType>())
            trendingSince           <- (map["trendingSince"], EnumTypeCastTransform<RMTrendingSince>())
            localization            <- (map["localization"], EnumTypeCastTransform<RMLocalization>())
            searchKeywords          <- (map["searchKeywords"], StringTransform.shared)
            searchLanguage          <- map["searchLanguage"]
            trendingLanguage        <- map["trendingLanguage"]
            accessToken             <- map["accessToken"]
            user                    <- map["user"]
        }
    }
}

extension RMPreference: DomainConvertibleType {
    func asDomain() -> Preference {
        .init(JSON: toJSON())!
    }
}

extension Preference: RealmRepresentable {
    internal var uid: String { "" }
    
    func asRealm() -> RMPreference {
        .init(JSON: toJSON())!
    }
    
}

