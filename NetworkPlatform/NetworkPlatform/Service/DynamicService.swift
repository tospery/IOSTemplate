//
//  DynamicService.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/19.
//

import Foundation
import Combine
import Moya
import HiBase
import HiCore
import HiNet
import Domain

final class DynamicService: Domain.DynamicService {
    
    private let environment: [String: Any]

    init(environment: [String: Any]) {
        self.environment = environment
    }
    
    func file(urlString: String, baseString: String) -> AnyPublisher<Any, any Error> {
        let url = urlString.apiString.url
        let base = url?.baseString ?? baseString
        let path = (url?.pathString ?? "").urlDecoded
        let parameters = url?.queryParameters
        
        return dynamicNetworking.requestRaw(
            DynamicTarget.init(
                baseURL: base.url!,
                target: DynamicAPI.request(path: path, parameters: parameters)
            )
        )
        .flatMap { response -> AnyPublisher<Any, Error> in
            if let string = try? response.mapString() {
                return Just(string)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            if let image = try? response.mapImage() {
                return Just(image)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            return Fail(error: HiError.dataInvalid)
                .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }

}

