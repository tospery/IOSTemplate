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
        }
        return string // String.init(string.sorted())
    }

    static func == (lhs: SectionItem, rhs: SectionItem) -> Bool {
        let result = (lhs.identity == rhs.identity)
        if result == false {
            switch lhs {
            case .simple: log("item变化 -> simple")
            case .appInfo: log("item变化 -> appInfo")
            case .label: log("item变化 -> label")
            case .button: log("item变化 -> button")
            case .check: log("item变化 -> check")
            case .textField: log("item变化 -> textField")
            case .textView: log("item变化 -> textView")
            case .imageView: log("item变化 -> imageView")
            }
        }
        return result
    }
    
}
