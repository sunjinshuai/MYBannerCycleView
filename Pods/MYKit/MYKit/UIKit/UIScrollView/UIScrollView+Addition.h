//
//  UIScrollView+Addition.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/12/29.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Addition)

/**
 *  @brief  get contentOffset.x
 */
@property (nonatomic) CGFloat contentOffsetX;

/**
 *  @brief  get contentOffset.y
 */
@property (nonatomic) CGFloat contentOffsetY;

/**
 *  @brief  get contentSize.width
 */
@property (nonatomic) CGFloat contentSizeWidth;

/**
 *  @brief  get contentSize.height
 */
@property (nonatomic) CGFloat contentSizeHeight;

/**
 *  @brief  get contentInset.top
 */
@property (nonatomic) CGFloat contentInsetTop;

/**
 *  @brief  get contentInset.left
 */
@property (nonatomic) CGFloat contentInsetLeft;

/**
 *  @brief  get contentInset.bottom
 */
@property (nonatomic) CGFloat contentInsetBottom;

/**
 *  @brief  get contentInset.right
 */
@property (nonatomic) CGFloat contentInsetRight;

@end
