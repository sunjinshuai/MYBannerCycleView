//
//  NSDateFormatter+Extension.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/27.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (Extension)

+ (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format;
+ (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone;
+ (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale;
+ (NSDateFormatter *)dateFormatterWithDateStyle:(NSDateFormatterStyle)style;
+ (NSDateFormatter *)dateFormatterWithDateStyle:(NSDateFormatterStyle)style timeZone:(NSTimeZone *)timeZone;
+ (NSDateFormatter *)dateFormatterWithTimeStyle:(NSDateFormatterStyle)style;
+ (NSDateFormatter *)dateFormatterWithTimeStyle:(NSDateFormatterStyle)style timeZone:(NSTimeZone *)timeZone;

+ (instancetype)dateFormatter;

+ (instancetype)dateFormatterWithFormatString:(NSString *)dateFormatString;

+ (instancetype)dateFormatterWithFormatString:(NSString *)fmtString timezoneName:(NSString *)timezoneName;
+ (instancetype)dateFormatterWithFormatString:(NSString *)dateFormatString dateStyle:(NSDateFormatterStyle)dateStyle;
/**
 格式化：yyyy-MM-dd HH:mm:ss
 
 @return NSDateFormatter
 */
+ (instancetype)setupDateFormatterWithYMDHMS;

/**
 格式化：yyyy-MM-dd, EEE, HH:mm:ss
 
 @return NSDateFormatter
 */
+ (instancetype)setupDateFormatterWithYMDEHMS;

/**
 格式化：yyyy-MM-dd
 
 @return NSDateFormatter
 */
+ (instancetype)setupDateFormatterWithYMD;

/**
 格式化：yyyy-MM
 
 @return NSDateFormatter
 */
+ (instancetype)setupDateFormatterWithYM;

/**
 格式化：yyyy
 
 @return NSDateFormatter
 */
+ (instancetype)setupDateFormatterWithYY;

/**
 格式化：HM
 
 @return NSDateFormatter
 */
+ (instancetype)setupDateFormatterWithHM;

/**
 格式化：HMS
 
 @return NSDateFormatter
 */
+ (instancetype)setupDateFormatterWithHMS;

@end
