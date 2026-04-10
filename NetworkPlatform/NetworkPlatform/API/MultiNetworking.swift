//
//  Networking.swift
//  NetworkPlatform
//
//  Created by 杨建祥 on 2024/5/17.
//

import Foundation
import Combine
import Moya
import Alamofire
import HiCore
import HiNet
import HiLog

let multiNetworking = MultiNetworking(
    provider: MoyaProvider<MultiTarget>(
        endpointClosure: MultiNetworking.endpointClosure,
        requestClosure: MultiNetworking.requestClosure,
        stubClosure: MultiNetworking.stubClosure,
        callbackQueue: MultiNetworking.callbackQueue,
        session: MultiNetworking.session,
        plugins: MultiNetworking.plugins,
        trackInflights: MultiNetworking.trackInflights
    )
)

struct MultiNetworking: NetworkPublishType {

    typealias Target = MultiTarget
    let provider: MoyaProvider<MultiTarget>
    
    static var session: Alamofire.Session {
        let manager = ServerTrustManager.init(
            allHostsMustBeEvaluated: false,
            evaluators: [
                "gtrend.yapie.me": DisabledTrustEvaluator.init()
            ]
        )
        return Alamofire.Session(serverTrustManager: manager)
    }
    
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
//        if let multiTarget = target as? MultiTarget {
//            if let githubBaseAPI = multiTarget.target as? GithubBaseAPI {
//                switch githubBaseAPI {
//                case .readme, .markdown: return
//                default: break
//                }
//            }
//        }
        for item in items {
            // logger.print(item, module: .restful)
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
