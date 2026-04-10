//
//  LanguageService.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/12.
//

import Foundation
import Combine

public protocol LanguageService {

    func languages() -> AnyPublisher<[Language], Error>
    func save(languages: [Language]) -> AnyPublisher<Void, Error>

}
