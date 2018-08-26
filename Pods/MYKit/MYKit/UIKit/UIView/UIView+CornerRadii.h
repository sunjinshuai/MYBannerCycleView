//
//  UIView+CornerRadii.h
//  LPDCrowdsource
//
//  Created by eMr.Wang on 16/1/29.
//  Copyright © 2016年 elm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CornerRadii)

/**
 快速切圆角，带边框、边框颜色
 
 @param roundingCorners 圆角样式
 @param cornerRadii 圆角角度
 */
- (void)setCornerRadii:(CGFloat)cornerRadii
       roundingCorners:(UIRectCorner)roundingCorners;

/**
 快速切圆角，带边框、边框颜色
 
 @param roundingCorners 圆角样式
 @param cornerRadii 圆角角度
 @param borderWidth 边线宽度
 @param borderColor 边线颜色
 */
- (void)setCornerRadii:(CGFloat)cornerRadii
       roundingCorners:(UIRectCorner)roundingCorners
           borderWidth:(CGFloat)borderWidth
           borderColor:(UIColor *)borderColor;

@end

NS_ASSUME_NONNULL_END
