//
//  PageType+Ex.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/11/24.
//

import Foundation
import SwiftUI
import SwifterSwift
import HiBase
import Domain
import HiCore
import HiSwiftUI

extension PageType {
    
//    var forRepo: Bool {
//        [
//            PageType.trendingRepos,
//            PageType.repositories,
//            PageType.stars,
//            PageType.subscriptions,
//            PageType.forks
//        ].contains(self)
//    }
//    
//    var forState: Bool {
//        [
//            PageType.open,
//            PageType.closed
//        ].contains(self)
//    }
    
}

extension PageType: @retroactive CustomStringConvertible {
    
    public var description: String {
        self.rawValue.capitalizedFirstCharacter.localizedString
    }
    
}
