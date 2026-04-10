//
//  ShareModel.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/12/26.
//

import Foundation
import UIKit

struct ShareModel: Identifiable, Equatable {
    
    let title: String
    let image: UIImage
    let url: URL
    
    var id: String { url.absoluteString }
    
    var items: [Any] { [title, image, url] }
    
    init(title: String, image: UIImage, url: URL) {
        self.title = title
        self.image = image
        self.url = url
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.title == rhs.title &&
        lhs.image == rhs.image &&
        lhs.url == rhs.url
    }
    
}
