//
//  Router+Login.swift
//  SWHub
//
//  Created by 杨建祥 on 2024/3/29.
//

import Foundation
import HiIOS
import URLNavigator_Hi

extension Router {
    
    public func isLogined() -> Bool {
        User.current?.isValid ?? false
    }
    
    public func needLogin(host: Router.Host, path: Router.Path?) -> Bool {
        switch host {
        case .feedback: return true
        default: return false
        }
    }
    
    public func customLogin(
        _ provider: HiIOS.ProviderType,
        _ navigator: NavigatorProtocol,
        _ url: URLConvertible,
        _ values: [String: Any],
        _ context: Any?
    ) -> Bool {
        guard let top = UIViewController.topMost else { return false }
        if top.className.contains("LoginViewController") ||
            top.className.contains("TXSSOLoginViewController") {
            return false
        }
        var parameters = self.parameters(url, values, context) ?? [:]
        parameters[Parameter.transparetNavBar] = true
        let reactor = LoginViewReactor(provider, parameters)
        let controller = LoginViewController(navigator, reactor)
        let navigation = NavigationController(rootViewController: controller)
        top.present(navigation, animated: true)
        return true
    }
    
}
