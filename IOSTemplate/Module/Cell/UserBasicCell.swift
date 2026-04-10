//
//  UserBasicCell.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/11/27.
//

import SwiftUI
import Kingfisher
import HiBase
import HiCore
import HiNav
import HiSwiftUI
import SwifterSwift
import RswiftResources
import Domain

struct UserBasicCell: View {
    let model: User
    let action: (String) -> Void
    
    init(_ model: User, action: @escaping (String) -> Void) {
        self.model = model
        self.action = action
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                KFImage.url(model.avatar?.url)
                    .placeholder {
                        R.image.default_icon.swiftUIImage
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                    .resizable()
                    .roundCorner(radius: .heightFraction(0.12))
                    .serialize(as: .PNG)
                    .loadDiskFileSynchronously()
                    .frame(width: 40, height: 40)
                    .padding(.trailing, 4)
                VStack(alignment: .leading, spacing: 4) {
                    Text(model.fullname)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(Color.primary)
                    HStack(spacing: 4) {
                        R.image.default_icon.swiftUIImage
                            .font(.system(size: 12))
                        Text(model.repo?.name ?? R.string.constant.noneHotRepo())
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(Color.accentColor)
                    }
                    .onTapGesture {
//                        guard let repo = model.repo?.name, repo.isNotEmpty else { return }
//                        action(HiNav.shared.deepLink(host: .repo, parameters: [
//                            Parameter.owner: model.username ?? "",
//                            Parameter.repo: repo
//                        ]))
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 10)
            Text(model.repo?.desc ?? R.string.localizable.noneRepoDesc.localizedString)
                .font(.system(size: 15))
                .lineSpacing(2)
                .lineLimit(4)
                .foregroundStyle(Color.primary.opacity(0.8))
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 16)
                .padding(.bottom, 10)
        }
        .background(Color.background)
        .onTapGesture {
            action(model.url ?? "")
        }
    }
}
