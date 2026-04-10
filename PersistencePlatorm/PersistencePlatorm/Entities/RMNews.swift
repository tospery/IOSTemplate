//
//  PTNews.swift
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

class RMNews: Object, Mappable {
    
    @Persisted(primaryKey: true) var id: String
    @Persisted var title: String?
    @Persisted var time: String?
    @Persisted var src: String?
    @Persisted var category: String?
    @Persisted var pic: String?
    @Persisted var weburl: String?
    @Persisted var content: String?
    
    override init() {
        super.init()
    }
    
    required init?(map: ObjectMapper.Map) {
        super.init()
        id              <- (map["url"], StringTransform.shared)
    }
    
    func mapping(map: ObjectMapper.Map) {
        performMapping {
            id                      >>> map["url"]
            title                   <- (map["title"], StringTransform.shared)
            time                    <- (map["time"], StringTransform.shared)
            src                     <- (map["src"], StringTransform.shared)
            category                <- (map["category"], StringTransform.shared)
            pic                     <- (map["pic"], StringTransform.shared)
            weburl                  <- (map["weburl"], StringTransform.shared)
            content                 <- (map["content"], StringTransform.shared)
        }
    }
    
    override class func propertiesMapping() -> [String: String] {
        [
            "id": "url"
        ]
    }
}

extension RMNews: DomainConvertibleType {
    func asDomain() -> Domain.News {
        .init(JSON: toJSON())!
    }
}

extension Domain.News: RealmRepresentable {
    internal var uid: String { "" }
    
    func asRealm() -> RMNews {
        .init(JSON: toJSON())!
    }

}

