//
//  AliyunProvider.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/3/28.
//

import Foundation
import HiSwiftUI
import HiBase
import HiLog
import HiStats

final class AliyunProvider: HiLog.ProviderType, HiStats.ProviderType {
    
    init() {
#if ALIYUN_ENABLE
        // Log
        AlicloudTlogProvider.init().autoInit(
            withAppVersion: UIApplication.shared.version,
            channel: UIApplication.shared.inferredEnvironment.description,
            nick: UIDevice.current.uuid
        )
        AlicloudHAProvider.start()
        TRDManagerService.update(.info)
        // Stats
        ALBBMANAnalytics.getInstance()?.autoInit()
        ALBBMANAnalytics.getInstance()?.setAppVersion(UIApplication.shared.version)
        ALBBMANAnalytics.getInstance()?.setChannel(UIApplication.shared.inferredEnvironment.description)
#endif
    }
    
    // swiftlint:disable function_parameter_count
    func log(
        _ message: @autoclosure () -> Any,
        module: String,
        level: Level,
        file: String,
        line: Int,
        function: String,
        context: Any?
    ) {
#if ALIYUN_ENABLE
        guard let message = message() as? String, message.isNotEmpty else { return }
        let tLog = TLogFactory.createTLog(forModuleName: module)
        switch level {
        case .debug, .verbose:
            tLog?.debug(message)
        case .info:
            tLog?.info(message)
        case .warning:
            tLog?.warn(message)
        case .error:
            tLog?.error(message)
        }
#endif
    }
    // swiftlint:enable function_parameter_count

    func stats(_ eventName: String, parameters: [String: Any]?) {
#if ALIYUN_ENABLE
        if eventName == AppEvent.userLoginSuccess(
            userid: "", username: "", nickname: "", email: ""
        ).name(for: self) {
            let userid = parameters?.string(for: Parameter.userid) ?? ""
            let username = parameters?.string(for: Parameter.username) ?? ""
            if userid.isNotEmpty && username.isNotEmpty {
                ALBBMANAnalytics.getInstance().updateUserAccount(username, userid: userid)
            }
        } else if eventName == AppEvent.beginPageView(name: "").name(for: self) {
            guard let name = parameters?.string(for: Parameter.name), name.isNotEmpty else { return }
            let builder = ALBBMANPageHitBuilder.init()
            builder.setPageName(name)
            builder.setProperty(Parameter.state, value: eventName)
            let traker = ALBBMANAnalytics.getInstance().getDefaultTracker()
            traker?.send(builder.build())
        } else if eventName == AppEvent.endPageView(name: "").name(for: self) {
            guard let name = parameters?.string(for: Parameter.name), name.isNotEmpty else { return }
            let builder = ALBBMANPageHitBuilder.init()
            builder.setPageName(name)
            builder.setProperty(Parameter.state, value: eventName)
            let traker = ALBBMANAnalytics.getInstance().getDefaultTracker()
            traker?.send(builder.build())
        } else {
            let builder = ALBBMANCustomHitBuilder.init()
            builder.setEventLabel(eventName)
            if let parameters = parameters {
                builder.setProperties(parameters)
            }
            let traker = ALBBMANAnalytics.getInstance().getDefaultTracker()
            traker?.send(builder.build())
        }
#endif
    }
    
}
