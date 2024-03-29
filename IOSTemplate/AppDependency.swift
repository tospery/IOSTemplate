//
//  AppDependency.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2024/3/29.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import URLNavigator_Hi
import Rswift
import HiIOS
import RxOptional
import RxSwiftExt
import NSObject_Rx
import RxDataSources
import RxViewController
import RxTheme
import ReusableKit_Hi
import ObjectMapper_Hi
import SwifterSwift
import BonMot


final class AppDependency: HiIOS.AppDependency {

    static var shared = AppDependency()
    
    // MARK: - Initialize
    override func initialScreen(with window: inout UIWindow?) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        self.window = window

        let reactor = TabBarReactor(self.provider, nil)
        let controller = TabBarController(self.navigator, reactor)
        self.window.rootViewController = controller
        self.window.makeKeyAndVisible()
    }
    
    // MARK: - Test
    override func test(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        log("环境参数: \(envParameters)", module: .common)
        log("accessToken = \(AccessToken.current?.accessToken ?? "")")
//        let string = "abcd1234"
//        let aaa = string.startIndex..<string.endIndex
//        let bbb = string[aaa]
//        let ccc = string[string.startIndex..<string.index(string.startIndex, offsetBy: 3)]
//        log("测试一下: \(bbb), \(ccc)")
//        let string = "@commaai @tinygrad "
//        let aaa = string.substrings(pattern: "@([^@\\s]+)")
//        let aaa = 123456789
//        let bbb = aaa.double.moneyStyleText
//        log("测试一下: \(bbb)")
        log("用户参数: \(userParameters)", module: .common)
    }

    // MARK: - Setup
    override func setupConfiguration() {
        
    }
    
    // MARK: - Lifecycle
    override func application(
        _ application: UIApplication,
        entryDidFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) {
        super.application(application, entryDidFinishLaunchingWithOptions: launchOptions)
    }
    
    override func application(
        _ application: UIApplication,
        leaveDidFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) {
        super.application(application, leaveDidFinishLaunchingWithOptions: launchOptions)
    }
    
    // MARK: - URL
    override func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any]
    ) -> Bool {
//        let result = UMSocialManager.default().handleOpen(url, options: options)
//        if !result {
//            // 其他SDK，如支付
//        }
//        return result
        super.application(app, open: url, options: options)
    }
    
    // MARK: - userActivity
    override func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
//        let result = UMSocialManager.default().handleUniversalLink(userActivity, options: nil)
//        if !result {
//            // 其他SDK，如支付
//        }
//        return result
        super.application(application, continue: userActivity, restorationHandler: restorationHandler)
    }
    
}

