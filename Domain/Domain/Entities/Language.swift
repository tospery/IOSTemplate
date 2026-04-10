//
//  Language.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/12.
//

import Foundation
import ObjectMapper
import HiBase

public struct Language: ModelType {
    
    
    public var id: String = ""
    public var name: String?

    public static let any = Language.init(JSON: [
        "urlParam": "*",
        "name": "Any language"
    ])!
    
    public init() { }
    
    public init(id: String) {
        self.id = id
    }

    public init?(map: ObjectMapper.Map) { }
    
    public mutating func mapping(map: ObjectMapper.Map) {
        id              <- (map["urlParam"], StringTransform.shared)
        name            <- (map["name"], StringTransform.shared)
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name
    }
    
}
