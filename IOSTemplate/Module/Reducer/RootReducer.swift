//
//  RootReducer.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/11/17.
//

import SwiftUI
import Combine
import ComposableArchitecture
import SwifterSwift
import RealmSwift
import HiCore
import HiNav
import HiSwiftUI
import Domain
import HiLog

@Reducer
struct RootReducer {
    
    @ObservableState
    struct State: Equatable {
        @Shared(.preference) var preference = .default
        var appDelegate = AppReducer.State.init()
        
        var tabBarItemType = TabBarItemType.trending
        
        var trending = TrendingReducer.State.init(url: HiNav.shared.deepLink(host: .trending))
        var favorite = FavoriteReducer.State.init(url: HiNav.shared.deepLink(host: .favorite))
        var personal = PersonalReducer.State.init()
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
        
        case onScenePhaseChange(ScenePhase)
        case appDelegate(AppReducer.Action)
        case databaseInitialized(Result<Domain.Preference, Error>)
        
        case tabBarItemType(TabBarItemType)
        case trending(TrendingReducer.Action)
        case favorite(FavoriteReducer.Action)
        case personal(PersonalReducer.Action)
        
        case load
        case login
    }
    
    @Dependency(\.continuousClock) var clock
    @Dependency(\.applicationClient) var application
    @Dependency(\.platformClient) var platformClient
    private enum CancelID { case load, login }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case let .tabBarItemType(tabBarItemType):
                state.tabBarItemType = tabBarItemType
                return .none
            case .load:
                log("展示了root")
//                return .run { send in
////                    _ = await self.exampleData().asResult()
////                    _ = await performMigration().asResult()
//                    await send(.databaseInitialized(
//                        await self.databaseInitialize()
//                    ))
//                }.cancellable(id: CancelID.load)
                return .none
            case .login:
                return .run { _ in
                    _ = await self.application.open(
                        HiNav.shared.deepLink(host: .login).url!,
                        options: [:]
                    )
                }.cancellable(id: CancelID.login)
            case let .databaseInitialized(.success(preference)):
                // state.preference = preference // YJX_TODO
                return .none
            case let .databaseInitialized(.failure(error)):
                log("样本数据库失败: \(error)")
                return .none
            case .binding(\.preference):
                log("preference需要保存了。。。")
                let preference = state.preference
                return .run { [preference] _ in
                    _ = await self.platformClient.network().preferenceService().save(preference: preference).asResult()
                    _ = await self.platformClient.database().preferenceService().save(preference: preference).asResult()
                }
            default:
                return .none
            }
        }
        Scope(state: \.appDelegate, action: \.appDelegate) { AppReducer.init() }
        Scope(state: \.trending, action: \.trending) { TrendingReducer.init() }
        Scope(state: \.favorite, action: \.favorite) { FavoriteReducer.init() }
        Scope(state: \.personal, action: \.personal) { PersonalReducer.init() }
    }
    
    func databaseInitialize() async -> Result<Domain.Preference, Error> {
        let migration = await performMigration().asResult()
        if case let .failure(error)  = migration {
            return .failure(error)
        }
        let fetch = await self.platformClient.database().preferenceService().preference().asResult()
        if case let .failure(error)  = fetch {
            return .failure(error)
        }
        var preference = Domain.Preference.default
        if case let .success(value) = fetch {
            if let data = value {
                preference = data
            }
        }
        let save = await self.platformClient.network().preferenceService().save(preference: preference).asResult()
        if case let .failure(error) = save {
            return .failure(error)
        }
        return .success(preference)
    }
    
    func exampleData() -> AnyPublisher<Void, Error> {
        Future { promise in
            if Realm.fileExists(for: .defaultConfiguration) {
                promise(.success(()))
                return
            }
            let url = seedRealmUrl(for: schemaVersion)
            if FileManager.default.fileExists(atPath: url.path) {
                // swiftlint:disable force_try
                try! FileManager.default.removeItem(at: url)
                // swiftlint:enable force_try
            }
            // var cancellables: Set<AnyCancellable> = []
            let configuration = Realm.Configuration(fileURL: url, schemaVersion: UInt64(schemaVersion))
            IOSTemplate.exampleData(configuration)
                .sink { completion in
                    switch completion {
                    case .finished:
                        promise(.success(()))
                    case let .failure(error):
                        promise(.failure(error))
                    }
                } receiveValue: { _ in
                }
                .store(in: &disposeBag)
        }
        .eraseToAnyPublisher()
    }
    
    func performMigration() -> AnyPublisher<Void, Error> {
        Future { promise in
            //            for oldSchemaVersion in 0..<schemaVersion {
            //                let url = realmUrl(for: oldSchemaVersion, usingTemplate: true)
            //                let realmConfiguration = Realm.Current(
            //                    fileURL: url,
            //                    schemaVersion: UInt64(schemaVersion),
            //                    migrationBlock: migrationBlock
            //                )
            //                try! Realm.performMigration(for: realmConfiguration)
            //                migrationCheck(realmConfiguration)
            //            }
            if schemaVersion == 0 {
                if Realm.fileExists(for: .defaultConfiguration) {
                    promise(.success(()))
                    return
                }
                let bundleRealmUrl = bundleRealmUrl(for: schemaVersion)
                let defaultRealmUrl = Realm.Configuration.defaultConfiguration.fileURL!
                // swiftlint:disable force_try
                try! FileManager.default.copyItem(at: bundleRealmUrl, to: defaultRealmUrl)
                // swiftlint:enable force_try
                // var cancellables: Set<AnyCancellable> = []
                migrationCheck(.defaultConfiguration)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            promise(.success(()))
                        case let .failure(error):
                            promise(.failure(error))
                        }
                    }, receiveValue: { _ in
                    })
                    .store(in: &disposeBag)
            } else {
                // 数据升级处理
                promise(.success(()))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func seedRealmUrl(for schemaVersion: Int) -> URL {
        let defaultURL = Realm.Configuration.defaultConfiguration.fileURL!
        let defaultParentURL = defaultURL.deletingLastPathComponent()
        let fileName = "default-v\(schemaVersion)"
        let destinationUrl = defaultParentURL.appendingPathComponent(fileName + ".realm")
        return destinationUrl
    }
    
    func bundleRealmUrl(for schemaVersion: Int) -> URL {
        let fileName = "default-v\(schemaVersion)"
        let bundleUrl = Bundle.main.url(forResource: fileName, withExtension: "realm")!
        return bundleUrl
    }
    
}
