//
//  Observable+Ex.swift
//  RealmPlatform
//
//  Created by 杨建祥 on 2024/5/13.
//

import Foundation
import Combine

extension Publisher where Output: Sequence, Output.Element: DomainConvertibleType {
    typealias DomainType = Output.Element.DomainType

    func mapToDomain() -> AnyPublisher<[DomainType], Failure> {
        return self.map { sequence -> [DomainType] in
            return sequence.mapToDomain()
        }
        .eraseToAnyPublisher()
    }
}

extension Sequence where Iterator.Element: DomainConvertibleType {
    typealias Element = Iterator.Element
    func mapToDomain() -> [Element.DomainType] {
        return map {
            return $0.asDomain()
        }
    }
}
