//
//  String+Domain.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/19.
//

import Foundation
import SwifterSwift
import HiBase

extension String {
    
    /// 测试的string：
    /// 1. https://api.github.com/repos/tospery/WillHub
    /// 2. https://github.com/dkhamsing/open-source-ios-apps/blob/master/README.md
    public var githubUsername: String {
        guard let url = self.url else { return "" }
        var index = 0
        if url.host == "github.com" {
            index += 1
        } else if url.host == "api.github.com" {
            index += 2
        } else {
            return ""
        }
        let components = url.pathComponents
        if components.count < index + 1 {
            return ""
        }
        return components[index]
    }
    
    public var githubReponame: String {
        guard let url = self.url else { return "" }
        var index = 0
        if url.host == "github.com" {
            index += 2
        } else if url.host == "api.github.com" {
            index += 3
        } else {
            return ""
        }
        let components = url.pathComponents
        if components.count < index + 1 {
            return ""
        }
        return components[index]
    }
    
}
