//
//  DataType.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/3/28.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import SwifterSwift
import RswiftResources
import HiBase
import HiCore
import HiNav
import HiSwiftUI

enum TileId: String, Hashable, Identifiable, CustomStringConvertible, CaseIterable {
    case space
    case settings, about, feedback
    case company, location, email, blog, nickname, bio
    case back, push, present, toast, alert, sheet, popup, logic
    case logo, text, editor
    
    static let unloginValues = [settings, about, feedback]
//    static let loginedValues = [company, location, email, blog, space, settings, about, feedback]
//    static let settingValues = [colorTheme, localization, cache]
    static let aboutValues = [logo, back, space, push, present, space, toast, alert, sheet, popup, logic]
//    static let profileValues = [nickname, bio, space, company, location, blog]
    
    var id: String {
        if self == .space {
            return "space-\(UUID().uuidString)"
        }
        return rawValue
    }
    
    var separated: Bool {
        switch self {
        case .feedback, .blog:
            return false
        default:
            return true
        }
    }
    
    var indicated: Bool {
        true
    }
    
    public var description: String {
        switch self {
        case .back: return R.string.localizable.back.localizedKeyString
        case .push: return R.string.localizable.push.localizedKeyString
        case .present: return R.string.localizable.present.localizedKeyString
        case .toast: return R.string.localizable.toast.localizedKeyString
        case .alert: return R.string.localizable.alert.localizedKeyString
        case .sheet: return R.string.localizable.sheet.localizedKeyString
        case .popup: return R.string.localizable.popup.localizedKeyString
        case .logic: return R.string.localizable.logic.localizedKeyString
        default: return self.rawValue.capitalizedFirstCharacter.localizedString
        }
    }
    
    var icon: String {
        switch self {
        case .settings: return R.image.settings_icon.name
        default: return "\(self.rawValue)_icon"
        }
    }
    
    var target: String? {
        switch self {
        case .back: return "iostemplate://back"
        case .push: return "iostemplate://profile"
        case .present: return "iostemplate://profile?forwardType=1"
        case .toast: return "iostemplate://toast?message=\"这是一条消息\""
        case .alert: return R.string.localizable.alert.localizedKeyString
        case .sheet: return R.string.localizable.sheet.localizedKeyString
        case .popup: return R.string.localizable.popup.localizedKeyString
        case .logic: return R.string.localizable.logic.localizedKeyString
        default: return HiNav.shared.deepLink(host: self.rawValue.lowercased())
        }
//        switch self {
//        case .cache, .logo, .author, .share: return nil
////        case .scoring: return R.string.constant.appScoringLink()
////        case .qqGroup: return R.string.constant.qqGroupLink()
//        case .about, .settings, .feedback: return HiNav.shared.deepLink(host: self.rawValue.lowercased())
////        case .trendingLanguage:
////            return HiNav.shared.deepLink(host: .languageList, parameters: [
////                Parameter.search: false.string
////            ])
////        case .searchLanguage:
////            return HiNav.shared.deepLink(host: .languageList, parameters: [
////                Parameter.search: true.string
////            ])
//        default:
//            return HiNav.shared.deepLink(host: self.rawValue.lowercased())
//        }
    }
    
    var param: String? {
        switch self {
        case .company: return Parameter.company
        case .location: return Parameter.location
        case .blog: return Parameter.blog
        case .nickname: return Parameter.name
        case .bio: return Parameter.bio
        default: return nil
        }
    }

}

@CasePathable
enum ITAlertAction: AlertActionType, Identifiable, Equatable {
    case destructive
    case `default`
    case cancel
    case exit
    
    var id: String { description }
    
    init?(string: String) {
        if [
            R.string.localizable.oK.key.description.englishLocalizedString.lowercased(),
            R.string.localizable.oK.key.description.chineseLocalizedString.lowercased()
        ].contains(string.lowercased()) {
            self = .destructive
        } else if [
            R.string.localizable.sure.key.description.englishLocalizedString.lowercased(),
            R.string.localizable.sure.key.description.chineseLocalizedString.lowercased()
        ].contains(string.lowercased()) {
            self = .default
        } else if [
            R.string.localizable.cancel.key.description.englishLocalizedString.lowercased(),
            R.string.localizable.cancel.key.description.chineseLocalizedString.lowercased()
        ].contains(string.lowercased()) {
            self = .cancel
        } else if [
            R.string.localizable.exit.key.description.englishLocalizedString.lowercased(),
            R.string.localizable.exit.key.description.chineseLocalizedString.lowercased()
        ].contains(string.lowercased()) {
            self = .exit
        } else {
            return nil
        }
    }

