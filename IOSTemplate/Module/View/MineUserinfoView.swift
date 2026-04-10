//
//  MineUserinfoView.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/4/6.
//

import SwiftUI
import Kingfisher
import HiCore
import HiSwiftUI
import Domain
import SwifterSwift

struct MineUserinfoView: View {
    
    let user: Domain.User?
    let action: ((PageType) -> Void)
    
    init(user: Domain.User?, action: @escaping (PageType) -> Void) {
        self.user = user
        self.action = action
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    if user?.isValid ?? false {
                        KFImage.url(user?.avatar?.url)
                            .placeholder {
                                R.image.default_icon.swiftUIImage
                                    .resizable()
                                    .frame(width: metric(65), height: metric(65))
                            }
                            .resizable()
                            .roundCorner(radius: .heightFraction(0.5))
                            .serialize(as: .PNG)
                            .loadDiskFileSynchronously()
                            .frame(width: metric(65), height: metric(65))
                            .padding(.leading, 20)
                    } else {
                        R.image.default_icon.swiftUIImage
                            .resizable()
                            .frame(width: metric(65), height: metric(65))
                            .padding(.leading, 20)
                    }
                    if user?.isValid ?? false {
                        VStack(alignment: .leading, spacing: 2) {
                            HStack(spacing: 2) {
                                Text(user?.nickname ?? "")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundStyle(Color.accentColor)
                                Text("(\(user?.username ?? R.string.localizable.unknown.localizedString))")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundStyle(Color.primary.opacity(0.8))
                            }
                            .padding(.top, (geometry.size.height * 0.6 - metric(65)) / 2.0 + 2)
                            Text(user?.phone ?? R.string.localizable.noneBio.localizedString)
                                .font(.system(size: 13))
                                .foregroundStyle(Color.primary.opacity(0.8))
                            Text(user?.email ?? "")
                                .font(.system(size: 11))
                                .foregroundStyle(Color.primary.opacity(0.8))
                            Spacer()
                        }
                        .padding(.leading, 10)
                    } else {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(R.string.localizable.clickToLogin.localizedStringKey)
                                .font(.system(size: 20, weight: .medium))
                                .foregroundStyle(Color.primary)
                                .padding(.top, (geometry.size.height * 0.6 - metric(65)) / 2.0 + 8)
                            Text(R.string.localizable.appSlogan.localizedStringKey)
                                .font(.system(size: 13))
                                .foregroundStyle(Color.primary.opacity(0.8))
                            Spacer()
                        }
                        .padding(.leading, 10)
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .frame(height: geometry.size.height * 0.6)
                Divider()
                    .padding(.horizontal)
                    .padding(.vertical, 0)
//                StatView(
//                    user: user, repo: nil,
//                    pages: [.repositories, .followers, .following],
//                    forPersonal: true, action: action
//                )
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .padding(.horizontal)
            }
        }
        .background(Color.background)
        .clipShape(.rect(cornerRadius: 10))
    }

}
