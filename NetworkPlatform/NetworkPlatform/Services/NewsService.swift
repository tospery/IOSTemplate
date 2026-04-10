//
//  NewsService.swift
//  NetworkPlatform
//
//  Created by 杨建祥 on 2024/5/17.
//

import Foundation
import Combine
import Moya
import HiCore
import Domain

final class NewsService: Domain.NewsService {
    
    private let environment: [String: Any]

    init(environment: [String: Any]) {
        self.environment = environment
    }

    func news(channel: String, pageIndex: Int, pageSize: Int) -> AnyPublisher<[Domain.News], any Error> {
        multiNetworking.requestList(
            MultiTarget.init(AlicloudAPI.news(channel: channel, pageIndex: pageIndex, pageSize: pageSize)),
            type: Domain.News.self
        ).map { $0.items }.eraseToAnyPublisher()
    }
    
}