    var description: String {
        switch self {
        case .destructive:  return R.string.localizable.oK.localizedString
        case .default:  return R.string.localizable.sure.localizedString
        case .cancel: return R.string.localizable.cancel.localizedString
        case .exit: return R.string.localizable.exit.localizedString
        }
    }

    var style: UIAlertAction.Style {
        switch self {
        case .cancel:  return .cancel
        default: return .destructive
        }
    }
    
    var role: ButtonStateRole? {
        switch self.style {
        case .destructive: return .destructive
        case .cancel: return .cancel
        default: return nil
        }
    }

    static func == (lhs: ITAlertAction, rhs: ITAlertAction) -> Bool {
        switch (lhs, rhs) {
        case (.destructive, .destructive),
            (.default, .default),
            (.cancel, .cancel),
            (.exit, .exit):
            return true
        default:
            return false
        }
    }
}

enum PopupType: String, CaseIterable {
    case branchList = "branchs"
    case share
    case clipboard
}

enum LogicType: String, CaseIterable {
    case contact
}

enum ShareType: String, Identifiable, CaseIterable {
    case wechatSession, wechatTimeline, twitter, sms, email, copy
    
    var id: String { rawValue }
    
#if MOB_ENABLE
    var platformType: SSDKPlatformType {
        switch self {
        case .copy: return .typeCopy
        case .sms: return .typeSMS
        case .email: return .typeMail
        case .wechatSession: return .subTypeWechatSession
        case .wechatTimeline: return .subTypeWechatTimeline
        case .twitter: return .typeTwitter
        }
    }
#endif
    
    var title: String {
        switch self {
        case .copy: return R.string.localizable.copyLink.localizedString
        case .sms: return R.string.localizable.smS.localizedString
        case .email: return R.string.localizable.eMail.localizedString
        case .wechatSession: return R.string.localizable.weChat.localizedString
        case .wechatTimeline: return R.string.localizable.friendZone.localizedString
        case .twitter: return R.string.constant.x.localizedString
        }
    }
    
    var image: Image {
//        switch self {
//        case .copy: return R.image.share_link_icon.swiftUIImage
//        case .sms: return R.image.share_sms_icon.swiftUIImage
//        case .email: return R.image.share_email_icon.swiftUIImage
//        case .wechatSession: return R.image.share_wcsession_icon.swiftUIImage
//        case .wechatTimeline: return R.image.share_wctimeline_icon.swiftUIImage
//        case .twitter: return R.image.share_twitter_icon.swiftUIImage
//        }
        R.image.brand_icon.swiftUIImage
    }
    
}

enum TabBarItemType: Int, Identifiable, CaseIterable {
    case home, shop, fave, mine
    var id: Int { rawValue }
    
    var title: String {
        switch self {
        case .home: return R.string.localizable.home.localizedKeyString
        case .shop: return R.string.localizable.shop.localizedKeyString
        case .fave: return R.string.localizable.fave.localizedKeyString
        case .mine: return R.string.localizable.mine.localizedKeyString
        }
    }
    
    var normalImage: Image {
        switch self {
        case .home: return R.image.home_normal_icon.swiftUIImage
        case .shop: return R.image.shop_normal_icon.swiftUIImage
        case .fave: return R.image.fave_normal_icon.swiftUIImage
        case .mine: return R.image.mine_normal_icon.swiftUIImage
        }
    }
    var selectedImage: Image {
        switch self {
        case .home: return R.image.home_selected_icon.swiftUIImage
        case .shop: return R.image.shop_selected_icon.swiftUIImage
        case .fave: return R.image.fave_selected_icon.swiftUIImage
        case .mine: return R.image.mine_selected_icon.swiftUIImage
        }
    }
    
}

//@dynamicMemberLookup @CasePathable
//enum LoadingState: Equatable, Hashable {
//    case idle
//    case loading
//    case failed(APPError)
//}
// Preparation

enum ProcessingStatus: Equatable, Sendable {
    case loading
    case success
    case failure(APPError)
}
