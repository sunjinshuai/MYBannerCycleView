//
//  NSNumber+Round.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/28.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Round)

/* 展示 */
- (NSString *)toDisplayNumberWithDigit:(NSInteger)digit;
- (NSString *)toDisplayPercentageWithDigit:(NSInteger)digit;

/*　四舍五入 */
/**
 *  @brief  四舍五入
 *
 *  @param digit  限制最大位数
 *
 *  @return 结果
 */
- (NSNumber *)doRoundWithDigit:(NSUInteger)digit;
/**
 *  @brief  取上整
 *
 *  @param digit  限制最大位数
 *
 *  @return 结果
 */
- (NSNumber *)doCeilWithDigit:(NSUInteger)digit;
/**
 *  @brief  取下整
 *
 *  @param digit  限制最大位数
 *
 *  @return 结果
 */
- (NSNumber *)doFloorWithDigit:(NSUInteger)digit;

/**
 *  将当前金额数值转成中文繁体金额
 *  1234567890.31 <=> 壹拾貳億叁仟肆佰伍拾陸萬柒仟捌佰玖拾圓叁角壹分
 */
- (NSString *)traditionalMoneyString;

@end
