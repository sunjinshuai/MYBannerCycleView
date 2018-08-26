//
//  UIView+CustomBorder.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/9/6.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MYUIViewBorderType) {
    MYUIViewBorderTypeSolid,
    MYUIViewBorderTypeDashed,
    MYUIViewBorderTypeDoted
};

typedef NS_OPTIONS(NSUInteger, MYUIViewBorderPosition) {
    MYUIViewBorderPositionNone = 0,
    MYUIViewBorderPositionTop = 1 << 0,
    MYUIViewBorderPositionRight = 1 << 1,
    MYUIViewBorderPositionBottom = 1 << 2,
    MYUIViewBorderPositionLeft = 1 << 3,
};

@interface UIView (CustomBorder)

- (CAShapeLayer *)borderLayer;

/**
 *  @brief  设置UIView的border,绘制所有border
 *
 *  @param borderWidth borderWidth
 *  @param borderColor borderColor
 */
- (void)setBorder:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 *  @brief  设置UIView的border，根据borderPosition设置对应的border
 *
 *  @param borderWidth    borderWidth
 *  @param borderColor    borderColor
 *  @param borderPosition borderPosition
 */
- (void)setBorder:(CGFloat)borderWidth
      borderColor:(UIColor *)borderColor
   borderPosition:(MYUIViewBorderPosition)borderPosition;

/**
 *  @brief  设置UIView的border,根据borderType绘制所有border
 *
 *  @param borderWidth borderWidth
 *  @param borderColor borderColor
 *  @param borderType  borderType
 */
- (void)setBorder:(CGFloat)borderWidth borderColor:(UIColor *)borderColor borderType:(MYUIViewBorderType)borderType;

/**
 *  @brief  设置UIView的border,根据borderType和borderPosition绘制border
 *
 *  @param borderWidth    borderWidth
 *  @param borderColor    borderColor
 *  @param borderPosition borderPosition
 *  @param borderType     borderType
 */
- (void)setBorder:(CGFloat)borderWidth
      borderColor:(UIColor *)borderColor
   borderPosition:(MYUIViewBorderPosition)borderPosition
       borderType:(MYUIViewBorderType)borderType;

- (void)setLineDashPattern:(NSArray<NSNumber *> *)lineDashPattern;

@end
