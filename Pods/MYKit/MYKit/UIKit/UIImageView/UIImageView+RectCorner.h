//
//  UIImageView+RectCorner.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2018/3/20.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (RectCorner)

- (instancetype)initWithCornerRadiusAdvance:(CGFloat)cornerRadius
                             rectCornerType:(UIRectCorner)rectCornerType;

- (void)cornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType;

- (instancetype)initWithRoundingRectImageView;

- (void)cornerRadiusRoundingRect;

- (void)attachBorderWidth:(CGFloat)width color:(UIColor *)color;

@end
