//
//  NSString+Size.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/9/7.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Size)

/**
 简单计算文本占据的size
 */
- (CGSize)textSizeWithFont:(UIFont *)font;

/**
 *  计算文本占用的宽高
 *
 *  @param font    显示的字体
 *  @param maxSize 最大的显示范围
 *
 *  @return 占用的宽高
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

/**
 根据字体、行数、行间距和constrainedWidth计算文本占据的size
 @param font 字体
 @param numberOfLines 显示文本行数，值为0不限制行数
 @param lineSpacing 行间距
 @param constrainedWidth 文本受限的宽度
 @param isLimitedToLines 记录文本是否被numberOfLines限制
 @return 返回文本占据的size
 */
- (CGSize)textSizeWithFont:(UIFont *)font
             numberOfLines:(NSInteger)numberOfLines
               lineSpacing:(CGFloat)lineSpacing
          constrainedWidth:(CGFloat)constrainedWidth
          isLimitedToLines:(BOOL * _Nonnull)isLimitedToLines;

/**
 * 计算文字高度，可以处理计算带行间距的等属性
 */
- (CGSize)boundingRectWithSize:(CGSize)size
                paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle
                          font:(UIFont *)font;
/**
 * 计算文字高度，可以处理计算带行间距的
 */
- (CGSize)boundingRectWithSize:(CGSize)size
                          font:(UIFont*)font
                   lineSpacing:(CGFloat)lineSpacing;
/**
 * 计算最大行数文字高度，可以处理计算带行间距的
 */
- (CGFloat)boundingRectWithSize:(CGSize)size
                           font:(UIFont *)font
                    lineSpacing:(CGFloat)lineSpacing
                       maxLines:(NSInteger)maxLines;

/**
 *  计算是否超过一行
 */
- (BOOL)isMoreThanOneLineWithSize:(CGSize)size
                             font:(UIFont *)font
                     lineSpaceing:(CGFloat)lineSpacing;

@end

NS_ASSUME_NONNULL_END
