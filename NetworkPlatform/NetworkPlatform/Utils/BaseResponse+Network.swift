//
//  BaseResponse+Network.swift
//  NetworkPlatform
//
//  Created by 杨建祥 on 2024/5/18.
//

import Foundation
import Moya
import ObjectMapper
import HiCore
import HiBase
import HiNet

extension BaseResponse: @retroactive ResponseCompatible {
    
    public func code(map: Map) -> Int {
        var code: Int?
        code        <- (map["code"], IntTransform.shared)
        if code == nil {
            code        <- (map["status"], IntTransform.shared)
        }
        return code == 0 ? ErrorCode.ok : code!
    }
    
    public func message(map: Map) -> String? {
        var message: String?
        message     <- (map["msg"], StringTransform.shared)
        return message
    }
    
    public func data(map: Map) -> Any? {
        var data: Any?
        data        <- map["data"]
        if data == nil {
            data    <- map["result"]
        }
        return data
    }
    
    public func code(_ target: TargetType) -> Int {
//        guard let multi = target as? MultiTarget else { return self.code }
//        if let api = multi.target as? GithubBaseAPI {
//            switch api {
//            case .searchRepos, .searchUsers:
//                return ErrorCode.ok
//            default:
//                return self.code
//            }
//        }
        return self.code
    }
    
    public func message(_ target: TargetType) -> String? {
        return self.message
    }
    
    public func data(_ target: TargetType) -> Any? {
//        guard let multi = target as? MultiTarget else { return self.data }
//        if let api = multi.target as? GithubBaseAPI {
//            switch api {
//            case .searchRepos, .searchUsers:
//                return self.json
//            default:
//                return self.data
//            }
//        }
        
        return self.data
    }

}
