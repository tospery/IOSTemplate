//
//  UIApplication+Ex.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/6/26.
//

import UIKit
import SwifterSwift

extension UIApplication {
    
    var channel: Int {
        switch self.inferredEnvironment {
        case .debug: return 1
        case .testFlight: return 2
        case .appStore: return 3
        }
    }
    
    var baseTrendingUrl: String { "https://gtrend.yapie.me" }
    var baseGithubUrl: String { "https://github.com" }
    
    @objc var myPageStart: Int { 1 }
    
    static var currentWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .first?.windows
            .first { $0.isKeyWindow }
    }
}

extension UIApplication.Environment: @retroactive CustomStringConvertible {
    public var description: String {
        switch self {
        case .debug: return "Debug"
        case .testFlight: return "TestFlight"
        case .appStore: return "AppStore"
        }
    }
}
