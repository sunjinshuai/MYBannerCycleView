//
//  UIViewController+ClassName.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2018/3/23.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "UIViewController+ClassName.h"
#import "UIDevice+Addition.h"
#import "UIView+Position.h"
#import "NSObject+Swizzle.h"

#define kClassNameTag 20000

static BOOL displayClassName = NO;

@implementation UIViewController (ClassName)

+ (void)displayClassName:(BOOL)yesOrNo {
    displayClassName = yesOrNo;
    if (displayClassName) {
        [self displayClassName];
    } else {
        [self removeClassName];
    }
}

+ (void)load {
    
    [self instanceSwizzleMethod:@selector(yn_viewDidAppear:) replaceMethod:@selector(viewDidAppear:)];
}

#pragma mark - Method Swizzling

- (void)yn_viewDidAppear:(BOOL)animated {
    [self yn_viewDidAppear:animated];
    
    if (displayClassName) {
        [[self class] displayClassName];
    }
}

+ (void)displayClassName {
    UIWindow *window = [self appWindow];
    if (!window) {
        window = [UIApplication sharedApplication].keyWindow;
    }
    UILabel *classNameLabel = nil;
    if ([window viewWithTag:kClassNameTag]) {
        classNameLabel = (UILabel *)[window viewWithTag:kClassNameTag];
        [window bringSubviewToFront:classNameLabel];
    } else {
        classNameLabel = [[UILabel alloc] init];
        classNameLabel.frame = CGRectMake(5, 15 + ([UIDevice isIphoneX] ? 20 : 0), window.width, 20);
        classNameLabel.textColor = [UIColor redColor];
        classNameLabel.font = [UIFont systemFontOfSize:12];
        classNameLabel.tag = kClassNameTag;
        [window addSubview:classNameLabel];
        [window bringSubviewToFront:classNameLabel];
    }
    
    classNameLabel.userInteractionEnabled = NO;
    
    const char *className = class_getName(self.class);
    NSString *classNameStr = [NSString stringWithCString:className encoding:NSUTF8StringEncoding];
    
    if ([self needDisplay:classNameStr]) {
        [classNameLabel setText:classNameStr];
    }
}

+ (void)removeClassName {
    UIWindow *window = [self appWindow];
    if (!window) {
        window = [UIApplication sharedApplication].keyWindow;
    }
    UILabel *classNameLabel = nil;
    if ([window viewWithTag:kClassNameTag]) {
        classNameLabel = (UILabel *)[window viewWithTag:kClassNameTag];
        [classNameLabel removeFromSuperview];
    }
}

+ (BOOL)needDisplay:(NSString *)className {
    if ([className isEqualToString:@"UIInputWindowController"] || [className isEqualToString:@"UINavigationController"] || [className isEqualToString:@"UIApplicationRotationFollowingControllerNoTouches"]) {
        return NO;
    } else if ([NSClassFromString(className) isSubclassOfClass:[UIInputViewController class]]) {    // 输入类controller
        return NO;
    } else {
        return YES;
    }
}

+ (UIWindow *)appWindow {
    id<UIApplicationDelegate> appDelegate = [UIApplication sharedApplication].delegate;
    return [appDelegate window];
}

@end
