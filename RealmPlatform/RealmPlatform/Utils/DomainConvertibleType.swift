//
//  DomainConvertibleType.swift
//  RealmPlatform
//
//  Created by 杨建祥 on 2024/5/12.
//

import Foundation

protocol DomainConvertibleType {
    associatedtype DomainType

    func asDomain() -> DomainType
}
