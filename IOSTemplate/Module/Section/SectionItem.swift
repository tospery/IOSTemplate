//
//  SectionItem.swift
//  SWHub
//
//  Created by 杨建祥 on 2022/10/3.
//

import Foundation
import RxDataSources
import ReusableKit_Hi
import ObjectMapper_Hi
import HiIOS

enum SectionItem: IdentifiableType, Equatable {
    case simple(SimpleItem)
    case label(LabelItem)
    case check(CheckItem)
    case button(ButtonItem)
    case textField(TextFieldItem)
    case textView(TextViewItem)
    case imageView(ImageViewItem)
    case appInfo(AppInfoItem)
    
    var identity: String {
        var string = ""
        switch self {
        case let .simple(item): string = item.description
        case let .appInfo(item): string = item.description
        case let .label(item): string = item.description
        case let .button(item): string = item.description
        case let .check(item): string = item.description
        case let .textField(item): string = item.description
        case let .textView(item): string = item.description
        case let .imageView(item): string = item.description
        case let .theme(item): string = item.description
        case let .userCompany(item): string = item.description
        }
        return string // String.init(string.sorted())
    }

    // swiftlint:disable cyclomatic_complexity
    static func == (lhs: SectionItem, rhs: SectionItem) -> Bool {
        let result = (lhs.identity == rhs.identity)
        if result == false {
            switch lhs {
            case .simple: log("item变化 -> simple")
            case .appInfo: log("item变化 -> appInfo")
            case .milestone: log("item变化 -> milestone")
            case .searchKeywords: log("item变化 -> searchKeywords")
            case .label: log("item变化 -> label")
            case .button: log("item变化 -> button")
            case .check: log("item变化 -> check")
            case .textField: log("item变化 -> textField")
            case .textView: log("item变化 -> textView")
            case .imageView: log("item变化 -> imageView")
            case .codeView: log("item变化 -> codeView")
            case .urlScheme: log("item变化 -> urlScheme")
            case .theme: log("item变化 -> theme")
            case .userCompany: log("item变化 -> userCompany")
            }
        }
        return result
    }
    // swiftlint:enable cyclomatic_complexity
    
}
