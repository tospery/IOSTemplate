import ConcurrencyExtras
import Dependencies
import Dispatch
import Foundation
import Realm
import RealmSwift
import Sharing

extension SharedReaderKey {
  /// 使用 `toDomain` 读取、`writeThrough` 在 **write 事务** 内写回 Realm。
  ///
  /// `RealmObject` 由 ``RealmStorageKey/Value/RealmObject`` 推断。
  ///
  /// **写入**
  /// - 若 `object(ofType:forPrimaryKey:)` 已存在：只调用 `writeThrough(domain, existing)`。
  /// - 否则：`RealmObject()` → `writeThrough(domain, obj)` → `realm.add(obj)`。
  ///
  /// **主键**：Realm **禁止**对已 `add` 的对象再写入主键属性（即使值相同也会抛错）。请在 `writeThrough` 里仅对 **尚未插入** 的对象设置主键，例如：
  /// `if realmObject.realm == nil { realmObject.id = domainObject.id }`。
  ///
  /// **示例**
  /// ```swift
  /// extension SharedKey where Self == RealmStorageKey<Stats, RMStats> {
  ///   fileprivate static var stats: Self {
  ///     realmStorage(
  ///       .defaultConfiguration,
  ///       primaryKey: "default",
  ///       toDomain: { $0.asDomain() },
  ///       writeThrough: { domainObject, realmObject in
  ///         if realmObject.realm == nil {
  ///           realmObject.id = domainObject.id
  ///         }
  ///         realmObject.count = domainObject.count
  ///         realmObject.maxCount = domainObject.maxCount
  ///         realmObject.minCount = domainObject.minCount
  ///         realmObject.numberOfCounts = domainObject.numberOfCounts
  ///       }
  ///     )
  ///   }
  /// }
  /// ```
  public static func realmStorage<Value: Codable & Sendable, RealmObject: Object>(
    _ configuration: Realm.Configuration,
    primaryKey: String,
    toDomain: @escaping @Sendable (RealmObject) throws -> Value,
    writeThrough: @escaping @Sendable (_ domain: Value, _ realmObject: RealmObject) throws -> Void
  ) -> Self
  where Self == RealmStorageKey<Value, RealmObject> {
    RealmStorageKey(
      configuration: configuration,
      primaryKey: primaryKey,
      toDomain: toDomain,
      writeThrough: writeThrough
    )
  }
}

/// 以 `RealmObject` 为存储载体、以 `Value` 为 `@Shared` 值的 Realm 持久化键。
public final class RealmStorageKey<Value: Codable & Sendable, RealmObject: Object>: SharedKey {
  private let configuration: Realm.Configuration
  private let primaryKey: String
  private let storage: RealmStorage
  private let toDomain: @Sendable (RealmObject) throws -> Value
  private let writeThrough: @Sendable (Value, RealmObject) throws -> Void

  fileprivate let state = LockIsolated(State())

  fileprivate struct State {
    var continuations: [SaveContinuation] = []
    var value: Value?
    var workItem: DispatchWorkItem?
    mutating func cancelWorkItem() {
      value = nil
      workItem?.cancel()
      workItem = nil
    }
  }

  public var id: RealmStorageKeyID<RealmObject> {
    RealmStorageKeyID(configuration: configuration, primaryKey: primaryKey, storage: storage)
  }

  fileprivate init(
    configuration: Realm.Configuration,
    primaryKey: String,
    toDomain: @escaping @Sendable (RealmObject) throws -> Value,
    writeThrough: @escaping @Sendable (Value, RealmObject) throws -> Void
  ) {
    @Dependency(\.defaultRealmStorage) var storage
    self.storage = storage
    self.configuration = configuration
    self.primaryKey = primaryKey
    self.toDomain = toDomain
    self.writeThrough = writeThrough
  }

