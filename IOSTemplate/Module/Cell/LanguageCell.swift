//
//  LanguageCell.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/11/17.
//

import SwiftUI
import Domain
import HiCore
import HiResource

struct LanguageCell: View {
    let model: Language
    let selected: Bool
    let action: () -> Void
    
    init(_ model: Language, selected: Bool, action: @escaping () -> Void) {
        self.model = model
        self.selected = selected
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading) {
                HStack {
                    Circle()
                        .fill((model.name ?? "").hashColor.swiftUIColor)
                        .frame(width: 16, height: 16)
                        .padding(.leading)
                    Text(model.name ?? "")
                        .font(.callout)
                        .foregroundStyle(Color.primary)
                    Spacer()
                    if selected {
                        Image(uiImage: .checked)
                            .renderingMode(.template)
                            .font(.callout)
                            .foregroundStyle(Color.accentColor)
                            .padding(.trailing)
                    } else {
                        EmptyView()
                    }
                }
            }
            .frame(height: 44)
        }
    }
}
