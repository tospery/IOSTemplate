//
//  Localization+Ex.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/11/24.
//

import Foundation
import SwiftUI
import SwifterSwift
import HiBase
import HiCore
import Domain
import RswiftResources

extension Localization: @retroactive CustomStringConvertible {
    
    var bundle: Bundle? {
        switch self {
        case .chinese: return .zhBundle
        case .english: return .enBundle
        }
    }
    
    public var description: String {
        switch self {
        case .chinese: return R.string.constant.chinese()
        case .english: return R.string.constant.english()
        }
    }
    
}
