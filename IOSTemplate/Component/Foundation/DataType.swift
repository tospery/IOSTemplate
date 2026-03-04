//
//  DataType.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/7/2.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import SwifterSwift
import HiBase
import HiNav
import HiSwiftUI
import RswiftResources
import HiCore

enum TileId: String, Hashable, Identifiable, CustomStringConvertible, CaseIterable {
    case space
    case settings, about, feedback
    case company, location, email, blog, nickname, bio
    case author, qqGroup, urlSchemes, scoring, share
    case language, issues, pulls, branches, readme
    case colorTheme, localization, cache
    case trendingSince, trendingLanguage
    case searchType, searchLanguage, searchUserSort
    case logo, text, editor
    
    static let unloginValues = [settings, about, feedback]
    static let loginedValues = [company, location, email, blog, space, settings, about, feedback]
    static let settingValues = [colorTheme, localization, cache]
    static let aboutValues = [logo, author, qqGroup, space, urlSchemes, scoring, share]
    static let profileValues = [nickname, bio, space, company, location, blog]
    static let trendingOptionsValues = [trendingSince, trendingLanguage]
    
    var id: String {
        if self == .space {
            return "space-\(UUID().uuidString)"
        }
        return rawValue
    }
    
    var separated: Bool {
        switch self {
        case .feedback, .blog, .cache, .qqGroup, .share:
            return false
        default:
            return true
        }
    }
    
    var indicated: Bool {
        true
    }
    
    public var description: String {
//        switch self {
//        case .colorTheme: return R.string.localizable.theme.localizedKeyString
//        case .localization: return R.string.localizable.language.localizedKeyString
//        case .cache: return R.string.localizable.clearCache.localizedKeyString
//        case .urlSchemes: return R.string.constant.urlSchemes()
//        case .share: return R.string.localizable.shareWithFriend.localizedKeyString
//        case .qqGroup: return R.string.localizable.qqGroup.localizedKeyString
//        case .trendingSince: return R.string.localizable.since.localizedKeyString
//        case .trendingLanguage, .searchLanguage: return R.string.localizable.language.localizedKeyString
//        case .searchType: return R.string.localizable.type.localizedKeyString
//        case .searchUserSort: return R.string.localizable.sort.localizedKeyString
//        default: return self.rawValue.capitalizedFirstCharacter.localizedString
//        }
        ""
    }
    
    var icon: String {
//        switch self {
//        case .settings: return R.image.settings_icon.name
//        default: return "\(self.rawValue)_icon"
//        }
        R.image.brand_icon.name
    }
    
    var target: String? {
//        switch self {
//        case .cache, .logo, .author, .share: return nil
//        case .scoring: return R.string.constant.appScoringLink()
//        case .qqGroup: return R.string.constant.qqGroupLink()
//        case .about, .settings, .feedback: return HiNav.shared.deepLink(host: self.rawValue.lowercased())
//        case .trendingLanguage:
//            return HiNav.shared.deepLink(host: .languageList, parameters: [
//                Parameter.search: false.string
//            ])
//        case .searchLanguage:
//            return HiNav.shared.deepLink(host: .languageList, parameters: [
//                Parameter.search: true.string
//            ])
//        default:
//            return HiNav.shared.deepLink(host: self.rawValue.lowercased())
//        }
        nil
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
enum WHAlertAction: AlertActionType, Identifiable, Equatable {
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

    static func == (lhs: WHAlertAction, rhs: WHAlertAction) -> Bool {
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

enum TabBarItemType: Int, CaseIterable, Identifiable {
    case trending, event, favorite, personal
    var id: Int { rawValue }
    
    var title: String {
        switch self {
        case .trending: return R.string.localizable.trending.localizedKeyString
        case .event: return R.string.localizable.event.localizedKeyString
        case .favorite: return R.string.localizable.favorite.localizedKeyString
        case .personal: return R.string.localizable.personal.localizedKeyString
        }
    }
    var normalImage: Image {
        switch self {
        case .trending: return R.image.trending_normal_icon.swiftUIImage
        case .event: return R.image.event_normal_icon.swiftUIImage
        case .favorite: return R.image.favorite_normal_icon.swiftUIImage
        case .personal: return R.image.personal_normal_icon.swiftUIImage
        }
    }
    var selectedImage: Image {
        switch self {
        case .trending: return R.image.trending_selected_icon.swiftUIImage
        case .event: return R.image.event_selected_icon.swiftUIImage
        case .favorite: return R.image.favorite_selected_icon.swiftUIImage
        case .personal: return R.image.personal_selected_icon.swiftUIImage
        }
    }
}
