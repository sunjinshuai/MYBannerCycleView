//
//  UIViewController+PageViewLevel.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2018/3/14.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (PageViewLevel)

/**
 从0开始,记录真实的页面层级不受
 UITabBarController,
 UINavigationController包含关系影响
 */
@property (nonatomic, readonly) NSInteger pageViewLevel;

@end
