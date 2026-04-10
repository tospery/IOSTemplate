//
//  ServiceProvider.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/12.
//

import Foundation
import HiBase

public protocol ServiceProvider: HiBase.ServiceProvider {
    
    func dynamicService() -> DynamicService
    func preferenceService() -> PreferenceService
    func languageService() -> LanguageService
    func loginService() -> LoginService
    func userService() -> UserService
    func newsService() -> NewsService
    //func databaseMigrationService() -> DatabaseMigrationService

}
