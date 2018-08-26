//
//  NSBundle+AppIcon.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/9/8.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSBundle (AppIcon)

/**
 获取app的icon图标

 @return icon图标
 */
+ (UIImage *)appIcon;

/**
 打印app里面所有启动图片名称信息

 @return 启动图片名称信息数组
 */
+ (NSArray *)getAllLaunchImageInfo;

@end
