//
//  RepoDetailCell.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/12/14.
//

import SwiftUI
import Kingfisher
import HiCore
import HiSwiftUI
import Domain
import SwifterSwift

struct RepoDetailCell: View {
    
    let model: Repo
    let action: (PageType) -> Void
    
    init(_ model: Repo, action: @escaping (PageType) -> Void) {
        self.model = model
        self.action = action
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                KFImage.url(model.owner?.avatar?.url)
                    .placeholder {
                        R.image.default_icon.swiftUIImage
                            .resizable()
                            .frame(width: metric(56), height: metric(56))
                    }
                    .resizable()
                    .roundCorner(radius: .heightFraction(0.08))
                    .serialize(as: .PNG)
                    .loadDiskFileSynchronously()
                    .frame(width: metric(56), height: metric(56))
                    .padding(.leading)
                    .padding(.top)
                    .padding(.bottom, 8)
                VStack(alignment: .leading, spacing: 0) {
                    Text("model.fullnameText")
                    HStack(spacing: 3) {
                        Text("●")
                            .font(.system(size: 13))
                            .foregroundStyle((model.languageColor?.color ?? .random).swiftUIColor)
                        Text(model.language ?? R.string.localizable.unknown.localizedString)
                            .font(.system(size: 13))
                            .foregroundStyle(Color.primary.opacity(0.8))
                        Spacer()
                    }.padding(.top, 6)
                    Text(/*model.updateAgo ?? ""*/"updateAgo")
                        .font(.system(size: 12))
                        .foregroundStyle(Color.primary.opacity(0.7))
                        .padding(.top, 2)
                }
            }
            Text(model.desc ?? R.string.localizable.noneRepoDesc.localizedString)
                .multilineTextAlignment(.leading)
                .lineLimit(5)
                .lineSpacing(2)
                .font(.system(size: 15))
                .foregroundStyle(Color.primary.opacity(0.8))
                .padding(.horizontal)
                .padding(.bottom, 10)
                .padding(.top, 4)
            Separator()
                .padding(.horizontal)
            StatView(
                user: nil, repo: model, pages: [.subscribers, .stars, .forks], forPersonal: false, action: action
            )
                .padding(.vertical, 10)
            Rectangle()
                .fill(Color.surface)
                .frame(height: 10)
                .padding(.horizontal, 0)
        }
        .background(Color.background)
    }
    
}
