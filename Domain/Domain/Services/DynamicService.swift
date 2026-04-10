//
//  DynamicService.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/19.
//

import Foundation
import Combine

public protocol DynamicService {

    func file(urlString: String, baseString: String) -> AnyPublisher<Any, Error>
    
}
