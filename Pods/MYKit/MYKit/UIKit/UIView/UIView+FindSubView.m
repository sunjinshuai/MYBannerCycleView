//
//  UIView+FindSubView.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/11/18.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "UIView+FindSubView.h"

@implementation UIView (FindSubView)

+ (BOOL)intersectsWithOtherView:(UIView *)otherView anotherView:(UIView *)anotherView {
    // 先转换为相对于窗口的坐标，然后进行判断是否重合
    CGRect selfRect = [otherView convertRect:otherView.bounds toView:nil];
    CGRect viewRect = [anotherView convertRect:anotherView.bounds toView:nil];
    return CGRectIntersectsRect(selfRect, viewRect);
}

- (BOOL)intersectsWithView:(UIView *)view {
    // 先转换为相对于窗口的坐标，然后进行判断是否重合
    CGRect selfRect = [self convertRect:self.bounds toView:nil];
    CGRect viewRect = [view convertRect:view.bounds toView:nil];
    return CGRectIntersectsRect(selfRect, viewRect);
}

- (NSArray *)subviewsWithClass:(Class)cls {
    NSMutableArray *subviews = [NSMutableArray array];
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:cls]) {
            [subviews addObject:subview];
            [subviews addObjectsFromArray:[subview subviewsWithClass:cls]];
        }
    }
    return subviews;
}

@end
