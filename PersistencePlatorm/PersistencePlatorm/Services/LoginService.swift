//
//  LoginService.swift
//  DatabasePlatform
//
//  Created by 杨建祥 on 2024/5/13.
//

import Foundation
import Domain
import Combine
import RealmSwift

final class LoginService<Repository>: Domain.LoginService where Repository: AbstractRepository, Repository.T == Login {
    
    private let repository: Repository

    init(repository: Repository) {
        self.repository = repository
    }
    
    func login(account: String, password: String) -> AnyPublisher<Domain.Login, any Error> {
        repository.query(with: nil, sortDescriptors: []).map { $0.first ?? .init() }.eraseToAnyPublisher()
        // repository.query(with: .init(format: "id = %@", "default"), sortDescriptors: []).map { $0.first }.eraseToAnyPublisher()
    }
    
//    func languages() -> AnyPublisher<[Domain.Language], any Error> {
//        repository.query(with: nil, sortDescriptors: [])
//    }
//    
//    func save(languages: [Domain.Language]) -> AnyPublisher<Void, any Error> {
//        repository.save(entities: languages)
//    }
    
}
