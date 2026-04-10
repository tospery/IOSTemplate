//
//  Repo+Ex.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/12/14.
//

import Foundation
import UIKit
import HiBase
import HiNav
import Domain
import ObjectMapper
import HiSwiftUI

extension Domain.Repo {
    
//    var updateAgo: String? {
//        guard let string = self.updatedAt else { return nil }
//        guard let date = Date.init(iso8601: string) else { return nil }
//        return R.string(bundle: .localizedBundle ?? .main).localizable.latestUpdate(date.timeAgoSinceNow)
//    }
    
//    var sizeAndLicense: String? {
//        "\((self.size ?? 0).kilobytesText)(\(self.license?.spdxId ?? R.string.localizable.noneLicense.localizedString))"
//    }
//    
//    var contentsWebURLString: String {
//        "\(UIApplication.shared.baseWebUrl)/\(self.owner?.username ?? "")/\(self.name ?? "")/contents"
//    }
//    
//    var issuesWebURLString: String {
//        "\(UIApplication.shared.baseWebUrl)/\(self.owner?.username ?? "")/\(self.name ?? "")/issues"
//    }
//    
//    var pullsWebURLString: String {
//        "\(UIApplication.shared.baseWebUrl)/\(self.owner?.username ?? "")/\(self.name ?? "")/pulls"
//    }
//    
//    var fullnameText: AttributedString {
//        let owner = self.owner?.username ?? R.string.localizable.unknown.localizedString
//        let repo = self.name ?? R.string.localizable.unknown.localizedString
//        var text = AttributedString.init("\(owner) / \(repo)")
//        text.font = .bold(17)
//        text.foregroundColor = .primary
//        if let range = text.range(of: owner) {
//            text[range].font = .bold(17)
//            text[range].foregroundColor = .accentColor
//            text[range].link = HiNav.shared.deepLink(host: .user, parameters: [
//                Parameter.owner: owner
//            ]).url
//        }
//        return text
//    }
//    
//    func currentBranch(in lists: [Branch]) -> Branch? {
//        guard let name = self.defaultBranch?.lowercased(), name.isNotEmpty else { return nil }
//        var branch: Branch?
//        for item in lists where item.id.lowercased() == name {
//            branch = item
//            break
//        }
//        return branch
//    }

}
