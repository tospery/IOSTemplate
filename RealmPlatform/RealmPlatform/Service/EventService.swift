//
//  EventService.swift
//  RealmPlatform
//
//  Created by 杨建祥 on 2024/5/20.
//

import Foundation
import Domain
import Combine
import RealmSwift

final class EventService<Repository>: Domain.EventService where Repository: AbstractRepository, Repository.T == Domain.Event {

    private let repository: Repository

    init(repository: Repository) {
        self.repository = repository
    }
    
    func events(owner: String, pageIndex: Int, pageSize: Int) -> AnyPublisher<[Domain.Event], any Error> {
        repository.query(with: nil, sortDescriptors: [])
    }
    
    func save(events: [Domain.Event]) -> AnyPublisher<Void, any Error> {
        repository.save(entities: events)
    }
    
    func deleteAll() -> AnyPublisher<Void, any Error> {
        repository.delete(type: Repository.T.self)
    }
    
}
