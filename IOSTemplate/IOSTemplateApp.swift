//
//  IOSTemplateApp.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/3/27.
//

import SwiftUI
import ComposableArchitecture
import Domain
import PersistencePlatorm

@main
struct IOSTemplateApp: App {
    
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
//
//    var body: some Scene {
//        WindowGroup {
//            ZStack {
//                let databaseState = appDelegate.store.appDelegateState.migrationState.databaseState
//
//                if databaseState == .idle {
//                    TabBarView(store: appDelegate.store).onAppear(perform: addTouchHandler).accentColor(.primary)
//                }
//                MigrationView(
//                    store: appDelegate.store.scope(
//                        state: \.appDelegateState.migrationState,
//                        action: \.appDelegate.migration
//                    )
//                )
//                .opacity(databaseState != .idle ? 1 : 0)
//                .animation(.linear(duration: 0.5), value: databaseState)
//            }
//            .navigationViewStyle(.stack)
//        }
//    }
    
//    WindowGroup {
//        TabBarScreen(store: Store(initialState: TabBarReducer.State.init(), reducer: {
//            TabBarReducer()
//        }))
//        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
//            logEnvironment()
//            handleClipboard()
//        }
//    }
    
    // @Shared(.preference) var preference = .default
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        print("沙盒路径:", NSHomeDirectory())
        // createSeedRealmFile
//        RealmBootstrap.createSeedRealmFile()
//        RealmBootstrap.prepareSeedFileIfNeed()
//        RealmBootstrap.installDefaultRealmConfiguration()
    }
    
//    WindowGroup {
//        Group {
//            if appDelegate.store.appDelegateState.migrationState.databaseState == .success {
//                TabBarView(store: appDelegate.store)
//                    .onAppear(perform: addTouchHandler)
//                    .accentColor(.primary)
//            } else {
//                MigrationView(
//                    store: appDelegate.store.scope(
//                        state: \.appDelegateState.migrationState,
//                        action: \.appDelegate.migration
//                    )
//                )
//            }
//        }
//        .animation(.linear(duration: 0.5), value: appDelegate.store.appDelegateState.migrationState.databaseState)
//    }
    
    var body: some Scene {
//        WindowGroup {
//            TabBarScreen.init(store: appDelegate.store)
//            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
//            }
//        }
        WindowGroup {
//            WithPerceptionTracking {
//                Group {
//                    if appDelegate.store.appDelegate.migration.status == .success {
//                        TabBarScreen.init(store: appDelegate.store)
//                    } else {
//                        MigrationScreen.init(
//                            store: appDelegate.store.scope(
//                                state: \.appDelegate.migration,
//                                action: \.appDelegate.migration
//                            )
//                        )
//                    }
//                }
//                .animation(.linear(duration: 0.5), value: appDelegate.store.appDelegate.migration.status)
//            }
            
            WithPerceptionTracking {
                Group {
                    if appDelegate.store.appDelegate.migration.status == .success {
                        TabBarScreen(store: Store(initialState: TabBarReducer.State.init(), reducer: {
                            TabBarReducer()
                        }))
                    } else {
                        MigrationScreen.init(
                            store: appDelegate.store.scope(
                                state: \.appDelegate.migration,
                                action: \.appDelegate.migration
                            )
                        )
                    }
                }
                .animation(.linear(duration: 0.5), value: appDelegate.store.appDelegate.migration.status)
            }
        }
    }
    
}
