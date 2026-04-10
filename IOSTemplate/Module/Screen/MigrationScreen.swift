//
//  MigrationScreen.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/3/28.
//

import SwiftUI
import Combine
import ComposableArchitecture
import SFSafeSymbols
import SwifterSwift
import AlertToast_Hi
import Kingfisher
import HiBase
import HiCore
import HiNav
import HiSwiftUI
import Domain
import NetworkPlatform
import RswiftResources
import HiLog

struct MigrationScreen: View {

    @Perception.Bindable var store: StoreOf<MigrationReducer>

    var body: some View {
        WithPerceptionTracking {
            ScrollView {
                VStack(spacing: 16) {
                    Spacer(minLength: 40)
                    switch store.status {
                    case .loading:
                        ProgressView()
                        Text("数据库初始化与迁移中…")
                            .font(.body)
                    case .success:
                        Text("数据库已就绪")
                            .font(.body)
                    case .failure(let error):
                        Text("数据库准备失败")
                            .font(.headline)
                        Text(Self.userMessage(for: error))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                        Button("重试") {
                            store.send(.load)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    if let version = store.appliedSchemaVersion, store.status == .success {
                        Text("Schema 版本：\(version)")
                            .font(.caption2)
                            .foregroundStyle(.tertiary)
                    }
                    Spacer(minLength: 40)
                }
                .padding(.horizontal, 24)
                .frame(maxWidth: .infinity)
                .frame(minHeight: screenHeight)
            }
            .background(Color.orange)
            .onAppear {
                stats(.beginPageView(name: self.className))
                store.send(.load)
            }
            .onDisappear {
                stats(.endPageView(name: self.className))
            }
        }
    }

    private static func userMessage(for error: APPError) -> String {
        switch error {
        case .databaseFailure(let message):
            return message
        default:
            return error.localizedDescription
        }
    }
}
