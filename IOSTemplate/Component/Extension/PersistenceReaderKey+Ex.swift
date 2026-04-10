//
//  InMemoryKey+Ex.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/11/17.
//

import Foundation
import ComposableArchitecture
import HiBase
import Domain

extension SharedKey where Self == FileStorageKey<Domain.Preference> {
    static var preference: Self {
        fileStorage(.documentsDirectory.appending(component: "preference.json"))
    }
}
