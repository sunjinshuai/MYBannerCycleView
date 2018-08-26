//
//  UIView+Badge.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/12/29.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Badge)

/**
 *  @brief 是否显示badge
 */
@property (nonatomic, assign) BOOL shouldShowBadge;

/**
 *  @brief badge内容，为空则显示小红点
 */
@property (nonatomic, copy) NSString *badgeString;

@property (nonatomic, strong) UILabel *badgeLabel;


/**
 *  @brief 配置badge，参数UIView didMoveToSuperview
 */
@property (nonatomic, copy, nullable) void (^badgeConfigBlock)(UIView *);

@end

NS_ASSUME_NONNULL_END
