//
//  Function.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/10/15.
//

import SwiftUI
import HiLog
import HiSwiftUI

func aliyunUnreadCountFeedback() async -> Int {
    await withCheckedContinuation { continuation in
#if ALIYUN_ENABLE
        OCHelper.sharedInstance().feedbackKit.getUnreadCount { count, error in
            if error != nil {
                continuation.resume(returning: 0)
            } else {
                continuation.resume(returning: count)
            }
        }
#else
        continuation.resume(returning: 0)
#endif
    }
}
