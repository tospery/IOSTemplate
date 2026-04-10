//
//  PTPreference.swift
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

public final class RMPreference: Object, Mappable {
    
    @Persisted(primaryKey: true) var id: String
    @Persisted var isDark: Bool?
    @Persisted var colorTheme: RMColorTheme?
    @Persisted var localization: RMLocalization?
    @Persisted var login: RMLogin?
    @Persisted var user: RMUser?
    
    override init() {
        super.init()
    }
    
    public init?(map: ObjectMapper.Map) {
        super.init()
        id                          <- (map["id"], StringTransform.shared)
    }
    
    public func mapping(map: ObjectMapper.Map) {
        performMapping {
            id                      >>> map["id"]
            isDark                  <- (map["isDark"], BoolTransform.shared)
            colorTheme              <- (map["colorTheme"], EnumTypeCastTransform<RMColorTheme>())
            localization            <- (map["localization"], EnumTypeCastTransform<RMLocalization>())
            login                   <- map["login"]
            user                    <- map["user"]
        }
    }
    
    public func writeThrough(with domain: Domain.Preference) {
        if self.realm == nil {
            self.id = domain.id
        }
        self.isDark = domain.isDark
        self.colorTheme = domain.colorTheme?.asRealm()
        self.localization = domain.localization?.asRealm()
        self.login = domain.login?.asRealm()
        self.user = domain.user?.asRealm()
    }
    
}

extension RMPreference: DomainConvertibleType {
    public func asDomain() -> Domain.Preference {
        .init(JSON: toJSON())!
    }
}

extension Domain.Preference: RealmRepresentable {
    public var uid: String { "" }
    
    public func asRealm() -> RMPreference {
        .init(JSON: toJSON())!
    }
    
}

