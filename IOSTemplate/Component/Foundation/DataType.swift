//
//  DataType.swift
//  SWHub
//
//  Created by liaoya on 2022/7/21.
//

import Foundation
import HiIOS

enum TabBarKey {
    case trending
    case event
    case favorite
    case personal
}

enum Platform {
    case umeng
    case weixin
    
    var appId: String {
        switch self {
        case .umeng: return "your umeng appid"
        case .weixin: return UIApplication.shared.urlScheme(name: "weixin") ?? ""
        }
    }
    
    var appKey: String {
        switch self {
        case .umeng: return "your umeng appkey"
        case .weixin: return "your weixin appkey"
        }
    }
    
    var appLink: String {
        switch self {
        case .weixin: return "https://tospery.com/iostemplate/"
        default: return ""
        }
    }

}

enum CellId: Int {
    case space          = 0, button
    case settings       = 10, about, feedback
    
    var title: String? {
        switch self {
        case .settings: return R.string.localizable.settings(preferredLanguages: myLangs)
        case .about: return R.string.localizable.about(preferredLanguages: myLangs)
        case .feedback: return R.string.localizable.feedback(preferredLanguages: myLangs)
        default: return nil
        }
    }
    
    var param: String? { nil }
    
    var icon: String? {
        switch self {
        case .settings: return R.image.ic_settings.name
        case .about: return R.image.ic_about.name
        case .feedback: return R.image.ic_feedback.name
        default: return nil
        }
    }
    
    var target: String? {
        switch self {
        case .settings: return Router.shared.urlString(host: .settings)
        case .about: return Router.shared.urlString(host: .about)
        case .feedback: return Router.shared.urlString(host: .feedback)
        default: return nil
        }
    }
    
}

enum ITAlertAction: AlertActionType, Equatable {
    case destructive
    case `default`
    case cancel
    case input
    case exit
    
    init?(string: String) {
        switch string {
        case ITAlertAction.cancel.title: self = ITAlertAction.cancel
        case ITAlertAction.exit.title: self = ITAlertAction.exit
        default: return nil
        }
    }

    var title: String? {
        switch self {
        case .destructive:  return R.string.localizable.sure(preferredLanguages: myLangs)
        case .default:  return R.string.localizable.oK(preferredLanguages: myLangs)
        case .cancel: return R.string.localizable.cancel(preferredLanguages: myLangs)
        case .exit: return R.string.localizable.exit(preferredLanguages: myLangs)
        default: return nil
        }
    }

    var style: UIAlertAction.Style {
        switch self {
        case .cancel:  return .cancel
        case .destructive, .exit:  return .destructive
        default: return .default
        }
    }

    static func == (lhs: ITAlertAction, rhs: ITAlertAction) -> Bool {
        switch (lhs, rhs) {
        case (.destructive, .destructive),
            (.default, .default),
            (.cancel, .cancel),
            (.input, .input),
            (.exit, .exit):
            return true
        default:
            return false
        }
    }
}

struct Metric {
    static let menuHeight   = 44.f
    
    struct Personal {
        static let parallaxTopHeight    = 244.0
        static let parallaxAllHeight    = 290.0
    }
}
