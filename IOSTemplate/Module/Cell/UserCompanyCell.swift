//
//  UserCompanyCell.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/12/12.
//

import SwiftUI
import Kingfisher
import HiBase
import HiCore
import HiNav
import SVGView
import Domain
import HiSwiftUI

struct UserCompanyCell: View {
    
    let company: String
    let text: AttributedString
    
    init(_ company: String, _ isEmpty: Bool) {
        self.company = company
//        let companies = self.company.matched(pattern: "@([^@\\s]+)")
//        var links = [String: String].init()
//        for name in companies {
//            let username = name.removingPrefix("@")
//            if username.isNotEmpty {
//                links[name] = HiNav.shared.deepLink(host: .user, parameters: [
//                    Parameter.owner: username
//                ])
//            }
//        }
        var text = AttributedString.init(self.company)
        text.font = .normal(15)
        if isEmpty {
            text.foregroundColor = .secondary
        } else {
            text.foregroundColor = .primary.opacity(0.8)
        }
//        for link in links {
//            if let range = text.range(of: link.key) {
//                text[range].font = .normal(15)
//                text[range].foregroundColor = .accentColor
//                text[range].link = link.value.url
//            }
//        }
        self.text = text
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
//            HStack {
//                R.image.company_icon.swiftUIImage
//                    .resizable()
//                    .frame(width: 20, height: 20)
//                    .padding(.leading)
//                Text(text)
//                    .lineLimit(1)
//                Spacer()
//            }
//            Spacer()
            Separator()
                .padding(.leading)
        }
        .frame(height: 44)
        .background(Color.background)
    }

}
