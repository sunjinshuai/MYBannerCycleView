//
//  UIImage+Addition.h
//  FXKitExampleDemo
//
//  Created by sunjinshuai on 2017/7/19.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Addition)

/**
 *  @brief 根据name获取GIF图片
 *
 *  @param name 图片名称
 *
 *  @return 返回处理后的图片
 */
+ (nullable UIImage *)animatedGIFNamed:(NSString *)name;

/**
 *  @brief 根据data获取GIF图片
 *
 *  @param data 图片数据流
 *
 *  @return 返回处理后的图片
 */
+ (nullable UIImage *)animatedGIFWithData:(NSData *)data;

/**
 *  @brief 根据图片路径获取图片
 *
 *  @param imageName 图片路径名称
 *
 *  @return 返回处理后的图片
 */
+ (nullable UIImage *)imageNoCacheWithName:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END

