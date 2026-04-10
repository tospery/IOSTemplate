//
//  UserMilestoneCell.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/12/12.
//

import SwiftUI
import Kingfisher
import HiCore
import SwiftUIKit_Hi
import SVGView
import Domain
import HiSwiftUI

struct UserMilestoneCell: View {
    
    @Binding var content: String
    let action: () -> Void
    
    init(_ content: Binding<String>, action: @escaping () -> Void) {
        self._content = content
        self.action = action
    }
    
    var body: some View {
        VStack {
            if content.isEmpty {
                Spacer()
                DotLoadingAnimation(dotCount: 5, interval: 0.25)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundStyle(Color.accentColor)
                Spacer()
            } else {
                SVGView(string: content)
                    .padding(.horizontal, 15)
            }
        }
        .frame(height: screenWidth * 0.24)
        .frame(maxWidth: .infinity)
        .background(Color.background)
    }
    
}
