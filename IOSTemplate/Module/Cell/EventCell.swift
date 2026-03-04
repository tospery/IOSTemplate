//
//  EventCell.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/3/3.
//

import SwiftUI
import Kingfisher
import HiLog
import HiBase
import HiCore
import HiNav
import HiSwiftUI
import Domain

struct EventCell: View {
    
    let model: Domain.Event
    let action: (String) -> Void
    
    init(_ model: Domain.Event, action: @escaping (String) -> Void) {
        self.model = model
        self.action = action
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text((model.type?.rawValue ?? "").localizedStringKey)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(Color.primary)
                Spacer()
            }
            .padding(.top, 10)
            HStack {
                (model.type?.icon ?? R.image.loading_icon.swiftUIImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: (deviceWidth * 0.12).flat)
                Text("标题")
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(.top, 10)
            HStack {
                Spacer()
                Text("2026-03-03")
                    .font(.system(size: 11))
                    .foregroundStyle(Color.primary.opacity(0.8))
            }
            .padding(.bottom, 4)
        }
        .padding(.horizontal)
    }
    
}
