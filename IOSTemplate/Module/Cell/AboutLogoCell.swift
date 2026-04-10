//
//  AboutLogoCell.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/4/6.
//

import SwiftUI
import HiCore

struct AboutLogoCell: View {
    
    let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                R.image.brand_icon.swiftUIImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: (deviceWidth / 4.6).flat)
                    .onTapGesture {
                        action()
                    }
                Text("v\(UIApplication.shared.version)(\(UIApplication.shared.buildNumber))")
                    .font(.system(size: 14))
                    .foregroundStyle(.primary.opacity(0.7))
                Spacer()
            }
            Spacer()
        }
        .frame(height: (deviceWidth / 2.0).flat)
        .background(Color.clear)
    }

}
