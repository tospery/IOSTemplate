//
//  MyRouter+Page.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation
import HiIOS
import URLNavigator_Hi

extension Router {
    
    public func page(_ provider: HiIOS.ProviderType, _ navigator: NavigatorProtocol) {
        navigator.register(self.urlPattern(host: .trending)) { url, values, context in
            TrendingViewController(navigator, TrendingViewReactor(provider, self.parameters(url, values, context)))
        }
        navigator.register(self.urlPattern(host: .event)) { url, values, context in
            EventViewController(navigator, EventViewReactor(provider, self.parameters(url, values, context)))
        }
        navigator.register(self.urlPattern(host: .favorite)) { url, values, context in
            FavoriteViewController(navigator, FavoriteViewReactor(provider, self.parameters(url, values, context)))
        }
        navigator.register(self.urlPattern(host: .personal)) { url, values, context in
            PersonalViewController(navigator, PersonalViewReactor(provider, self.parameters(url, values, context)))
        }
        navigator.register(self.urlPattern(host: .settings)) { url, values, context in
            SettingViewController(navigator, SettingViewReactor(provider, self.parameters(url, values, context)))
        }
        navigator.register(self.urlPattern(host: .about)) { url, values, context in
            AboutViewController(navigator, AboutViewReactor(provider, self.parameters(url, values, context)))
        }
        navigator.register(self.urlPattern(host: .test)) { url, values, context in
            TestViewController(navigator, TestViewReactor(provider, self.parameters(url, values, context)))
        }
    }
    
}
