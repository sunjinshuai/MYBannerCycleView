//
//  UILabel+CountDown.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/9/6.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "UILabel+CountDown.h"

@implementation UILabel (CountDown)

- (void)scheduledTimerWithTimeInterval:(NSInteger)timeInterval
                         countDownText:(NSString *)text
                            completion:(void (^)(UILabel *countDownLabel))completion {
    // 倒计时时间
    __block NSInteger timeOut = timeInterval;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    // 每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        // 倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.userInteractionEnabled = YES;
                if (completion) {
                    completion(self);
                }
            });
        } else {
            int allTime = (int)timeInterval + 1;
            int timeInterval = timeOut % allTime;
            NSString *timeStr = [NSString stringWithFormat:@"%d", timeInterval];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setText:[NSString stringWithFormat:@"%@%@", timeStr, text]];
                self.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });

    dispatch_resume(_timer);
}

@end
