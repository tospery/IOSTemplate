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
    
    public func dynamicService() -> Domain.DynamicService {
        NetworkPlatform.DynamicService(environment: environment)
    }
    
    public func preferenceService() -> Domain.PreferenceService {
        NetworkPlatform.PreferenceService(environment: environment)
    }
    
    public func languageService() -> any Domain.LanguageService {
        NetworkPlatform.LanguageService(environment: environment)
    }
    
    public func loginService() -> Domain.LoginService {
        NetworkPlatform.LoginService(environment: environment)
    }
    
    public func userService() -> Domain.UserService {
        NetworkPlatform.UserService(environment: environment)
    }
    
    public func newsService() -> Domain.NewsService {
        NetworkPlatform.NewsService(environment: environment)
    }

//    public func databaseMigrationService() -> any Domain.DatabaseMigrationService {
//        fatalError("databaseMigrationService() 仅由 PersistencePlatorm 提供，请勿在 Network 上调用。")
//    }

}
