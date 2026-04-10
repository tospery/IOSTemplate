//
//  UserService.swift
//  DatabasePlatform
//
//  Created by 杨建祥 on 2024/5/20.
//

import Foundation
import Domain
import Combine
import RealmSwift

final class UserService<Repository>: Domain.UserService where Repository: AbstractRepository, Repository.T == Domain.User {
    
    private let repository: Repository

    init(repository: Repository) {
        self.repository = repository
    }
    
    func user(token: String) -> AnyPublisher<Domain.User, any Error> {
        repository.query(with: nil, sortDescriptors: []).map { $0.first ?? .init() }.eraseToAnyPublisher()
    }
    
//    func follow(owner: String) -> AnyPublisher<Void, any Error> {
//        fatalError()
//    }
//    
//    func unfollow(owner: String) -> AnyPublisher<Void, any Error> {
//        fatalError()
//    }
//    
//    func checkFollowing(owner: String) -> AnyPublisher<Bool, any Error> {
//        fatalError()
//    }
//    
//    func login(token: String) -> AnyPublisher<Domain.User, any Error> {
//        fatalError()
//    }
//    
//    func user(owner: String) -> AnyPublisher<Domain.User, any Error> {
//        fatalError()
//    }
//    
//    func modify(key: String, value: String) -> AnyPublisher<Domain.User, any Error> {
//        fatalError()
//    }
//    
//    func followers(owner: String, pageIndex: Int, pageSize: Int) -> AnyPublisher<[Domain.User], any Error> {
//        repository.query(with: nil, sortDescriptors: [])
//    }
//    
//    func following(owner: String, pageIndex: Int, pageSize: Int) -> AnyPublisher<[Domain.User], any Error> {
//        repository.query(with: nil, sortDescriptors: [])
//    }
//    
//    func stargazers(owner: String, repo: String, pageIndex: Int, pageSize: Int) -> AnyPublisher<[Domain.User], any Error> {
//        repository.query(with: nil, sortDescriptors: [])
//    }
//    
//    func trending(language: Domain.Language?, since: Domain.TrendingSince?) -> AnyPublisher<[Domain.User], any Error> {
//        repository.query(with: nil, sortDescriptors: []).map { $0.filter { $0.pageType == .trendingUsers } }.eraseToAnyPublisher()
//    }
//    
//    func contributors(owner: String, repo: String, pageIndex: Int, pageSize: Int) -> AnyPublisher<[Domain.User], any Error> {
//        repository.query(with: nil, sortDescriptors: [])
//    }
//    
//    func subscribers(owner: String, repo: String, pageIndex: Int, pageSize: Int) -> AnyPublisher<[Domain.User], any Error> {
//        repository.query(with: nil, sortDescriptors: [])
//    }
//    
//    func search(keyword: String, sort: String, order: Domain.OrderType, pageIndex: Int, pageSize: Int) -> AnyPublisher<[Domain.User], any Error> {
//        repository.query(with: nil, sortDescriptors: [])
//    }
//    
//    func users() -> AnyPublisher<[Domain.User], any Error> {
//        repository.query(with: nil, sortDescriptors: [])
//    }
//    
//    func save(users: [Domain.User]) -> AnyPublisher<Void, any Error> {
//        repository.save(entities: users)
//    }
//    
//    func delete(users: [Domain.User]) -> AnyPublisher<Void, any Error> {
//        repository.delete(entities: users)
//    }

}
