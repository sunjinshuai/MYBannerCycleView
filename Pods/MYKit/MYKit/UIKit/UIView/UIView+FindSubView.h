//
//  UIView+FindSubView.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/11/18.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FindSubView)

/**
 *  判断两个view是否重叠
 */
+ (BOOL)intersectsWithOtherView:(UIView *)otherView anotherView:(UIView *)anotherView;

/**
 *  @brief find all subviews
 *
 *  @param cls class of subview
 */
- (NSArray *)subviewsWithClass:(Class)cls;

/**
 *  判断self和view是否重叠
 */
- (BOOL)intersectsWithView:(UIView *)view;

@end
