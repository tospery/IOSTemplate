//
//  PreferenceService.swift
//  Domain
//
//  Created by 杨建祥 on 2024/5/12.
//

import Foundation
import Combine

public protocol PreferenceService {

    func preference() -> AnyPublisher<Preference?, Error>
    func save(preference: Preference) -> AnyPublisher<Void, Error>

}
