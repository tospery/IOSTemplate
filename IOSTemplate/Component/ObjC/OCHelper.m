//
//  OCHelper.m
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/3/2.
//

#import "OCHelper.h"

@interface OCHelper ()
#ifdef ALIYUN_ENABLE
@property (nonatomic, strong, readwrite) YWFeedbackKit *feedbackKit;
#endif

@end

@implementation OCHelper

#ifdef ALIYUN_ENABLE
- (YWFeedbackKit *)feedbackKit {
    if (!_feedbackKit) {
        _feedbackKit = [[YWFeedbackKit alloc] initWithAppKey:@"335281669" appSecret:@"199bee5c911c4c4da9802382a36ab850"];
    }
    return _feedbackKit;
}
#endif

#pragma mark - 类方法
+ (instancetype)sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

@end
