//
//  Array+Ex.swift
//  RealmPlatform
//
//  Created by 杨建祥 on 2024/5/12.
//

import Foundation
import RealmSwift

extension Array where Element: RealmCollectionValue {

    func toList() -> List<Element> {
        let list = List<Element>.init()
        forEach { item in
            list.append(item)
        }
        return list
    }
    
}
