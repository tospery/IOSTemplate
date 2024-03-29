//
//  TestViewController.swift
//  SWHub
//
//  Created by 杨建祥 on 2023/1/13.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import URLNavigator_Hi
import Rswift
import ReusableKit_Hi
import ObjectMapper_Hi
import RxDataSources
import RxGesture
import HiIOS

class TestViewController: ListViewController {
    
    lazy var webView: WKWebView = {
        let js = """
var meta = document.createElement('meta');
meta.setAttribute('name', 'viewport');
meta.setAttribute('content', 'width=device-width,initial-scale=1.0, maximum-scale=1.0, user-scalable=no');
document.getElementsByTagName('head')[0].appendChild(meta);
"""
        let script = WKUserScript(source: js, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let controller = WKUserContentController()
        controller.addUserScript(script)
        let config = WKWebViewConfiguration()
        config.userContentController = controller
        let view = WKWebView(
            frame: CGRect(x: 0, y: 0, width: deviceWidth, height: deviceHeight), configuration: config
        )
        view.navigationDelegate = self
//            view.scrollView.isScrollEnabled = false
        if #available(iOS 11.0, *) {
            view.scrollView.contentInsetAdjustmentBehavior = .never
        }
        return view
    }()
    
    required init(_ navigator: NavigatorProtocol, _ reactor: BaseViewReactor) {
        super.init(navigator, reactor)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.addSubview(self.button)
//        self.button.rx.tap
//            .subscribeNext(weak: self, type(of: self).tapTest)
//            .disposed(by: self.rx.disposeBag)
        self.view.addSubview(self.webView)
        guard let request = URLRequest(
            urlString: "https://raw.githubusercontent.com/Urinx/WeixinBot/master/README.md"
        ) else { return }
        self.webView.load(request)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        self.button.left = self.button.leftWhenCenter
//        self.button.top = self.button.topWhenCenter
        self.webView.frame = self.scrollView.frame
    }
    
//    func tapTest(_: Void? = nil) {
////        self.navigator.rxBack()
////            .subscribe(onCompleted: { [weak self] in
////                guard let `self` = self else { return }
////                self.callback?.onNext("abc123")
////                self.callback?.onCompleted()
////            })
////            .disposed(by: self.disposeBag)
//    }

}

extension TestViewController: WKNavigationDelegate {

    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
        guard let string = navigationAction.request.url?.absoluteString else {
            decisionHandler(.allow)
            return
        }
        if string == "about:blank" {
            decisionHandler(.allow)
            return
        }
        guard (navigationAction.request.url?.absoluteString.urlDecoded) != nil else {
            decisionHandler(.allow)
            return
        }
//        if url.hasPrefix("about:blank#") {
//            url = string.removingPrefix("about:blank#")
//            if url.count != 0 {
//                log("描点位置：\(url)")
//            }
//        }
//        log("网页地址: \(string)")
//        self.clickSubject.onNext(string)
        decisionHandler(.cancel)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript(
            "document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'",
            completionHandler: nil
        )
    }

}
