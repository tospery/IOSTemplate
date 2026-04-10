//
//  PrivacyService.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/3/28.
//

import Foundation

#if MOB_ENABLE
class PrivacyService: NSObject, MOBFoundationPrivacyDelegate {
    
    static let shared = PrivacyService()
    
    override init() { }
    
    func isLocInfoEnable() -> Bool { true }
    
    func getLoc() -> CLLocation? { nil }
    
    func isWiFiInfoEnable() -> Bool { true }
    
    func getSSID() -> String? { nil }
    
    func getBSSID() -> String? { nil }

    func isIdfaEnable() -> Bool { true }

    func getIdfa() -> String? { nil }
    
    func isIdfvEnable() -> Bool { true }
    
    func getIdfv() -> String? { nil }
    
    func isIpEnable() -> Bool { true }
    
    func isSocietyPlatformDataEnable() -> Bool { true }
    
}
#endif
