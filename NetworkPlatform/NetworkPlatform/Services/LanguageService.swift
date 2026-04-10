//
//  LanguageService.swift
//  NetworkPlatform
//
//  Created by 杨建祥 on 2024/5/17.
//

import Foundation
import Combine
import Moya
import HiCore
import Domain

final class LanguageService: Domain.LanguageService {
    
    private let environment: [String: Any]

    init(environment: [String: Any]) {
        self.environment = environment
    }
    
    func languages() -> AnyPublisher<[Domain.Language], any Error> {
//        multiNetworking.requestArray(
//            MultiTarget.init(
//                TrendingAPI.languages
//            ),
//            type: Language.self
//        )
        fatalError()
    }
    
    func save(languages: [Domain.Language]) -> AnyPublisher<Void, any Error> {
        fatalError()
    }

}
