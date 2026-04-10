//
//  Library+Ex.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/12/23.
//

import UIKit
import HiLog
import HiStats
import HiSwiftUI
import Domain

extension Library: @retroactive @preconcurrency LibraryCompatible {
    
    @MainActor
    public func mySetup() {
        self.basic()
        self.logAndStats()
        self.mobShare()
        self.aliyunFeedback()
        self.aliyunPerformance()
        self.aliyunCrash()
    }
    
    func logAndStats() {
        logger.register(provider: SwiftyBeaverProvider())
        analytics.register(provider: UMengProvider.init())
        
        let aliyun = AliyunProvider.init()
        logger.register(provider: aliyun)
        analytics.register(provider: aliyun)
    }
    
    func mobShare() {
#if MOB_ENABLE
        MobSDK.uploadPrivacyPermissionStatus(true, privacyDataDelegate: PrivacyService.shared)
        ShareSDK.registPlatforms { register in
            register?.setupWeChat(
                withAppId: Platform.weixin.appId,
                appSecret: Platform.weixin.appKey,
                universalLink: Platform.weixin.appLink
            )
            register?.setupTwitter(
                withKey: Platform.twitter.appId,
                secret: Platform.twitter.appKey,
                redirectUrl: Platform.twitter.appLink
            )
        }
#endif
    }
    
    func aliyunFeedback() {
#if ALIYUN_ENABLE
        OCHelper.sharedInstance().feedbackKit.setUserNick(UIDevice.current.uuid)
#endif
    }
    
    func aliyunCrash() {
#if ALIYUN_ENABLE
        AlicloudCrashProvider.init().autoInit(
            withAppVersion: UIApplication.shared.version,
            channel: UIApplication.shared.inferredEnvironment.description,
            nick: UIDevice.current.uuid
        )
        AlicloudHAProvider.start()
#endif
    }
    
    func aliyunPerformance() {
#if ALIYUN_ENABLE
        AlicloudAPMProvider.init().autoInit(
            withAppVersion: UIApplication.shared.version,
            channel: UIApplication.shared.inferredEnvironment.description,
            nick: UIDevice.current.uuid
        )
        AlicloudHAProvider.start()
#endif
    }

}
