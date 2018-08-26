//
//  NSArray+SafeAccess.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/9/8.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSArray (SafeAccess)

/*!
 @method objectWithIndex:
 @abstract 检查是否越界和NSNull如果是返回nil
 @result 返回对象
 */
- (id)objectWithIndex:(NSUInteger)index;

- (NSString *)stringWithIndex:(NSUInteger)index;

- (NSNumber *)numberWithIndex:(NSUInteger)index;

- (NSDecimalNumber *)decimalNumberWithIndex:(NSUInteger)index;

- (NSArray *)arrayWithIndex:(NSUInteger)index;

- (NSDictionary *)dictionaryWithIndex:(NSUInteger)index;

- (NSInteger)integerWithIndex:(NSUInteger)index;

- (NSUInteger)unsignedIntegerWithIndex:(NSUInteger)index;

- (BOOL)boolWithIndex:(NSUInteger)index;

- (int16_t)int16WithIndex:(NSUInteger)index;

- (int32_t)int32WithIndex:(NSUInteger)index;

- (int64_t)int64WithIndex:(NSUInteger)index;

- (char)charWithIndex:(NSUInteger)index;

- (short)shortWithIndex:(NSUInteger)index;

- (float)floatWithIndex:(NSUInteger)index;

- (double)doubleWithIndex:(NSUInteger)index;

- (NSDate *)dateWithIndex:(NSUInteger)index dateFormat:(NSString *)dateFormat;

- (CGFloat)my_floatWithIndex:(NSUInteger)index;

- (CGPoint)my_pointWithIndex:(NSUInteger)index;

- (CGSize)my_sizeWithIndex:(NSUInteger)index;

- (CGRect)my_rectWithIndex:(NSUInteger)index;

@end

