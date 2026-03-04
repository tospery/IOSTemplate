//
//  ImageResource+Ex.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/3/3.
//

import UIKit
import SwiftUI
import RswiftResources

extension RswiftResources.ImageResource {
    
    var image: UIImage {
        self()!
    }
    
    var swiftUIImage: SwiftUI.Image {
        .init(self.name)
    }
    
}
