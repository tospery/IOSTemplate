//
//  UserPlainCell.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/11/24.
//

import SwiftUI
import Kingfisher
import HiCore
import HiSwiftUI
import Domain
import SwifterSwift

struct UserPlainCell: View {
    let model: User
    let action: () -> Void
    
    init(_ model: User, action: @escaping () -> Void) {
        self.model = model
        self.action = action
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Button(action: action) {
                HStack {
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
                        .padding(.leading, 10)
                    VStack(alignment: .leading) {
                        Text(model.username ?? "")
                            .font(.headline)
                            .foregroundColor(.accentColor)
                        Text(model.htmlUrl ?? "")
                            .font(.footnote)
                            .foregroundColor(.primary.opacity(0.7))
                    }
                    Spacer()
                }
            }
            Spacer()
            Separator()
                .padding(.leading)
        }
        .frame(height: 60)
        .background(Color.background)
    }
}
