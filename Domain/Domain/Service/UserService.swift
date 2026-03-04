//
//  UserService.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/19.
//

import Foundation
import Combine

public protocol UserService {

    func follow(owner: String) -> AnyPublisher<Void, Error>
    func unfollow(owner: String) -> AnyPublisher<Void, Error>
    func checkFollowing(owner: String) -> AnyPublisher<Bool, Error>
    
    func login(token: String) -> AnyPublisher<User, Error>
    
    /// 用户信息
    /// - API: https://docs.github.com/en/rest/reference/users#get-a-user
    /// - Demo: https://api.github.com/users/ReactiveX
    func user(owner: String) -> AnyPublisher<User, Error>
    
    /// 修改用户信息
    /// - API: https://docs.github.com/en/rest/reference/users#update-the-authenticated-user
    /// - Demo: https://api.github.com/user
    func modify(key: String, value: String) -> AnyPublisher<User, Error>
    
    func followers(owner: String, pageIndex: Int, pageSize: Int) -> AnyPublisher<[User], Error>
    func following(owner: String, pageIndex: Int, pageSize: Int) -> AnyPublisher<[User], Error>
    func stargazers(owner: String, repo: String, pageIndex: Int, pageSize: Int) -> AnyPublisher<[User], Error>
    func contributors(owner: String, repo: String, pageIndex: Int, pageSize: Int) -> AnyPublisher<[User], Error>
    func subscribers(owner: String, repo: String, pageIndex: Int, pageSize: Int) -> AnyPublisher<[User], Error>
    
    func users() -> AnyPublisher<[User], Error>
    func save(users: [User]) -> AnyPublisher<Void, Error>
    func delete(users: [User]) -> AnyPublisher<Void, Error>
    
}

