//
//  EventService.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/19.
//

import Foundation
import Combine

public protocol EventService {
    
    func events(owner: String, pageIndex: Int, pageSize: Int) -> AnyPublisher<[Event], Error>
    func save(events: [Event]) -> AnyPublisher<Void, Error>
    func deleteAll() -> AnyPublisher<Void, Error>
    
}
