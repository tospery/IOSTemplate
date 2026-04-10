//
//  RepoService.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/19.
//

import Foundation
import Combine

public protocol RepoService {

    func star(owner: String, repo: String) -> AnyPublisher<Void, Error>
    func unstar(owner: String, repo: String) -> AnyPublisher<Void, Error>
    func checkStarring(owner: String, repo: String) -> AnyPublisher<Bool, Error>
    
    /// 仓库详情
    /// - Demo: https://api.github.com/repos/ReactiveX/RxSwift
    func repo(owner: String, repo: String) -> AnyPublisher<Repo, Error>
    func repos(owner: String, pageIndex: Int, pageSize: Int) -> AnyPublisher<[Repo], Error>
    func starred(owner: String, pageIndex: Int, pageSize: Int) -> AnyPublisher<[Repo], Error>
    func subscriptions(owner: String, pageIndex: Int, pageSize: Int) -> AnyPublisher<[Repo], Error>
    func forks(owner: String, repo: String, pageIndex: Int, pageSize: Int) -> AnyPublisher<[Repo], Error>
    func trending(language: Language?, since: TrendingSince?) -> AnyPublisher<[Repo], Error>
    
    func search(keyword: String, language: Language?, sort: String, order: OrderType, pageIndex: Int, pageSize: Int) -> AnyPublisher<[Repo], Error>
    
    func repos() -> AnyPublisher<[Repo], Error>
    func save(repos: [Repo]) -> AnyPublisher<Void, Error>
    func delete(repos: [Repo]) -> AnyPublisher<Void, Error>
}
