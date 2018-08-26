//
//  NSDictionary+SafeAccess.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/27.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDictionary (SafeAccess)

- (BOOL)hasKey:(NSString *)key;

- (NSString *)stringForKey:(id)key;

- (NSNumber *)numberForKey:(id)key;

- (NSDecimalNumber *)decimalNumberForKey:(id)key;

- (NSArray *)arrayForKey:(id)key;

- (NSDictionary*)dictionaryForKey:(id)key;

- (NSInteger)integerForKey:(id)key;

- (NSUInteger)unsignedIntegerForKey:(id)key;

- (BOOL)boolForKey:(id)key;

- (int16_t)int16ForKey:(id)key;

- (int32_t)int32ForKey:(id)key;

- (int64_t)int64ForKey:(id)key;

- (char)charForKey:(id)key;

- (short)shortForKey:(id)key;

- (float)floatForKey:(id)key;

- (double)doubleForKey:(id)key;

- (long)longForKey:(id)key;

- (long long)longLongForKey:(id)key;

- (unsigned long long)unsignedLongLongForKey:(id)key;

- (id)getValueForKey:(NSString *)key;

- (NSDate *)dateForKey:(id)key dateFormat:(NSString *)dateFormat;

- (CGFloat)CGFloatForKey:(id)key;

- (CGPoint)pointForKey:(id)key;

- (CGSize)sizeForKey:(id)key;

- (CGRect)rectForKey:(id)key;

@end