  public func load(context _: LoadContext<Value>, continuation: LoadContinuation<Value>) {
    storage.schedule { [configuration, primaryKey, storage, toDomain] in
      do {
        if let domain = try Self.readDomain(
          storage: storage,
          configuration: configuration,
          primaryKey: primaryKey,
          toDomain: toDomain
        ) {
          continuation.resume(returning: domain)
        } else {
          continuation.resumeReturningInitialValue()
        }
      } catch {
        continuation.resume(throwing: error)
      }
    }
  }

  public func subscribe(
    context _: LoadContext<Value>, subscriber: SharedSubscriber<Value>
  ) -> SharedSubscription {
    let outerCancel = LockIsolated<SharedSubscription?>(nil)
    storage.schedule { [weak self] in
      guard let self else { return }
      do {
        let inner = try Self.observeChanges(
          storage: storage,
          configuration: configuration,
          primaryKey: primaryKey
        ) { [weak self] in
          guard let self else { return }
          storage.schedule {
            self.deliverLatest(to: subscriber)
          }
        }
        outerCancel.withValue { $0 = inner }
        deliverLatest(to: subscriber)
      } catch {
        subscriber.yield(throwing: error)
      }
    }
    return SharedSubscription {
      outerCancel.withValue {
        $0?.cancel()
        $0 = nil
      }
    }
  }

  public func save(_ value: Value, context: SaveContext, continuation: SaveContinuation) {
    storage.schedule { [weak self] in
      guard let self else {
        continuation.resume()
        return
      }
      do {
        try self.state.withValue { state in
          switch context {
          case .didSet:
            if state.workItem == nil {
              try Self.persist(
                storage: self.storage,
                configuration: self.configuration,
                primaryKey: self.primaryKey,
                value: value,
                writeThrough: self.writeThrough
              )
              continuation.resume()
              let workItem = DispatchWorkItem { [weak self] in
                guard let self else { return }
                self.state.withValue { state in
                  defer {
                    state.value = nil
                    state.workItem = nil
                  }
                  guard let value = state.value else { return }
                  let result = Result {
                    try Self.persist(
                      storage: self.storage,
                      configuration: self.configuration,
                      primaryKey: self.primaryKey,
                      value: value,
                      writeThrough: self.writeThrough
                    )
                  }
                  for continuation in state.continuations {
                    continuation.resume(with: result)
                  }
                  state.continuations.removeAll()
                }
              }
              state.workItem = workItem
              self.storage.asyncAfter(.seconds(1), workItem)
            } else {
              state.value = value
              state.continuations.append(continuation)
            }

          case .userInitiated:
            state.cancelWorkItem()
            try Self.persist(
              storage: self.storage,
              configuration: self.configuration,
              primaryKey: self.primaryKey,
              value: value,
              writeThrough: self.writeThrough
            )
            continuation.resume()
          }
        }
      } catch {
        continuation.resume(throwing: error)
      }
    }
  }

  private func deliverLatest(to subscriber: SharedSubscriber<Value>) {
    do {
      if let domain = try Self.readDomain(
        storage: storage,
        configuration: configuration,
        primaryKey: primaryKey,
        toDomain: toDomain
      ) {
        subscriber.yield(domain)
      } else {
        subscriber.yieldReturningInitialValue()
      }
    } catch {
      subscriber.yield(throwing: error)
    }
  }

  private static func simulationCompoundKey(
    configuration: Realm.Configuration,
    primaryKey: String
  ) -> String {
    let path = configuration.fileURL?.path ?? ""
    let mem = configuration.inMemoryIdentifier ?? ""
    let tid = ObjectIdentifier(RealmObject.self)
    return "\(tid)\u{1D}\(path)\u{1D}\(mem)\u{1D}\(primaryKey)"
  }

  private static func readDomain(
    storage: RealmStorage,
    configuration: Realm.Configuration,
    primaryKey: String,
    toDomain: @escaping @Sendable (RealmObject) throws -> Value
  ) throws -> Value? {
    if storage.isSimulated, let backing = storage.simulatedBacking {
      let key = simulationCompoundKey(configuration: configuration, primaryKey: primaryKey)
      guard let data = backing.withValue({ $0[key] }), !data.isEmpty else { return nil }
      return try JSONDecoder().decode(Value.self, from: data)
    }

    let realm = try Realm(configuration: configuration)
    guard let obj = realm.object(ofType: RealmObject.self, forPrimaryKey: primaryKey) else {
      return nil
    }
    return try toDomain(obj)
  }

