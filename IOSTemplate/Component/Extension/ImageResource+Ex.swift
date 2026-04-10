//
//  ImageResource+Ex.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/12/20.
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
