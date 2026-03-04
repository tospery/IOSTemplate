//
//  Profile+Ex.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/3/4.
//

import Foundation
import SwiftUI
import SwifterSwift
import HiBase
import Domain

extension Preference {
    
    var hasLoginedUser: Bool { self.user?.isValid ?? false }

}
