//
//  String+Ex.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/11/14.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import SwifterSwift
import HiBase
import HiLog
import HiSwiftUI

extension String {
    
//    var fileType: String? {
//        guard let ext = self.fileExt?.lowercased() else { return nil }
//        var type = ext
//        if ["sh"].contains(ext) {
//            type = "shell"
//        } else if ["h", "m"].contains(ext) {
//            type = "objectivec"
//        } else if ["md", "mdx"].contains(ext) {
//            type = "markdown"
//        } else if ["js", "cjs"].contains(ext) {
//            type = "javascript"
//        } else if ["ts"].contains(ext) {
//            type = "typescript"
//        } else if ["pl", "pm"].contains(ext) {
//            type = "perl"
//        } else if ["yml"].contains(ext) {
//            type = "yaml"
//        } else if ["kt"].contains(ext) {
//            type = "kotlin"
//        } else if ["resolved", "jsonc"].contains(ext) {
//            type = "json"
//        } else if ["txt"].contains(ext) {
//            type = "plaintext"
//        } else if ["xml", "plist"].contains(ext) {
//            type = "xml"
//        } else if ["htm", "mht", "asp"].contains(ext) {
//            type = "html"
//        } else if ["hh", "hp", "hxx", "hpp", "h++", "tcc", "c", "cc", "cp", "cxx", "c++"].contains(ext) {
//            type = "cpp"
//        } else if [
//            "py", "py3", "pyc", "pyo", "pyd", "pyi", "pyx", "pyz", "pywz", "rpy", "pyde", "pyp", "pyt"
//        ].contains(ext) {
//            type = "python"
//        } else if ["rake", "rakefile", "gem", "gemspec", "bundler", "bundle", "gemfile", "gitignore"].contains(ext) {
//            type = "ruby"
//        } else {
//            type = ext
//        }
//        return type
//    }
    
    var isIssuesURLString: Bool { self.url?.pathComponents.last?.lowercased() == "issues" }
    
