//
//  NewsService.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/19.
//

import Foundation
import Combine

public protocol NewsService {

    /// 用户信息
    /// - https://api.jisuapi.com/news/get?channel=头条&start=0&num=10&appkey=255887191f61753d
    /// - https://www.jisuapi.com/api/news/
    func news(channel: String, pageIndex: Int, pageSize: Int) -> AnyPublisher<[News], Error>
    
}
