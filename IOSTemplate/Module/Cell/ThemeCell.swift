//
//  ThemeCell.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/11/14.
//

import SwiftUI
import ComposableArchitecture
import SFSafeSymbols
import SwifterSwift

import HiCore
import HiSwiftUI
import Domain

struct ThemeCell: View {
    let model: ColorTheme
    let selected: Bool
    let action: () -> Void
    
    init(_ model: ColorTheme, selected: Bool, action: @escaping () -> Void) {
        self.model = model
        self.selected = selected
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                Circle()
                    .fill(model.swiftUIColor)
                    .frame(width: 34, height: 34)
                    .padding(.leading)
                Text(model.rawValue.capitalizedFirstCharacter.localizedString)
                    .font(.system(size: 15))
                    .foregroundStyle(Color.primary.opacity(0.8))
                Spacer()
                if selected {
                    Image(systemSymbol: .checkmark)
                        .font(.system(size: 13))
                        .foregroundStyle(Color.accentColor)
                        .padding(.trailing)
                } else {
                    EmptyView()
                }
            }
            .frame(height: 50)
            .background(Color.background)
        }
    }
}
