//
//  RealmRepresentable.swift
//  RealmPlatform
//
//  Created by 杨建祥 on 2024/5/12.
//

import Foundation

protocol RealmRepresentable {
    associatedtype RealmType: DomainConvertibleType

    var uid: String { get }

    func asRealm() -> RealmType
}
