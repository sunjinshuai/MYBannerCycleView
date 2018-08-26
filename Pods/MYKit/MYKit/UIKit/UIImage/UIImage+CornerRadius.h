//
//  UIImage+CornerRadius.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2018/3/14.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CornerRadius)

/**
 将图片进行圆角处理，默认无边框(此操作是线程安全的)。
 @param radius 圆角大小
 @param newSize 图片将会缩放成的目标大小
 @return 返回处理之后的图片
 */
- (nullable UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                                     scaleSize:(CGSize)newSize;

/**
 将图片进行圆角处理，并加上边框(此操作是线程安全的)。
 @param radius 圆角大小
 @param newSize 图片将会缩放成的目标大小
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 @return 返回处理之后的图片
 */
- (nullable UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                                     scaleSize:(CGSize)newSize
                                   borderWidth:(CGFloat)borderWidth
                                   borderColor:(nullable UIColor *)borderColor;

/**
 图片加上圆形边框，图片必须得是正方形的，否则直接返回未加边框的原图片(此操作是线程安全的)
 @param color 边框颜色
 @param width 边框宽度
 @return 返回处理之后的图片
 */
- (nullable UIImage *)imageByRoundBorderedColor:(nullable UIColor *)color
                                    borderWidth:(CGFloat)width;

/**
 创建一张纯色的圆形图片
 @param color 图片填充的颜色
 @param radius 圆形图片的半径
 @return 返回纯色的圆形图片
 */
+ (nullable UIImage *)roundImageWithColor:(nullable UIColor *)color
                                   radius:(CGFloat)radius;

@end
