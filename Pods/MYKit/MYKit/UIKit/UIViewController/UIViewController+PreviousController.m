//
//  UIViewController+PreviousController.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2018/3/14.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "UIViewController+PreviousController.h"
#import <objc/runtime.h>

@implementation UIViewController (PreviousController)

- (UIViewController *)previousController {
    UIViewController *sourcePageController = objc_getAssociatedObject(self, @selector(previousController));
    if (!sourcePageController) {
        if (self.navigationController && self.navigationController.viewControllers.count > 1) {
            NSInteger controllerCount = self.navigationController.viewControllers.count;
            sourcePageController = self.navigationController.viewControllers[controllerCount - 2];
        }
        if (!sourcePageController) {
            if (self.presentingViewController) {
                sourcePageController = self.presentingViewController;
            }
        }
        
        while ([sourcePageController isKindOfClass:[UINavigationController class]] || [sourcePageController isKindOfClass:[UITabBarController class]]) {
            if ([sourcePageController isKindOfClass:[UINavigationController class]]) {
                sourcePageController = ((UINavigationController *)sourcePageController).viewControllers.lastObject;
                if ([sourcePageController isKindOfClass:[UITabBarController class]]) {
                    sourcePageController = ((UITabBarController *)sourcePageController).selectedViewController;
                }
            }
            if ([sourcePageController isKindOfClass:[UITabBarController class]]) {
                sourcePageController = ((UITabBarController *)sourcePageController).selectedViewController;
                
                if ([sourcePageController isKindOfClass:[UINavigationController class]]) {
                    sourcePageController = ((UINavigationController *)sourcePageController).viewControllers.lastObject;
                }
            }
        }
        
        if (sourcePageController) {
            objc_setAssociatedObject(self, @selector(previousController), sourcePageController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    return sourcePageController;
}

@end
