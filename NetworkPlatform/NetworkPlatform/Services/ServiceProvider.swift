//
//  ServiceProvider.swift
//  NetworkPlatform
//
//  Created by 杨建祥 on 2024/5/17.
//

import Foundation
import Combine
import Domain

public final class ServiceProvider: Domain.ServiceProvider {
    
    private let environment: [String: Any]
    
    public init(environment: [String: Any] = [:]) {
        self.environment = environment
        NetworkPlatform.environment = environment
    }
    
    public func accessTokenService() -> Domain.AccessTokenService {
        AccessTokenService(environment: environment)
    }
    
    public func preferenceService() -> Domain.PreferenceService {
        PreferenceService(environment: environment)
    }
    
    public func dynamicService() -> Domain.DynamicService {
        DynamicService(environment: environment)
    }
    
    public func languageService() -> Domain.LanguageService {
        LanguageService(environment: environment)
    }
    
    public func repoService() -> Domain.RepoService {
        RepoService(environment: environment)
    }
    
    public func userService() -> Domain.UserService {
        UserService(environment: environment)
    }

}
