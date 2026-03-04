//
//  Repository.swift
//  RealmPlatform
//
//  Created by 杨建祥 on 2024/5/13.
//

import Foundation
import Combine
import Combine_Realm_Hi
import RealmSwift
import HiBase

protocol AbstractRepository {
    associatedtype T
    func query(with predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]) -> AnyPublisher<[T], Error>
    func save(entity: T) -> AnyPublisher<Void, Error>
    func save(entities: [T]) -> AnyPublisher<Void, Error>
    func delete(entity: T) -> AnyPublisher<Void, Error>
    func delete(entities: [T]) -> AnyPublisher<Void, Error>
    func delete(type: T.Type) -> AnyPublisher<Void, Error>
}

final class Repository<T: RealmRepresentable>: AbstractRepository where T == T.RealmType.DomainType, T.RealmType: Object {
    
    private let configuration: Realm.Configuration
    private let scheduler: ImmediateScheduler

    private var realm: Realm {
        return try! Realm(configuration: self.configuration)
    }

    init(configuration: Realm.Configuration) {
        self.configuration = configuration
        self.scheduler = ImmediateScheduler.shared
    }

    func query(with predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor] = []) -> AnyPublisher<[T], Error>  {
        Future<[T], Error> { promise in
            let realm = self.realm
            var objects = realm.objects(T.RealmType.self)
            if let predicate = predicate {
                objects = objects.filter(predicate)
            }
            let result = Array(objects).mapToDomain()
            promise(.success(result))
        }
        .subscribe(on: scheduler)
        .eraseToAnyPublisher()
//        Deferred {
//            Future<[T], Error> { promise in
//                let realm = self.realm
//                var objects = realm.objects(T.RealmType.self)
//                if let predicate = predicate {
//                    objects = objects.filter(predicate)
//                }
//                let result = Array(objects).mapToDomain()
//                promise(.success(result))
//            }
//        }
//        .subscribe(on: ImmediateScheduler.shared)
//        .eraseToAnyPublisher()
//        return Deferred {
//            Future<[T], Error> { promise in
//                //            let primaryKey = predicate?.primaryKey()
//                //            if primaryKey?.isNotEmpty ?? false {
//                //                let object = realm.object(ofType: T.RealmType.self, forPrimaryKey: primaryKey!)
//                //                if object == nil {
//                //                    return .just([])
//                //                }
//                //                return .just([object!.asDomain()])
//                //            }
//                let realm = self.realm
//                var objects = realm.objects(T.RealmType.self)
//                if let predicate = predicate {
//                    objects = objects.filter(predicate)
//                }
//                let result = Array(objects).mapToDomain()
//                promise(.success(result))
//            }
//        }
//        .subscribe(on: scheduler)
//        .eraseToAnyPublisher()
    }

    func save(entity: T) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            _ = self.realm.save(entity: entity)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        promise(.success(()))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }, receiveValue: { _ in })
        }
        .subscribe(on: scheduler)
        .eraseToAnyPublisher()
    }

    func save(entities: [T]) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            _ = self.realm.save(entities: entities)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        promise(.success(()))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }, receiveValue: { _ in })
        }
        .subscribe(on: scheduler)
        .eraseToAnyPublisher()
    }
    
    func delete(entity: T) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            _ = self.realm.delete(entity: entity)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        promise(.success(()))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }, receiveValue: { _ in })
        }
        .subscribe(on: scheduler)
        .eraseToAnyPublisher()
    }
    
    func delete(entities: [T]) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            _ = self.realm.delete(entities: entities)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        promise(.success(()))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }, receiveValue: { _ in })
        }
        .subscribe(on: scheduler)
        .eraseToAnyPublisher()
    }

    func delete(type: T.Type) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            _ = self.realm.delete(type: type)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        promise(.success(()))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }, receiveValue: { _ in })
        }
        .subscribe(on: scheduler)
        .eraseToAnyPublisher()
    }
    
}
