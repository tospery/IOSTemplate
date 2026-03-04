//
//  StringResource+Ex.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/3/3.
//

import SwiftUI
import RswiftResources
import HiBase
import HiSwiftUI

extension RswiftResources.StringResource {
    
    var localizedKeyString: String {
        self.key.description
    }
    
    var localizedString: String {
        self.key.description.localizedString
    }
    
    var localizedStringKey: LocalizedStringKey {
        self.key.description.localizedStringKey
    }
    
}
