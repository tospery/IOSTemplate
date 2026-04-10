//
//  ServiceProvider.swift
//  DatabasePlatform
//
//  Created by 杨建祥 on 2024/5/13.
//

import Foundation
import Domain
import RealmSwift

public final class ServiceProvider: Domain.ServiceProvider {
    
    private let configuration: Realm.Configuration
    private let databaseMigrationServiceInstance = RealmDatabaseMigrationService()

    public init(configuration: Realm.Configuration = .defaultConfiguration) {
        self.configuration = configuration
    }
    
    public func dynamicService() -> any Domain.DynamicService {
        fatalError()
    }
    
    public func preferenceService() -> any Domain.PreferenceService {
        PreferenceService(repository: Repository<Domain.Preference>(configuration: configuration))
    }
    
    public func languageService() -> any Domain.LanguageService {
        LanguageService(repository: Repository<Domain.Language>(configuration: configuration))
    }
    
    public func loginService() -> any Domain.LoginService {
        LoginService(repository: Repository<Domain.Login>(configuration: configuration))
    }
    
    public func userService() -> any Domain.UserService {
        UserService(repository: Repository<Domain.User>(configuration: configuration))
    }
    
    public func newsService() -> any Domain.NewsService {
        NewsService(repository: Repository<Domain.News>(configuration: configuration))
    }

//    public func databaseMigrationService() -> any Domain.DatabaseMigrationService {
//        databaseMigrationServiceInstance
//    }

}

