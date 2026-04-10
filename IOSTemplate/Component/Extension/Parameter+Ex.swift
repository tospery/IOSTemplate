//
//  Parameter+Ex.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/11/18.
//

import Foundation
import HiBase

extension Parameter {
    static var osType: String { "os_type" }
    static var osVersion: String { "os_version" }
    static var deviceModel: String { "device_model" }
    static var deviceId: String { "device_id" }
    static var appId: String { "app_id" }
    static var appVersion: String { "app_version" }
    static var appChannel: String { "app_channel" }
    static var clientId: String { "client_id" }
    static var clientSecret: String { "client_secret" }
    static var pageIndex: String { "page" }
    static var pageSize: String { "per_page" }
    static var pagingElement: String { "pagingElement" }
    static var language: String { "language" }
    static var content: String { "content" }
    static var since: String { "since" }
    static var sort: String { "sort" }
    static var order: String { "order" }
    static var option: String { "option" }
    static var reponame: String { "reponame" }
    static var searchKey: String { "q" }
    static var ref: String { "ref" }
    static var body: String { "body" }
    static var item: String { "item" }
    static var documentationUrl: String { "documentation_url" }
    static var pages: String { "pages" }
    static var subpath: String { "subpath" }
    static var authorization: String { "Authorization" }
    static var branches: String { "branches" }
    static var text: String { "text" }
    static var inpage: String { "inpage" }
    static var raw: String { "raw" }
    static var html: String { "html" }
    static var email: String { "email" }
    static var search: String { "search" }
    static var trending: String { "trending" }
    static var owner: String { "owner" }
    static var repo: String { "repo" }
    static var rawHost: String { "host" }
    static var rawPath: String { "path" }
    static var bio: String { "bio" }
    static var isFile: String { "_isFile" }
    static var blog: String { "blog" }
    static var company: String { "company" }
    static var location: String { "location" }
}
