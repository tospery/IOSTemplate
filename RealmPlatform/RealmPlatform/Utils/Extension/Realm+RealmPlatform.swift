//
//  Realm+Ex.swift
//  RealmPlatform
//
//  Created by 杨建祥 on 2024/5/12.
//

import Foundation
import Combine
import RealmSwift

extension Realm {
    static var `default`: Self { try! Self.init() }
}


extension RealmSwift.SortDescriptor {
    init(sortDescriptor: NSSortDescriptor) {
        self.init(keyPath: sortDescriptor.key ?? "", ascending: sortDescriptor.ascending)
    }
}

extension Realm {
    func save<R: RealmRepresentable>(entity: R, update: Bool = true) -> AnyPublisher<Void, Error> where R.RealmType: Object {
         return Future<Void, Error> { promise in
             do {
                 try self.write {
                     self.add(entity.asRealm(), update: update ? .all : .error)
                 }
                 promise(.success(()))
             } catch {
                 promise(.failure(error as! Realm.Error))
             }
         }
         .eraseToAnyPublisher()
     }
    
    func save<R: RealmRepresentable>(entities: [R], update: Bool = true) -> AnyPublisher<Void, Error> where R.RealmType: Object {
        return Future<Void, Error> { promise in
            do {
                try self.write {
                    self.add(entities.map { $0.asRealm() }, update: update ? .all : .error)
                }
                promise(.success(()))
            } catch {
                promise(.failure(error as! Realm.Error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func delete<R: RealmRepresentable>(entity: R) -> AnyPublisher<Void, Error> where R.RealmType: Object {
        return Future<Void, Error> { promise in
            do {
                // guard let object = self.base.object(ofType: R.RealmType.self, forPrimaryKey: entity.uid) else { fatalError() }
                // guard let object = self.base.object(ofType: R.RealmType.self, forPrimaryKey: "id") else { fatalError() }
                guard let object = self.objects(R.RealmType.self).first else {
                    return promise(.success(()))
                }
                try self.write {
                    self.delete(object)
                }
                promise(.success(()))
            } catch {
                promise(.failure(error as! Realm.Error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func delete<R: RealmRepresentable>(entities: [R]) -> AnyPublisher<Void, Error> where R.RealmType: Object {
        return Future<Void, Error> { promise in
            do {
                try self.write {
                    self.delete(entities.map { $0.asRealm() })
                }
                promise(.success(()))
            } catch {
                promise(.failure(error as! Realm.Error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func delete<R: RealmRepresentable>(type: R.Type) -> AnyPublisher<Void, Error> where R.RealmType: Object {
        return Future<Void, Error> { promise in
            do {
                let objects = self.objects(R.RealmType.self)
                try self.write {
                    self.delete(objects)
                }
                promise(.success(()))
            } catch {
                promise(.failure(error as! Realm.Error))
            }
        }
        .eraseToAnyPublisher()
    }
}
