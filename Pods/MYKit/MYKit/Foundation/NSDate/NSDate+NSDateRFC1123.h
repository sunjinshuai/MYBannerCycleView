//
//  NSDate+NSDateRFC1123.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/11/18.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (NSDateRFC1123)

/**
 Convert a RFC1123 'Full-Date' string
 (http://www.w3.org/Protocols/rfc2616/rfc2616-sec3.html#sec3.3.1)
 into NSDate.
 */
+ (nullable NSDate *)dateFromRFC1123:(NSString * _Nullable)value_;

/**
 Convert NSDate into a RFC1123 'Full-Date' string
 (http://www.w3.org/Protocols/rfc2616/rfc2616-sec3.html#sec3.3.1).
 */
- (nullable NSString *)rfc1123String;

/**
 Convert NSDate into a 'yyyyMMdd' string
 */
- (nullable NSString *)yyyyMMddString;

/**
 Convert NSDate into a string with FormatString
 */
- (nullable NSString *)stringWithFormatString:(nonnull NSString *)formatString;

/**
 *  @brief Convert to local time zone.
 */
- (nullable NSDate *)toLocalDate;

- (nullable NSDate *)toBeijingDate;

/**
 *  @brief Convert to gmt time zone.
 */
- (nullable NSDate *)toGlobalDate;

/**
 *  @brief 00:00:00
 */
- (nullable NSDate *)beginningOfDay;

/**
 *  @brief 23:59:59
 */
- (nullable NSDate *)endingOfDay;

/**
 *  @brief MM月01日
 */
- (nonnull NSString *)beginningOfMonth;

@end

NS_ASSUME_NONNULL_END
