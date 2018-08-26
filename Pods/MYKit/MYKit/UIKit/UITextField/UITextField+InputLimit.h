//
//  UITextField+InputLimit.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/9/7.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (InputLimit)

@property (nonatomic, assign) NSInteger maxLength;//if <=0, no limit

@end

