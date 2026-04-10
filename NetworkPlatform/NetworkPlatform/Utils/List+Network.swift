//
//  List+Network.swift
//  NetworkPlatform
//
//  Created by 杨建祥 on 2024/5/19.
//

import Foundation
import HiCore
import HiNet
import ObjectMapper

extension List: @retroactive ListCompatible {
    public func hasNext(map: Map) -> Bool {
        var hasNext: Bool?
        hasNext   <- map["incomplete_results"]
        return !(hasNext ?? false)
    }
    
    public func count(map: Map) -> Int {
        var count: Int?
        count   <- map["total_count"]
        return count ?? 0
    }
    
    public func items<ListItem>(map: Map) -> [ListItem] where ListItem: Mappable {
        var items: [ListItem]?
        items    <- map["items"]
        return items ?? []
    }
}
