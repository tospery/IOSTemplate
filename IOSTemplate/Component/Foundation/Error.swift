//
//  Error.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/3/28.
//

import Foundation
import HiCore

enum APPError: Error, Identifiable, Equatable, Hashable {
    case oauth
    case login(String)
    case pdf
    case seedSchemesFailed
    case seedLanguagesFailed
    case seedDefaultCurrentFailed
    case searchRecordIsEmpty
    case locateRefused
    case locateFailure
    case databaseFailure(String)
    
    var id: String { localizedDescription }
    var domain: String { "\(UIApplication.shared.bundleName)Domain" }
}

extension APPError: CustomNSError {
    var errorCode: Int {
        switch self {
        case .oauth: return 1
        case .login: return 2
        case .pdf: return 3
        case .seedSchemesFailed: return 4
        case .seedLanguagesFailed: return 5
        case .seedDefaultCurrentFailed: return 6
        case .searchRecordIsEmpty: return 6
        case .locateRefused: return 7
        case .locateFailure: return 8
        case .databaseFailure: return 9
        }
    }
}

extension APPError: HiErrorCompatible {
    var hiError: HiError {
        switch self {
        case .login(let message),
                .databaseFailure(let message):
            return .app(self.domain, self.errorCode, message, nil)
        case .searchRecordIsEmpty: return .app(
            self.domain, self.errorCode, R.string.localizable.searchHistoryEmpty.localizedString, nil
        )
        default: return .app(self.domain, self.errorCode, nil, nil)
        }
    }
}