  private static func persist(
    storage: RealmStorage,
    configuration: Realm.Configuration,
    primaryKey: String,
    value: Value,
    writeThrough: @escaping @Sendable (Value, RealmObject) throws -> Void
  ) throws {
    if storage.isSimulated, let backing = storage.simulatedBacking {
      let key = simulationCompoundKey(configuration: configuration, primaryKey: primaryKey)
      let data = try JSONEncoder().encode(value)
      backing.withValue { $0[key] = data }
      if let observers = storage.simulatedObservers {
        let callbacks: [@Sendable () -> Void] = observers.withValue { dict in
          guard let inner = dict[key] else { return [] }
          return Array(inner.values)
        }
        for callback in callbacks {
          callback()
        }
      }
      return
    }

    let realm = try Realm(configuration: configuration)
    try realm.write {
      if let existing = realm.object(ofType: RealmObject.self, forPrimaryKey: primaryKey) {
        try writeThrough(value, existing)
      } else {
        let obj = RealmObject()
        try writeThrough(value, obj)
        realm.add(obj)
      }
    }
  }

  private static func observeChanges(
    storage: RealmStorage,
    configuration: Realm.Configuration,
    primaryKey: String,
    onChange: @escaping @Sendable () -> Void
  ) throws -> SharedSubscription {
    if storage.isSimulated, let observers = storage.simulatedObservers {
      let key = simulationCompoundKey(configuration: configuration, primaryKey: primaryKey)
      let token = UUID()
      observers.withValue { $0[key, default: [:]][token] = onChange }
      return SharedSubscription {
        observers.withValue { bucket in
          bucket[key]?[token] = nil
          if bucket[key]?.isEmpty == true {
            bucket[key] = nil
          }
        }
      }
    }

    let realm = try Realm(configuration: configuration)
    let pkName = try primaryKeyPropertyName(RealmObject.self)
    let results = realm.objects(RealmObject.self)
      .filter(NSPredicate(format: "%K == %@", pkName, primaryKey))
    let token = results.observe { _ in
      onChange()
    }
    return SharedSubscription {
      token.invalidate()
    }
  }

  private static func primaryKeyPropertyName(_ objectType: RealmObject.Type) throws -> String {
    let dummy = RealmObject()
    guard let name = dummy.objectSchema.primaryKeyProperty?.name else {
      throw RealmStorageError.noPrimaryKey(typeName: String(reflecting: objectType))
    }
    return name
  }
}

extension RealmStorageKey: CustomStringConvertible {
  public var description: String {
    ".realmStorage(\(String(reflecting: primaryKey)), \(String(reflecting: RealmObject.self)))"
  }
}

/// ``RealmStorageKey`` 的稳定标识（含 `RealmObject` 类型）。
public struct RealmStorageKeyID<RealmObject: Object>: Hashable {
  fileprivate let configuration: Realm.Configuration
  fileprivate let primaryKey: String
  fileprivate let storage: RealmStorage

  public static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.configuration == rhs.configuration
      && lhs.primaryKey == rhs.primaryKey
      && lhs.storage == rhs.storage
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(primaryKey)
    hasher.combine(storage)
    hasher.combine(ObjectIdentifier(RealmObject.self))
    hasher.combine(configuration.fileURL)
    hasher.combine(configuration.inMemoryIdentifier)
    hasher.combine(configuration.schemaVersion)
    hasher.combine(configuration.readOnly)
    hasher.combine(configuration.encryptionKey)
    if let sync = configuration.syncConfiguration {
      hasher.combine(String(describing: sync.partitionValue))
    }
  }
}

/// Realm 模型缺少主键声明时抛出（用于构建观察查询）。
public enum RealmStorageError: Error, Sendable {
  case noPrimaryKey(typeName: String)
}
