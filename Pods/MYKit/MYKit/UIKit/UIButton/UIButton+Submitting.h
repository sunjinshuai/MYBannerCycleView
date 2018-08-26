//
//  UIButton+Submitting.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/28.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//  https://github.com/foxsofter/FXCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  @author foxsofter, 15-09-24 10:09:49
 *
 *  @brief  为UIButton添加提交状态，通过ActivityIndicator表示
 */
@interface UIButton (Submitting)

/**
 *  @brief  按钮点击后，禁用按钮并居中显示ActivityIndicator
 */
- (void)beginSubmitting;

/**
 *  @brief  按钮点击后，禁用按钮并在按钮上显示ActivityIndicator，以及title
 *
 *  @param title 按钮上显示的文字
 */
- (void)beginSubmitting:(NSString * _Nullable)title;

/**
 *  @brief  按钮点击后，恢复按钮点击前的状态
 */
- (void)endSubmitting;

/**
 *  @brief  按钮是否正在提交中
 */
@property (nonatomic, readonly, getter=isSubmitting) BOOL submitting;

@end

NS_ASSUME_NONNULL_END
