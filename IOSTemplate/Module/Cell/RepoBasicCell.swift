//
//  RepoBasicCell.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/11/17.
//

import SwiftUI
import Kingfisher
import HiBase
import HiCore
import HiLog
import HiSwiftUI
import Domain
import SwifterSwift

struct RepoBasicCell: View {
    let model: Repo
    let action: (String) -> Void
    
    init(_ model: Repo, action: @escaping (String) -> Void) {
        self.model = model
        self.action = action
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                KFImage.url(model.owner?.avatar?.url)
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
//                    Text(model.fullnameText)
//                        .lineLimit(2)
                    Text("完整的名字：model.fullnameText")
                        .lineLimit(2)
                    HStack(spacing: 4) {
                        HStack(spacing: 4) {
                            Circle()
                                .fill(model.language?.hashColor.swiftUIColor ?? Color.accentColor)
                                .frame(width: 10, height: 10)
                            Text(model.language ?? R.string.localizable.unknown.localizedString)
                                .font(.system(size: 11, weight: .medium))
                                .foregroundStyle(Color.primary.opacity(0.8))
                        }
                        .frame(width: screenWidth / 3.2, alignment: .leading)
                        HStack(spacing: 4) {
                            R.image.default_icon.swiftUIImage
                                .font(.system(size: 11, weight: .medium))
                            Text(UInt64(model.stars ?? 0).formatted)
                                .font(.system(size: 11, weight: .medium))
                                .foregroundStyle(Color.primary.opacity(0.8))
                        }
                        Spacer()
                        HStack(spacing: 4) {
                            R.image.default_icon.swiftUIImage
                                .font(.system(size: 11, weight: .medium))
                            Text(UInt64(model.forks ?? 0).formatted)
                                .font(.system(size: 11, weight: .medium))
                                .foregroundStyle(Color.primary.opacity(0.8))
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 10)
            Text(model.desc ?? R.string.localizable.noneRepoDesc.localizedString)
                .font(.system(size: 15))
                .lineSpacing(2)
                .lineLimit(4)
                .multilineTextAlignment(.leading)
                .foregroundStyle(Color.primary.opacity(0.8))
                .padding(.horizontal, 16)
                .padding(.bottom, 10)
        }
        .background(Color.background)
        .onTapGesture {
            action(model.htmlUrl ?? "")
        }
    }
}
