//
//  Constant.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/12/23.
//

import UIKit
import HiCore
import HiBase
import Domain
import HiSwiftUI

let environment: [String: Any] = [
    Parameter.osType: UIDevice.current.systemName,
    Parameter.osVersion: UIDevice.current.systemVersion,
    Parameter.deviceId: UIDevice.current.uuid,
    Parameter.deviceModel: UIDevice.current.deviceModel,
    Parameter.appId: UIApplication.shared.bundleIdentifier,
    Parameter.appVersion: UIApplication.shared.version,
    Parameter.appChannel: UIApplication.shared.channel
]
