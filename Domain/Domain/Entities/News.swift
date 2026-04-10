//
//  News.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/18.
//

import Foundation
import ObjectMapper
import HiBase

public struct News: ModelType {

    public var id = ""
    public var title: String?
    public var time: String?
    public var src: String?
    public var category: String?
    public var pic: String?
    public var weburl: String?
    public var content: String?
    
    var url: String { self.id }

    public init() { }
    
    public init?(map: ObjectMapper.Map) { }
    
    public mutating func mapping(map: ObjectMapper.Map) {
        id              <- (map["url"], StringTransform.shared)
        title           <- (map["title"], StringTransform.shared)
        time            <- (map["time"], StringTransform.shared)
        src             <- (map["src"], StringTransform.shared)
        category        <- (map["category"], StringTransform.shared)
        pic             <- (map["pic"], StringTransform.shared)
        weburl          <- (map["weburl"], StringTransform.shared)
        content         <- (map["content"], StringTransform.shared)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.time == rhs.time &&
        lhs.src == rhs.src &&
        lhs.category == rhs.category &&
        lhs.pic == rhs.pic &&
        lhs.weburl == rhs.weburl &&
        lhs.content == rhs.content
    }

}

