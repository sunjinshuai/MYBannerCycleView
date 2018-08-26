//
//  UILabel+LimitLines.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/7.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 此分类适合Label文本指定的行数，行间距等
 */
@interface UILabel (LimitLines)

/**
 最大显示宽度，如果没有设置最大宽度，默认是window的宽度
 */
@property (nonatomic, assign) CGFloat myConstrainedWidth;

/**
 行间距，默认为0
 */
@property (nonatomic, assign) CGFloat myLineSpacing;

/**
 文本限制指定的行数
 @return 文本是否限制几行
 */
- (BOOL)my_adjustTextToFitLines:(NSInteger)numberOfLines;

@end
