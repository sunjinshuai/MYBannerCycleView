//
//  UINavigationBar+Addition.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2018/3/22.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Addition)

/**
 设置导航栏所有BarButtonItem的透明度
 */
- (void)setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator;

/**
 设置Bar偏移
 @param translationY 偏移量
 */
- (void)setTranslationY:(CGFloat)translationY;

/**
 获取当前导航栏在垂直方向上偏移了多少
 */
- (CGFloat)getTranslationY;

/**
 * 隐藏导航栏下面的分割线
 */
- (void)hideBottomHairline;

/**
 * 显示导航栏下面的分割线
 */
- (void)showBottomHairline;

@end
