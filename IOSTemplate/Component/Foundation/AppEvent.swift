//
//  AppEvent.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/3/28.
//

import Foundation
import HiStats
import SwifterSwift
import HiCore
import HiBase
import HiSwiftUI
import Combine
import ObjectMapper

let analytics = Analytics<AppEvent>()

func stats(_ event: AppEvent) {
//#if DEBUG
//#else
    analytics.stats(event)
//#endif
}

enum AppEvent {
    case beginPageView(name: String)
    case endPageView(name: String)
    case userLoginSuccess(userid: String, username: String, nickname: String, email: String)
    case eventParseFail(type: String)
    case languageParseFail(type: String)
    case requestMarkdownFail(urlString: String)
    case requestHTMLFail(urlString: String)
    case optimizeHTMLFail(urlString: String)
    case parseFileOrDirectory(urlString: String)
}

extension AppEvent: HiStats.EventType {
    
    func name(for provider: HiStats.ProviderType) -> String? {
        switch self {
        case .beginPageView: return "begin_page_view"
        case .endPageView: return "end_page_view"
        case .eventParseFail: return "event_parse_fail"
        case .languageParseFail: return "language_parse_fail"
        case .userLoginSuccess: return "user_login_success"
        case .requestMarkdownFail: return "request_markdown_fail"
        case .requestHTMLFail: return "request_html_fail"
        case .optimizeHTMLFail: return "optimize_html_fail"
        case .parseFileOrDirectory: return "parse_file_or_directory"
        }
    }
    
    func parameters(for provider: HiStats.ProviderType) -> [String: Any]? {
        var parameters = environment
        parameters += preferenceService.value?.toJSON() ?? [:]
        switch self {
        case let .beginPageView(name),
            let .endPageView(name):
            parameters[Parameter.name] = name
        case let .eventParseFail(type),
            let .languageParseFail(type):
            parameters[Parameter.type] = type
        case let .userLoginSuccess(userid, username, nickname, email):
            parameters[Parameter.userid] = userid
            parameters[Parameter.username] = username
            parameters[Parameter.nickname] = nickname
            parameters[Parameter.email] = email
        case let .requestMarkdownFail(urlString),
            let .requestHTMLFail(urlString),
            let .optimizeHTMLFail(urlString),
            let .parseFileOrDirectory(urlString):
            parameters[Parameter.url] = urlString
        }
        return parameters
    }
    
}
