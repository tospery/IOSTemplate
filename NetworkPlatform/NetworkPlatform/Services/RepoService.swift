//
//  RepoService.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/19.
//

import Foundation
import Combine
import Moya
import HiCore
import Domain

final class RepoService: Domain.RepoService {
    
    private let environment: [String: Any]

    init(environment: [String: Any]) {
        self.environment = environment
    }
    
    func star(owner: String, repo: String) -> AnyPublisher<Void, any Error> {
        multiNetworking.requestRaw(
            MultiTarget.init(
                GithubBaseAPI.star(owner: owner, repo: repo)
            )
        ).map { _ in () }.eraseToAnyPublisher()
    }
    
    func unstar(owner: String, repo: String) -> AnyPublisher<Void, any Error> {
        multiNetworking.requestRaw(
            MultiTarget.init(
                GithubBaseAPI.unstar(owner: owner, repo: repo)
            )
        ).map { _ in () }.eraseToAnyPublisher()
    }
    
    func checkStarring(owner: String, repo: String) -> AnyPublisher<Bool, any Error> {
        multiNetworking.requestRaw(
            MultiTarget.init(
                GithubBaseAPI.checkStarring(owner: owner, repo: repo)
            )
        ).map { _ in true }.eraseToAnyPublisher()
    }
    
    func repo(owner: String, repo: String) -> AnyPublisher<Domain.Repo, any Error> {
        multiNetworking.requestObject(
            MultiTarget.init(
                GithubBaseAPI.repo(owner: owner, repo: repo)
            ),
            type: Repo.self
        )
    }
    
    func repos(owner: String, pageIndex: Int, pageSize: Int) -> AnyPublisher<[Domain.Repo], any Error> {
        multiNetworking.requestArray(
            MultiTarget.init(
                GithubBaseAPI.repos(owner: owner, pageIndex: pageIndex, pageSize: pageSize)
            ),
            type: Repo.self
        )
    }
    
    func starred(owner: String, pageIndex: Int, pageSize: Int) -> AnyPublisher<[Domain.Repo], any Error> {
        multiNetworking.requestArray(
            MultiTarget.init(
                GithubBaseAPI.starred(owner: owner, pageIndex: pageIndex, pageSize: pageSize)
            ),
            type: Repo.self
        )
        .map { $0.map { $0.copyWith(pageType: .stars) } }
        .eraseToAnyPublisher()
    }
    
    func subscriptions(owner: String, pageIndex: Int, pageSize: Int) -> AnyPublisher<[Domain.Repo], any Error> {
        multiNetworking.requestArray(
            MultiTarget.init(
                GithubBaseAPI.subscriptions(owner: owner, pageIndex: pageIndex, pageSize: pageSize)
            ),
            type: Repo.self
        )
    }
    
    func forks(owner: String, repo: String, pageIndex: Int, pageSize: Int) -> AnyPublisher<[Domain.Repo], any Error> {
        multiNetworking.requestArray(
            MultiTarget.init(
                GithubBaseAPI.forks(owner: owner, repo: repo, pageIndex: pageIndex, pageSize: pageSize)
            ),
            type: Repo.self
        )
    }
    
    func trending(language: Domain.Language?, since: Domain.TrendingSince?) -> AnyPublisher<[Domain.Repo], any Error> {
        multiNetworking.requestArray(
            MultiTarget.init(
                TrendingAPI.repos(language: language, since: since)
            ),
            type: Repo.self
        )
        .map { $0.map { $0.copyWith(pageType: .trendingRepos) } }
        .eraseToAnyPublisher()
    }
    
    func search(keyword: String, language: Domain.Language?, sort: String, order: Domain.OrderType, pageIndex: Int, pageSize: Int) -> AnyPublisher<[Domain.Repo], any Error> {
        multiNetworking.requestList(
            MultiTarget.init(
                GithubBaseAPI.searchRepos(keyword: keyword, language: language, sort: sort, order: order, pageIndex: pageIndex, pageSize: pageSize)
            ),
            type: Repo.self
        ).map { $0.items }.eraseToAnyPublisher()
    }
    
    func repos() -> AnyPublisher<[Domain.Repo], any Error> {
        fatalError()
    }
    
    func save(repos: [Domain.Repo]) -> AnyPublisher<Void, any Error> {
        fatalError()
    }
    
    func delete(repos: [Domain.Repo]) -> AnyPublisher<Void, any Error> {
        fatalError()
    }

}
