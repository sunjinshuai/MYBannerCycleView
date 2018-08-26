//
//  UILabel+CountDown.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/9/6.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (CountDown)

/**
 倒计时
 
 @param timeInterval 倒计时时长
 @param text 倒计时内容
 @param completion 倒计时之后回调
 */
- (void)scheduledTimerWithTimeInterval:(NSInteger)timeInterval
                        countDownText:(NSString *)text
                            completion:(void (^)(UILabel *countDownLabel))completion;

@end
