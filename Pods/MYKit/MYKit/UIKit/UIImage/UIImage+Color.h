//
//  UIImage+Color.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/9/6.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

/**
 *  @brief  取图片某一点的颜色
 *
 *  @param point 某一点
 *
 *  @return 颜色
 */
- (UIColor *)colorAtPoint:(CGPoint)point;

/**
 *  @brief  取某一像素的颜色
 *
 *  @param point 一像素
 *
 *  @return 颜色
 */
- (UIColor *)colorAtPixel:(CGPoint)point;

/**
 *  @brief  返回该图片是否有透明度通道
 *
 *  @return 是否有透明度通道
 */
- (BOOL)hasAlphaChannel;

/**
 *  @brief  获得灰度图
 *
 *  @param sourceImage 图片
 *
 *  @return 获得灰度图片
 */
+ (UIImage *)covertToGrayImageFromImage:(UIImage *)sourceImage;

/**
 *  @brief  根据颜色生成图片，默认size为{1.f, 1.f}
 *  @param color 传入颜色
 *  @return 返回图片
 */
+ (UIImage *)createImageWithColor:(UIColor *)color;

/**
 *  @brief 设置图片的透明度
 *  @param alpha 透明度
 *  @return 返回处理后的图片
 */
- (UIImage *)imageWithAlpha:(CGFloat)alpha;

/**
 *  @brief 设置图片的size
 *  @return 返回改变size之后的图片
 */
- (UIImage *)resizeTo:(CGSize)size;

@end
