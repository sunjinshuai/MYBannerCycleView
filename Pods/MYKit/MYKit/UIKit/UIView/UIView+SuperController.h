//
//  UIView+SuperController.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/9/6.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SuperController)

+ (UIViewController *)viewController:(UIView *)view;
+ (UINavigationController *)navigationController:(UIView *)view;
- (UIViewController *)viewController;
- (UINavigationController *)navigationController;

@end
