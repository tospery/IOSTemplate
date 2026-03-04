//
//  EventService.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/19.
//

import Foundation
import Combine
import Moya
import HiCore
import Domain

final class EventService: Domain.EventService {
    
    private let environment: [String: Any]

    init(environment: [String: Any]) {
        self.environment = environment
    }
    
    func events(owner: String, pageIndex: Int, pageSize: Int) -> AnyPublisher<[Domain.Event], any Error> {
        multiNetworking.requestArray(
            MultiTarget.init(
                GithubBaseAPI.userEvents(owner: owner, pageIndex: pageIndex, pageSize: pageSize)
            ),
            type: Event.self
        )
    }
    
    func save(events: [Domain.Event]) -> AnyPublisher<Void, any Error> {
        fatalError()
    }
    
    func deleteAll() -> AnyPublisher<Void, any Error> {
        fatalError()
    }
    
}
