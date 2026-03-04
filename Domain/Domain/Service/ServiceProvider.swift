//
//  ServiceProvider.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/12.
//

import Foundation
import HiBase

public protocol ServiceProvider: HiBase.ServiceProvider {
    
    func accessTokenService() -> AccessTokenService
    func preferenceService() -> PreferenceService
    func dynamicService() -> DynamicService
    func userService() -> UserService
    func eventService() -> EventService

}
