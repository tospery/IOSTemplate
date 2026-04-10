//
//  ClipboardClient.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/4/6.
//

import Foundation
import SwiftUI
import ComposableArchitecture

@DependencyClient
struct ClipboardClient {
    let fetchText: @Sendable () async -> String
    let saveText: @Sendable (String) async -> Void
}

extension ClipboardClient: DependencyKey {
    static var liveValue: Self {
        .init {
            UIPasteboard.general.string ?? ""
        } saveText: { text in
            UIPasteboard.general.string = text
        }
    }
}

extension DependencyValues {
    var clipboardClient: ClipboardClient {
        get { self[ClipboardClient.self] }
        set { self[ClipboardClient.self] = newValue }
    }
}

