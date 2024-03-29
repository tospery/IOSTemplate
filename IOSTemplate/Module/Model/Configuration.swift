//
//  Configuration.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import URLNavigator_Hi
import Rswift
import HiIOS
import ReusableKit_Hi
import ObjectMapper_Hi

struct Configuration: ConfigurationType, Subjective, Eventable {
    
    enum Event {
    }
    
    var id = ""
    var localization = Localization.system
    var trendingLanguage: Language? = Language.any
    var trendingSince = Since.daily
    
    init() {
    }

    init(id: String) {
        self.id = id
    }
    
    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        id                  <- map["id"]
        localization        <- map["localization"]
        trendingLanguage    <- map["trendingLanguage"]
        trendingSince       <- map["trendingSince"]
    }
    
}
