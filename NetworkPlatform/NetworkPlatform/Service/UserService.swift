//
//  UserService.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/19.
//

import Foundation
import Combine
import Moya
import HiCore
import Domain

final class UserService: Domain.UserService {
    
    private let environment: [String: Any]

    init(environment: [String: Any]) {
        self.environment = environment
    }
    
    func follow(owner: String) -> AnyPublisher<Void, any Error> {
        multiNetworking.requestRaw(
            MultiTarget.init(
                GithubBaseAPI.follow(owner: owner)
            )
        ).map { _ in () }.eraseToAnyPublisher()
    }
    
    func unfollow(owner: String) -> AnyPublisher<Void, any Error> {
        multiNetworking.requestRaw(
            MultiTarget.init(
                GithubBaseAPI.unfollow(owner: owner)
            )
        ).map { _ in () }.eraseToAnyPublisher()
    }
    
    func checkFollowing(owner: String) -> AnyPublisher<Bool, any Error> {
        multiNetworking.requestRaw(
            MultiTarget.init(
                GithubBaseAPI.checkFollowing(owner: owner)
            )
        ).map { _ in true }.eraseToAnyPublisher()
    }
    
    func login(token: String) -> AnyPublisher<Domain.User, any Error> {
        multiNetworking.requestObject(
            MultiTarget.init(
                GithubBaseAPI.login(token: token)
            ),
            type: User.self
        )
    }
    
    func user(owner: String) -> AnyPublisher<Domain.User, any Error> {
        multiNetworking.requestObject(
            MultiTarget.init(
                GithubBaseAPI.user(owner: owner)
            ),
            type: User.self
        )
    }
    
    func modify(key: String, value: String) -> AnyPublisher<Domain.User, any Error> {
        multiNetworking.requestObject(
            MultiTarget.init(
                GithubBaseAPI.modify(key: key, value: value)
            ),
            type: User.self
        )
    }
    
    func followers(owner: String, pageIndex: Int, pageSize: Int) -> AnyPublisher<[Domain.User], any Error> {
        multiNetworking.requestArray(
            MultiTarget.init(
                GithubBaseAPI.followers(owner: owner, pageIndex: pageIndex, pageSize: pageSize)
            ),
            type: User.self
        )
        .map { $0.map { $0.copyWith(pageType: .followers) } }
        .eraseToAnyPublisher()
    }
    
    func following(owner: String, pageIndex: Int, pageSize: Int) -> AnyPublisher<[Domain.User], any Error> {
        multiNetworking.requestArray(
            MultiTarget.init(
                GithubBaseAPI.following(owner: owner, pageIndex: pageIndex, pageSize: pageSize)
            ),
            type: User.self
        )
        .map { $0.map { $0.copyWith(pageType: .following) } }
        .eraseToAnyPublisher()
    }
    
    func stargazers(owner: String, repo: String, pageIndex: Int, pageSize: Int) -> AnyPublisher<[Domain.User], any Error> {
        multiNetworking.requestArray(
            MultiTarget.init(
                GithubBaseAPI.stargazers(owner: owner, repo: repo, pageIndex: pageIndex, pageSize: pageSize)
            ),
            type: User.self
        )
        .map { $0.map { $0.copyWith(pageType: .stargazers) } }
        .eraseToAnyPublisher()
    }
    
    func contributors(owner: String, repo: String, pageIndex: Int, pageSize: Int) -> AnyPublisher<[Domain.User], any Error> {
        multiNetworking.requestArray(
            MultiTarget.init(
                GithubBaseAPI.contributors(owner: owner, repo: repo, pageIndex: pageIndex, pageSize: pageSize)
            ),
            type: User.self
        )
        .map { $0.map { $0.copyWith(pageType: .contributors) } }
        .eraseToAnyPublisher()
    }
    
    func subscribers(owner: String, repo: String, pageIndex: Int, pageSize: Int) -> AnyPublisher<[Domain.User], any Error> {
        multiNetworking.requestArray(
            MultiTarget.init(
                GithubBaseAPI.subscribers(owner: owner, repo: repo, pageIndex: pageIndex, pageSize: pageSize)
            ),
            type: User.self
        )
        .map { $0.map { $0.copyWith(pageType: .subscribers) } }
        .eraseToAnyPublisher()
    }
    
    func users() -> AnyPublisher<[Domain.User], any Error> {
        fatalError()
    }
    
    func save(users: [Domain.User]) -> AnyPublisher<Void, any Error> {
        fatalError()
    }
    
    func delete(users: [Domain.User]) -> AnyPublisher<Void, any Error> {
        fatalError()
    }

}
