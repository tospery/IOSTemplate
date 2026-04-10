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

    public init(configuration: Realm.Configuration = .defaultConfiguration) {
        self.configuration = configuration
    }
    
    public func dynamicService() -> Domain.DynamicService {
        fatalError()
    }
    
    public func accessTokenService() -> Domain.AccessTokenService {
        fatalError()
    }
    
    public func repoService() -> Domain.RepoService {
        RepoService(repository: Repository<Domain.Repo>(configuration: configuration))
    }
    
    public func userService() -> Domain.UserService {
        UserService(repository: Repository<Domain.User>(configuration: configuration))
    }

    public func languageService() -> Domain.LanguageService {
        LanguageService(repository: Repository<Language>(configuration: configuration))
    }
    
    public func preferenceService() -> Domain.PreferenceService {
        PreferenceService(repository: Repository<Preference>(configuration: configuration))
    }

}

