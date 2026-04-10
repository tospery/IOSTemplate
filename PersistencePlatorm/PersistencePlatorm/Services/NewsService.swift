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

final class NewsService<Repository>: Domain.NewsService where Repository: AbstractRepository, Repository.T == News {
    
    private let repository: Repository

    init(repository: Repository) {
        self.repository = repository
    }
    
    func news(channel: String, pageIndex: Int, pageSize: Int) -> AnyPublisher<[Domain.News], any Error> {
        repository.query(with: nil, sortDescriptors: [])
        // repository.query(with: nil, sortDescriptors: []).map { $0.filter { $0.pageType == .trendingRepos } }
        // repository.query(with: .init(format: "pageType = %@", PageType.trendingRepos.rawValue), sortDescriptors: [])
    }

}
