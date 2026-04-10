//
//  OCHelper.h
//  WillHub
//
//  Created by 杨建祥 on 2024/10/15.
//

#import <UIKit/UIKit.h>
#ifdef ALIYUN_ENABLE
#import <YWFeedbackFMWK/YWFeedbackKit.h>
#import <YWFeedbackFMWK/YWFeedbackViewController.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface OCHelper : NSObject
#ifdef ALIYUN_ENABLE
@property (nonatomic, strong, readonly) YWFeedbackKit *feedbackKit;
#endif

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
