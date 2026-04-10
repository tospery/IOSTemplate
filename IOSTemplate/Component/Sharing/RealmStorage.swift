import ConcurrencyExtras
import Dependencies
import Dispatch
import Foundation
import Sharing

/// 为 ``RealmStorageKey`` 提供调度（主队列）与可选的内存模拟存储（测试/预览）。
///
/// 实际 Realm 读写由 ``RealmStorageKey`` 根据传入的 `Object.Type` 完成；本类型不再内置任何 `Object` 子类。
public struct RealmStorage: Hashable, Sendable {
  private let id = UUID()

  /// 在可安全访问 Realm 的队列上执行（`live` 默认为主队列）。
  public let schedule: @Sendable (@escaping @Sendable () -> Void) -> Void

  /// ``SaveContext/didSet`` 防抖延迟调度，与 ``schedule`` 使用同一套队列语义。
  public let asyncAfter: @Sendable (DispatchTimeInterval, DispatchWorkItem) -> Void

  /// 非 `nil` 时，``RealmStorageKey`` 读写走该字典而不打开 Realm。
  let simulatedBacking: LockIsolated<[String: Data]>?
  let simulatedObservers: LockIsolated<[String: [UUID: @Sendable () -> Void]]>?

  public init(
    schedule: @escaping @Sendable (@escaping @Sendable () -> Void) -> Void,
    asyncAfter: @escaping @Sendable (DispatchTimeInterval, DispatchWorkItem) -> Void,
    simulatedBacking: LockIsolated<[String: Data]>? = nil,
    simulatedObservers: LockIsolated<[String: [UUID: @Sendable () -> Void]]>? = nil
  ) {
    precondition(
      (simulatedBacking == nil) == (simulatedObservers == nil),
      "simulatedBacking and simulatedObservers must both be nil (live) or both non-nil (in-memory)."
    )
    self.schedule = schedule
    self.asyncAfter = asyncAfter
    self.simulatedBacking = simulatedBacking
    self.simulatedObservers = simulatedObservers
  }

  var isSimulated: Bool { simulatedBacking != nil }

  public static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.id == rhs.id
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }

  public static let live = Self(
    schedule: { work in DispatchQueue.main.async(execute: work) },
    asyncAfter: { interval, item in
      DispatchQueue.main.asyncAfter(deadline: .now() + interval, execute: item)
    },
    simulatedBacking: nil,
    simulatedObservers: nil
  )

  /// 不访问 Realm：用内存字典模拟持久化，并在 `save` 时触发 ``observe`` 回调。
  public static func inMemory(
    backing: LockIsolated<[String: Data]> = LockIsolated([:]),
    observerIDs: LockIsolated<[String: [UUID: @Sendable () -> Void]]> = LockIsolated([:])
  ) -> Self {
    Self(
      schedule: { work in DispatchQueue.main.async(execute: work) },
      asyncAfter: { interval, item in
        DispatchQueue.main.asyncAfter(deadline: .now() + interval, execute: item)
      },
      simulatedBacking: backing,
      simulatedObservers: observerIDs
    )
  }
}

private enum DefaultRealmStorageKey: DependencyKey {
  static var liveValue: RealmStorage { .live }
  static var previewValue: RealmStorage { .inMemory() }
  static var testValue: RealmStorage { .inMemory() }
}

extension DependencyValues {
  /// 由 ``RealmStorageKey`` 使用：``live`` 或测试用 ``RealmStorage/inMemory(backing:observerIDs:)``。
  public var defaultRealmStorage: RealmStorage {
    get { self[DefaultRealmStorageKey.self] }
    set { self[DefaultRealmStorageKey.self] = newValue }
  }
}
