//
//  PreferenceService.swift
//  DatabasePlatform
//
//  Created by 杨建祥 on 2024/5/13.
//

import Foundation
import Domain
import Combine
import RealmSwift

final class PreferenceService<Repository>: Domain.PreferenceService where Repository: AbstractRepository, Repository.T == Preference {
    
    private let repository: Repository

    init(repository: Repository) {
        self.repository = repository
    }
    
    func preference() -> AnyPublisher<Domain.Preference, any Error> {
        repository.query(with: .init(format: "id = %@", "default"), sortDescriptors: []).map { $0.first ?? .default  }.eraseToAnyPublisher()
    }
    
    func save(preference: Domain.Preference) -> AnyPublisher<Void, any Error> {
        repository.save(entity: preference)
    }

}
