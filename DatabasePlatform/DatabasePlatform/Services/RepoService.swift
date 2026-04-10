//
//  RepoService.swift
//  DatabasePlatform
//
//  Created by 杨建祥 on 2024/5/20.
//

import Foundation
import Domain
import Combine
import RealmSwift

final class RepoService<Repository>: Domain.RepoService where Repository: AbstractRepository, Repository.T == Repo {

    private let repository: Repository

    init(repository: Repository) {
        self.repository = repository
    }
    
    func star(owner: String, repo: String) -> AnyPublisher<Void, any Error> {
        fatalError()
    }
    
    func unstar(owner: String, repo: String) -> AnyPublisher<Void, any Error> {
        fatalError()
    }
    
    func checkStarring(owner: String, repo: String) -> AnyPublisher<Bool, any Error> {
        fatalError()
    }
    
    func repo(owner: String, repo: String) -> AnyPublisher<Domain.Repo, any Error> {
        fatalError()
    }
    
    func repos(owner: String, pageIndex: Int, pageSize: Int) -> AnyPublisher<[Domain.Repo], any Error> {
        repository.query(with: nil, sortDescriptors: [])
    }
    
    func starred(owner: String, pageIndex: Int, pageSize: Int) -> AnyPublisher<[Domain.Repo], any Error> {
        repository.query(with: nil, sortDescriptors: []).map { $0.filter { $0.pageType == .stars } }.eraseToAnyPublisher()
    }
    
    func subscriptions(owner: String, pageIndex: Int, pageSize: Int) -> AnyPublisher<[Domain.Repo], any Error> {
        repository.query(with: nil, sortDescriptors: [])
    }
    
    func forks(owner: String, repo: String, pageIndex: Int, pageSize: Int) -> AnyPublisher<[Domain.Repo], any Error> {
        repository.query(with: nil, sortDescriptors: [])
    }
    
    func trending(language: Domain.Language?, since: Domain.TrendingSince?) -> AnyPublisher<[Domain.Repo], any Error> {
        // repository.query(with: nil, sortDescriptors: []).map { $0.filter { $0.pageType == .trendingRepos } }
        repository.query(with: .init(format: "pageType = %@", PageType.trendingRepos.rawValue), sortDescriptors: [])
    }
    
    func search(keyword: String, language: Domain.Language?, sort: String, order: Domain.OrderType, pageIndex: Int, pageSize: Int) -> AnyPublisher<[Domain.Repo], any Error> {
        repository.query(with: nil, sortDescriptors: [])
    }
    
    func repos() -> AnyPublisher<[Domain.Repo], any Error> {
        repository.query(with: nil, sortDescriptors: [])
    }
    
    func save(repos: [Domain.Repo]) -> AnyPublisher<Void, any Error> {
        repository.save(entities: repos)
    }
    
    func delete(repos: [Domain.Repo]) -> AnyPublisher<Void, any Error> {
        repository.delete(entities: repos)
    }
}