    var isPullsURLString: Bool { self.url?.pathComponents.last?.lowercased() == "pulls" }
    
//    var decorateURLStringForRaw: String {
//        guard let url = self.url else { return self }
//        return url.myAppendingQueryParameters([Parameter.raw: true.string]).absoluteString
//    }
//    
//    var decorateURLStringForApi: String {
//        guard self.starts(with: UIApplication.shared.baseApiUrl) else { return self }
//        let result = self.removingPrefix(UIApplication.shared.baseApiUrl)
//        return "\(UIApplication.shared.baseApiUrl)/repos\(result)"
//    }
//    
//    var dateAgo: String {
//        guard let date = Date.init(iso8601: self) else { return self }
//        return R.string(bundle: .localizedBundle ?? .main).localizable.latestUpdate(
//            date.timeAgoSinceNow
//        )
//    }
//    
//    var dateShort: String {
//        guard let date = Date.init(iso8601: self) else { return self }
//        return date.string(withFormat: "yyyy-MM-dd")
//    }
//    
//    var dateMiddle: String {
//        guard let date = Date.init(iso8601: self) else { return self }
//        return date.string(withFormat: "yyyy-MM-dd HH:mm")
//    }
//    
//    var dateFull: String {
//        guard let date = Date.init(iso8601: self) else { return self }
//        return date.string(withFormat: "yyyy-MM-dd HH:mm:ss")
//    }
//    
//    var baseURLStringFromMarkdown: String {
//        guard self.isValidMarkdownUrl else { return "" }
//        guard let url = self.url else { return "" }
//        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return "" }
//        components.query = nil
//        components.path = components.path.deletingLastPathComponent
//        return components.url?.absoluteString ?? ""
//    }
    
//    // swiftlint:disable cyclomatic_complexity function_body_length
//    func adjustHTMLContent(_ base: String) -> String {
//        var urlString = base
//        if let lastChar = urlString.last, lastChar != "/" {
//            urlString += "/"
//        }
//        log("html base url: \(urlString)")
//        guard let baseURL = urlString.url else { return self }
//        guard let document = try? SwiftSoup.parse(self, urlString) else { return self }
//        do {
//            // 1. body
//            let body = document.body()
//            try body?.attr("style", "-webkit-text-size-adjust: 100%;")
//            
//            // 2. img
//            let value = "max-width: 100%;"
//            let images = try document.select("img")
//            for img in images {
//                let style = try img.attr("style")
//                if !style.contains(value) {
//                    try img.attr("style", value)
//                }
//                if let src = try? img.attr("src"), src.isNotEmpty {
//                    if src.isValidWebUrl {
//                        if src.starts(with: UIApplication.shared.baseWebUrl),
//                           src.isValidImageUrl,
//                           !(src.url?.queryValue(for: Parameter.raw)?.bool ?? false) {
//                            let urlString = src.url?.myAppendingQueryParameters([Parameter.raw: true.string])
//                                .absoluteString ?? src
//                            try img.attr("src", urlString)
//                        }
//                    } else {
//                        if src.isValidImageUrl {
//                            let pathURL = src.removingPrefix("/")
//                            guard var absoluteURL = URL(string: pathURL, relativeTo: baseURL) else { continue }
//                            absoluteURL = absoluteURL.myAppendingQueryParameters([Parameter.raw: true.string])
//                            try img.attr("src", absoluteURL.absoluteString)
//                        }
//                    }
//                }
//            }
//            
//            // 3. a
//            let links = try document.select("a")
//            for link in links {
//                if let href = try? link.attr("href") {
//                    if href.isValidImageUrl && !(href.isValidHttpUrl || href.isValidHttpsUrl) {
//                        let pathURL = href.removingPrefix("/")
//                        guard var absoluteURL = URL(string: pathURL, relativeTo: baseURL) else { continue }
//                        absoluteURL = absoluteURL.myAppendingQueryParameters([Parameter.raw: true.string])
//                        try link.attr("href", absoluteURL.absoluteString)
//                    }
//                }
//            }
//            
//            // 4. pre
//            let pres = try document.select("pre")
//            for pre in pres {
//                let div = try document.createElement("div")
//                try div.addClass("snippet-clipboard-content notranslate position-relative overflow-auto")
//                try div.attr("style", "max-width: 100%; overflow: auto; background-color: #F5F5F5;")
//                let code = try pre.select("code").first()?.text() ?? ""
//                try div.attr("data-snippet-clipboard-copy-content", code)
//                try pre.wrap(div.outerHtml())
//            }
//            
//            // 5. table
//            let tables = try document.select("table")
//            for table in tables {
//                try table.attr("style", "border-collapse: collapse; width: 100%;")
//                for tag in ["thead", "tbody", "tr", "td"] {
//                    let elements = try table.select(tag)
//                    for element in elements {
//                        try element.attr("style", "border: 1px solid lightgrey; padding: 8px;")
//                    }
//                }
//            }
//            
//            // 6. video
//            let videos = try document.select("video")
//            try videos.forEach { video in
//                try video.attr("style", "max-height:120px; min-height:40px;")
//                try video.attr("controls", "controls")
//            }
//            
//            // 7. source
//            let sources = try document.select("source")
//            for source in sources {
//                if let srcset = try? source.attr("srcset"), srcset.isNotEmpty {
//                    if srcset.isValidWebUrl {
//                        if srcset.starts(with: UIApplication.shared.baseWebUrl),
//                           srcset.isValidImageUrl,
//                           !(srcset.url?.queryValue(for: Parameter.raw)?.bool ?? false) {
//                            let urlString = srcset.url?.myAppendingQueryParameters([Parameter.raw: true.string])
//                                .absoluteString ?? srcset
//                            try source.attr("srcset", urlString)
//                        }
//                    } else {
//                        if srcset.isValidImageUrl {
//                            let pathURL = srcset.removingPrefix("/")
//                            guard var absoluteURL = URL(string: pathURL, relativeTo: baseURL) else { continue }
//                            absoluteURL = absoluteURL.myAppendingQueryParameters([Parameter.raw: true.string])
//                            try source.attr("srcset", absoluteURL.absoluteString)
//                        }
//                    }
//                }
//            }
//            
//            let htmlString = try document.outerHtml()
//            log("调整后的html: \n\(htmlString)")
//            return htmlString
//        } catch {
//            stats(.optimizeHTMLFail(urlString: urlString))
//            return self
//        }
//    }
//    // swiftlint:enable cyclomatic_complexity function_body_length
}
