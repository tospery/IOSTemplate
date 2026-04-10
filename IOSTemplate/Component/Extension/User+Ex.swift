//
//  User+Ex.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/11/13.
//

import Foundation
import Combine
import Domain
import ObjectMapper
import SwifterSwift
import HiSwiftUI

extension Domain.User {
    
    var isOrganization: Bool { self.type == "Organization" }
    
    var milestone: String {
        let name = self.username ?? ""
        let color = ((preferenceService.value as? Preference)?.colorTheme ?? .red)
            .swiftUIColor.uiColor.hexString.removingPrefix("#")
        return "https://ghchart.rshah.org/\(color)/\(name)"
    }
    
    func value(tileId: TileId) -> String? {
        var result: String?
        switch tileId {
        case .nickname: result = self.nickname?.isEmpty ?? true ?
            R.string.localizable.noneSetup.localizedString : self.nickname
        case .bio: result = self.bio?.isEmpty ?? true ?
            R.string.localizable.noneBio.localizedString : self.bio
        case .company: result = self.company?.isEmpty ?? true ?
            R.string.localizable.noneSetup.localizedString : self.company
        case .location: result = self.location?.isEmpty ?? true ?
            R.string.localizable.noneSetup.localizedString : self.location
        case .email: result = self.email?.isEmpty ?? true ?
            R.string.localizable.noneSetup.localizedString : self.email
        case .blog: result = self.blog?.isEmpty ?? true ?
            R.string.localizable.noneSetup.localizedString: self.blog
        default: result = nil
        }
        return result
    }
    
    var joinedOn: String? {
//        guard let string = self.createdAt else { return nil }
//        guard let date = ISO8601DateTransform().transformFromJSON(string) else { return nil }
//        let value = date.string(withFormat: "yyyy-MM-dd")
//        return R.string(bundle: .localizedBundle ?? .main).localizable.joinedon(value)
        nil
    }
    
    var fullname: String {
        let unknown = R.string.localizable.unknown.localizedString
        return "\(self.nickname ?? self.username ?? unknown) (\(self.username ?? unknown))"
    }
    
    var companyWithDefault: (Bool, String) {
        var isEmpty = false
        var string = company
        if string?.isEmpty ?? true {
            isEmpty = true
            string = R.string.localizable.noneSetup.localizedString
        }
        return (isEmpty, string!)
    }
    
    var locationWithDefault: (Bool, String) {
        var isEmpty = false
        var string = location
        if string?.isEmpty ?? true {
            isEmpty = true
            string = R.string.localizable.noneSetup.localizedString
        }
        return (isEmpty, string!)
    }
    
    var emailWithDefault: (Bool, String) {
        var isEmpty = false
        var string = email
        if string?.isEmpty ?? true {
            isEmpty = true
            string = R.string.localizable.noneSetup.localizedString
        }
        return (isEmpty, string!)
    }
    
    var blogWithDefault: (Bool, String) {
        var isEmpty = false
        var string = blog
        if string?.isEmpty ?? true {
            isEmpty = true
            string = R.string.localizable.noneSetup.localizedString
        }
        return (isEmpty, string!)
    }
    
    var nicknameWithDefault: (Bool, String) {
        var isEmpty = false
        var string = nickname
        if string?.isEmpty ?? true {
            isEmpty = true
            string = R.string.localizable.noneSetup.localizedString
        }
        return (isEmpty, string!)
    }
    
}
