//
//  PersonalParallaxHeader.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/11/14.
//

import SwiftUI
import HiCore
import HiLog
import HiSwiftUI
import Domain

struct PersonalParallaxHeader: View {
    
    let user: Domain.User?
    let action: ((PageType?) -> Void)
    
    init(user: Domain.User?, action: @escaping (PageType?) -> Void) {
        self.user = user
        self.action = action
    }
    
    var body: some View {
        EmptyView()
//        VStack(spacing: 0) {
//            R.image.personal_parallax_icon.swiftUIImage
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//            Rectangle()
//                .fill(Color.surface)
//                .frame(height: (98.0 / 780.0 * screenWidth).flat)
//        }
//        .overlay {
//            GeometryReader { geometry in
//                let height = geometry.size.height - safeArea.insets.top - 12
//                return VStack(spacing: 0) {
//                    Text(R.string.localizable.personal.localizedStringKey)
//                        .font(.system(size: 18, weight: .medium))
//                        .foregroundStyle(Color.background)
//                        .frame(height: navigationBarHeight)
////                    Spacer()
////                    PersonalProfileView(user: user) { action($0) }
////                        .frame(maxWidth: .infinity)
////                        .frame(height: geometry.size.height * 0.54)
//                }
//                    .frame(
//                        width: geometry.size.width * 0.9,
//                        height: height
//                    )
//                    .position(
//                        x: geometry.size.width / 2.0,
//                        y: geometry.size.height - height / 2.0 - 12
//                    )
//            }
//        }
//        .overlay(alignment: .topTrailing) {
//            R.image.dark_theme_icon.swiftUIImage
//                .renderingMode(.template)
//                .resizable()
//                .frame(width: 24, height: 24)
//                .foregroundStyle(Color.background)
//                .offset(x: -40, y: statusBarHeightConstant + (navigationBarHeight - 24) / 2.0)
//                .onTapGesture {
//                    action(nil)
//                }
//        }
    }
    
}
