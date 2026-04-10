//
//  Preference+Ex.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/12/11.
//

import Foundation
import SwiftUI
import SwifterSwift
import HiBase
import Domain

extension Preference {
    
    var hasLoginedUser: Bool { self.user?.isValid ?? false }
    
//    var isSearchRepos: Bool {
//        ((self.searchType ?? .repositories) == .repositories)
//    }
//    
//    var searchIdentifier: String {
//        var id = (self.searchType ?? .repositories).rawValue
//        id += (self.searchLanguage ?? .any).id
//        return id
//    }

}
