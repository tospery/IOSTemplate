//
//  Runtime+Ex.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/11/24.
//

import UIKit
import HiBase
import HiCore
import HiSwiftUI

extension Runtime: @retroactive RuntimeCompatible {
    
    public func myWork() {
        self.basic()
        ExchangeImplementations(UIApplication.self,
                                #selector(getter: UIApplication.pageStart),
                                #selector(getter: UIApplication.myPageStart))
    }
    
}
