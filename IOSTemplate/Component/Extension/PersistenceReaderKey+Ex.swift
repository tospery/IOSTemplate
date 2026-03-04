//
//  PersistenceReaderKey+Ex.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/3/4.
//

import Foundation
import ComposableArchitecture
import HiBase
import Domain

extension PersistenceReaderKey where Self == FileStorageKey<Domain.Preference> {
    static var profile: Self {
        fileStorage(.documentsDirectory.appending(component: "profile.json"))
    }
}
