//
//  PreferenceService.swift
//  NetworkPlatform
//
//  Created by 杨建祥 on 2024/5/22.
//

import Foundation
import Combine
import Moya
import HiCore
import Domain

final class PreferenceService: Domain.PreferenceService {

    private let environment: [String: Any]

    init(environment: [String: Any]) {
        self.environment = environment
    }

    func preference() -> AnyPublisher<Domain.Preference?, any Error> {
        fatalError()
    }
    
    func save(preference: Domain.Preference) -> AnyPublisher<Void, any Error> {
        NetworkPlatform.preference = preference
        return Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
}

