//
//  AppDelegate.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/3/9.
//

import UIKit
import HiLog
import HiCore
#if DEBUG
import FLEX
import GDPerformanceView_Swift
#endif

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        log("【AppDelegate】didFinishLaunchingWithOptions: \(application.connectedScenes)")
        if let scene = application.connectedScenes.first as? UIWindowScene {
            self.window = UIWindow(windowScene: scene)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.test(launchOptions: launchOptions)
        }
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        log("【AppDelegate】applicationDidBecomeActive")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        log("【AppDelegate】applicationWillEnterForeground")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        log("【AppDelegate】applicationDidEnterBackground")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        log("【AppDelegate】applicationWillTerminate")
    }

    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        log("【AppDelegate】application - open url")
        return true
    }
    
    // MARK: - userActivity
    func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        log("【AppDelegate】application - continue userActivity")
        return true
    }
    
    func test(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
#if DEBUG
        self.performanceView.start()
#endif
    }
    
#if DEBUG
    lazy var performanceView: PerformanceMonitor = {
        let view = PerformanceMonitor.init()
        view.performanceViewConfigurator.interactors = [
            UITapGestureRecognizer.init(target: self, action: #selector(handleTap(_:)))
        ]
        view.performanceViewConfigurator.options = [.performance, .memory]
        return view
    }()
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        FLEXManager.shared.showExplorer()
    }
#endif
    
}
