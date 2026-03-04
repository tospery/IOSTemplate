//
//  UMengProvider.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/12/24.
//

import UIKit
import HiBase
import HiLog
import HiSwiftUI
import HiStats
import Domain
import HiCore
import SwifterSwift

class UMengProvider: HiStats.ProviderType {
    
    init() {
#if UMENG_ENABLE
        UMConfigure.initWithAppkey(
            Platform.umeng.appId,
            channel: UIApplication.shared.inferredEnvironment.description
        )
#endif
    }

    func stats(_ eventName: String, parameters: [String: Any]?) {
#if UMENG_ENABLE
        if eventName == AppEvent.userLoginSuccess(
            userid: "", username: "", nickname: "", email: ""
        ).name(for: self) {
            let userid = parameters?.string(for: Parameter.userid) ?? ""
            let username = parameters?.string(for: Parameter.username) ?? ""
            let nickname = parameters?.string(for: Parameter.nickname) ?? ""
            let email = parameters?.string(for: Parameter.email) ?? ""
            if userid.isNotEmpty {
                MobClick.profileSignIn(withPUID: userid)
            }
            if email.isNotEmpty {
                MobClick.userProfileEMail(email)
            }
            if username.isNotEmpty {
                MobClick.userProfile(username, to: Parameter.username)
            }
            if nickname.isNotEmpty {
                MobClick.userProfile(nickname, to: Parameter.nickname)
            }
        } else if eventName == AppEvent.beginPageView(name: "").name(for: self) {
            guard let name = parameters?.string(for: Parameter.name), name.isNotEmpty else { return }
            MobClick.beginLogPageView(name)
        } else if eventName == AppEvent.endPageView(name: "").name(for: self) {
            guard let name = parameters?.string(for: Parameter.name), name.isNotEmpty else { return }
            MobClick.endLogPageView(name)
        } else {
            MobClick.event(eventName, attributes: parameters ?? [:])
        }
#endif
    }
    
}
