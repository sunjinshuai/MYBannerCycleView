//
//  NSDateFormatter+Extension.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/27.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

//iOS-NSDateFormatter格式说明：
//G: 公元时代，例如AD公元
//yy: 年的后2位
//yyyy: 完整年
//MM: 月，显示为1-12
//MMM: 月，显示为英文月份简写,如 Jan
//MMMM: 月，显示为英文月份全称，如 Janualy
//dd: 日，2位数表示，如02
//d: 日，1-2位显示，如 2
//EEE: 简写星期几，如Sun
//EEEE: 全写星期几，如Sunday
//aa: 上下午，AM/PM
//H: 时，24小时制，0-23
//K：时，12小时制，0-11
//m: 分，1-2位
//mm: 分，2位
//s: 秒，1-2位
//ss: 秒，2位
//S: 毫秒
//Z：GMT

#import "NSDateFormatter+Extension.h"

@implementation NSDateFormatter (Extension)

+ (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format {
    return [self dateFormatterWithFormat:format timeZone:nil];
}

+ (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone {
    return [self dateFormatterWithFormat:format timeZone:timeZone locale:nil];
}

+ (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale {
    if (format == nil || [format isEqualToString:@""]) return nil;
    NSString *key = [NSString stringWithFormat:@"NSDateFormatter-tz-%@-fmt-%@-loc-%@", [timeZone abbreviation], format, [locale localeIdentifier]];
    NSMutableDictionary* dictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter* dateFormatter = [dictionary objectForKey:key];
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:format];
        [dictionary setObject:dateFormatter forKey:key];
#if !__has_feature(objc_arc)
        [dateFormatter autorelease];
#endif
    }
    if (locale != nil) [dateFormatter setLocale:locale]; // this may change so don't cache
    if (timeZone != nil) [dateFormatter setTimeZone:timeZone]; // this may change
    return dateFormatter;
}

+ (NSDateFormatter *)dateFormatterWithDateStyle:(NSDateFormatterStyle)style {
    return [self dateFormatterWithDateStyle:style timeZone:nil];
}

+ (NSDateFormatter *)dateFormatterWithDateStyle:(NSDateFormatterStyle)style timeZone:(NSTimeZone *)timeZone {
    NSString *key = [NSString stringWithFormat:@"NSDateFormatter-%@-dateStyle-%d", [timeZone abbreviation], (int)style];
    NSMutableDictionary* dictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter* dateFormatter = [dictionary objectForKey:key];
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:style];
        [dictionary setObject:dateFormatter forKey:key];
#if !__has_feature(objc_arc)
        [dateFormatter autorelease];
#endif
    }
    if (timeZone != nil) [dateFormatter setTimeZone:timeZone]; // this may change so don't cache
    return dateFormatter;
}

+ (NSDateFormatter *)dateFormatterWithTimeStyle:(NSDateFormatterStyle)style {
    return [self dateFormatterWithTimeStyle:style timeZone:nil];
}

+ (NSDateFormatter *)dateFormatterWithTimeStyle:(NSDateFormatterStyle)style timeZone:(NSTimeZone *)timeZone {
    NSString *key = [NSString stringWithFormat:@"NSDateFormatter-%@-timeStyle-%d", [timeZone abbreviation], (int)style];
    NSMutableDictionary* dictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter* dateFormatter = [dictionary objectForKey:key];
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:style];
        [dictionary setObject:dateFormatter forKey:key];
#if !__has_feature(objc_arc)
        [dateFormatter autorelease];
#endif
    }
    if (timeZone != nil) [dateFormatter setTimeZone:timeZone]; // this may change so don't cache
    return dateFormatter;
}

+ (instancetype)dateFormatter
{
    return [[self alloc] init];
}

+ (instancetype)dateFormatterWithFormatString:(NSString *)dateFormatString
{
    if (dateFormatString == nil || ![dateFormatString isKindOfClass:[NSString class]] || [dateFormatString isEqualToString:@""])
    {
        return nil;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = dateFormatString;
    
    return dateFormatter;
}

+ (instancetype)dateFormatterWithFormatString:(NSString *)dateFormatString timezoneName:(NSString *)timezoneName
{
    NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterWithFormatString:dateFormatString];
    
    if (timezoneName != nil && [timezoneName isKindOfClass:[NSString class]] && ![timezoneName isEqualToString:@""]) {
        dateFormatter.timeZone = [NSTimeZone timeZoneWithName:timezoneName];
    }
    return dateFormatter;
}

+ (instancetype)dateFormatterWithFormatString:(NSString *)dateFormatString dateStyle:(NSDateFormatterStyle)dateStyle
{
    
    NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterWithFormatString:dateFormatString];
    
    dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    dateFormatter.dateStyle = dateStyle;
    
    return dateFormatter;
}

+ (instancetype)setupDateFormatterWithYMDHMS
{
    return [self dateFormatterWithFormatString:@"yyyy-MM-dd HH:mm:ss"];
}

+ (instancetype)setupDateFormatterWithYMDEHMS
{
    return [self dateFormatterWithFormatString:@"yyyy-MM-dd, EEE, HH:mm:ss"];
}

+ (instancetype)setupDateFormatterWithYMD
{
    return [self dateFormatterWithFormatString:@"yyyy-MM-dd"];
}

+ (instancetype)setupDateFormatterWithYM
{
    return [self dateFormatterWithFormatString:@"yyyy-MM"];
}

+ (instancetype)setupDateFormatterWithYY
{
    return [self dateFormatterWithFormatString:@"yyyy"];
}

+ (instancetype)setupDateFormatterWithHM
{
    return [self dateFormatterWithFormatString:@"HH:mm"];
}

+ (instancetype)setupDateFormatterWithHMS
{
    return [self dateFormatterWithFormatString:@"HH:mm:ss"];
}

@end
