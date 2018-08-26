//
//  UIColor+Addition.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/9/6.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Addition)

/**
 Return a randomColor (just for test UI)
 
 @return randomColor
 */
+ (UIColor *)randomColor;

/**
 *  @brief get color from hex string
 *
 *  @param hexStr #RGB #ARGB #RRGGBB #AARRGGBB
 *
 *  @return color
 */
+ (UIColor *)colorWithHexString:(NSString *)hexStr;
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alphaValue;

@end
