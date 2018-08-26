//
//  NSBundle+AppIcon.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/9/8.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "NSBundle+AppIcon.h"

@implementation NSBundle (AppIcon)

+ (UIImage *)appIcon {
    NSDictionary *infoPlist = [[self mainBundle] infoDictionary];
    NSString *appIcon = [[infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
    return [UIImage imageNamed:appIcon];
}

+ (NSArray *)getAllLaunchImageInfo {
    NSDictionary *infoDict = [[self mainBundle] infoDictionary];
    // 获取所有启动图片信息数组
    NSArray *launchImagesArray = infoDict[@"UILaunchImages"];
    return launchImagesArray;
}

@end
