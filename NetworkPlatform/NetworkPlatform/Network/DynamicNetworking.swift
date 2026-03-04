//
//  DynamicNetworking.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/19.
//

import Foundation
import Combine
import Moya
import Alamofire
import HiCore
import HiNet
import HiLog

let dynamicNetworking = Dynamically(
    provider: MoyaProvider<DynamicTarget>(
        endpointClosure: Dynamically.endpointClosure,
        requestClosure: Dynamically.requestClosure,
        stubClosure: Dynamically.stubClosure,
        callbackQueue: Dynamically.callbackQueue,
        session: Dynamically.session,
        plugins: Dynamically.plugins,
        trackInflights: Dynamically.trackInflights
    )
)

struct Dynamically: NetworkPublishType {
    typealias Target = DynamicTarget
    let provider: MoyaProvider<DynamicTarget>
    
    static var plugins: [PluginType] {
        var plugins: [PluginType] = []
        let logger = HiLoggerPlugin.init()
#if DEBUG
        logger.configuration.logOptions = [.requestBody, .successResponseBody, .errorResponseBody]
#else
        logger.configuration.logOptions = [.requestBody]
#endif
        logger.configuration.output = output
        plugins.append(logger)
        return plugins
    }
    
    static func output(target: TargetType, items: [String]) {
        for item in items {
            //logger.print(item, module: .restful)
            log(item, module: Module.network)
        }
    }

    func request(_ target: Target) -> AnyPublisher<Moya.Response, Error> {
        self.provider.requestPublisher(target)
            .filterSuccessfulStatusCodes()
            .mapError { $0.asHiError }
            .eraseToAnyPublisher()
    }
    
}
