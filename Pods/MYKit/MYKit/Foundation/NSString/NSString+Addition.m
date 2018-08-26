//
//  NSString+Addition.m
//  FXKitExample
//
//  Created by sunjinshuai on 2017/7/17.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "NSString+Addition.h"
#import "NSData+YYAdd.h"

@implementation NSString (Addition)

- (int)wordsCount {
    NSInteger n = self.length;
    int i;
    int l = 0, a = 0, b = 0;
    unichar c;
    for (i = 0; i < n; i++) {
        c = [self characterAtIndex:i];
        if (isblank(c)) {
            b++;
        } else if (isascii(c)) {
            a++;
        } else {
            l++;
        }
    }
    if (a == 0 && l == 0) {
        return 0;
    }
    return l + (int)ceilf((float)(a + b) / 2.0);
}

- (BOOL)isContainChinese {
    NSUInteger length = [self length];
    for (NSUInteger i = 0; i < length; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [self substringWithRange:range];
        const char *cString = [subString UTF8String];
        if (strlen(cString) == 3) {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)isEmpty:(NSString *)string {
    return string == nil || string.length == 0 || [string isEqualToString:@""];
}

+ (NSString *)stringWithJSONObject:(id)obj {
    NSData *promotionListJsonData = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:0];
    
    return [[NSString alloc] initWithData:promotionListJsonData encoding:NSUTF8StringEncoding];
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

- (NSString *)reverse {
    NSMutableString *reversedString = [NSMutableString string];
    NSInteger charIndex = [self length];
    while (charIndex > 0) {
        charIndex--;
        NSRange subStrRange = NSMakeRange(charIndex, 1);
        [reversedString appendString:[self substringWithRange:subStrRange]];
    }
    return [reversedString copy];
}

+ (NSString *)replaceStringFormString:(NSString *)replace {
    if ([NSString isEmpty:replace]) {
        return @"";
    }
    return replace;
}

/**
 将 一串数字 1001 转换成 一零零一
 
 @param number 输入的数字
 @return 转换后的文字
 */
+ (NSString *)stringTransformNumberToString:(NSInteger)number {
    
    NSString *str = [NSString stringWithFormat:@"%ld", (long)number];
    NSRange range;
    range.length = 1;
    
    NSString *finalStr = [NSString string];
    for (NSUInteger i = 0; i < [str length]; i++) {
        range.location = i;
        NSString *subStr = [str substringWithRange:range];
        NSInteger subNum = [subStr integerValue];
        switch (subNum) {
            case 0:
                subStr = [NSString replaceNewString:@"零" range:range oldString:str];
                break;
            case 1:
                subStr = [NSString replaceNewString:@"一" range:range oldString:str];
                break;
            case 2:
                subStr = [NSString replaceNewString:@"二" range:range oldString:str];
                break;
            case 3:
                subStr = [NSString replaceNewString:@"三" range:range oldString:str];
                break;
            case 4:
                subStr = [NSString replaceNewString:@"四" range:range oldString:str];
                break;
            case 5:
                subStr = [NSString replaceNewString:@"五" range:range oldString:str];
                break;
            case 6:
                subStr = [NSString replaceNewString:@"六" range:range oldString:str];
                break;
            case 7:
                subStr = [NSString replaceNewString:@"七" range:range oldString:str];
                break;
            case 8:
                subStr = [NSString replaceNewString:@"八" range:range oldString:str];
                break;
            case 9:
                subStr = [NSString replaceNewString:@"九" range:range oldString:str];
                break;
            default:
                break;
        }
        finalStr = [finalStr stringByAppendingString:subStr];
    }
    return finalStr;
}

+ (NSString *)replaceNewString:(NSString *)newString
                         range:(NSRange)range
                     oldString:(NSString *)oldString {
    NSString *subStr = @"";
    
    if (oldString.length == 1) {
        subStr = newString;
    } else if (oldString.length == 2) {
        if (range.location == 0) {
            subStr = [NSString stringWithFormat:@"%@十", newString];
        } else if (range.location == 1) {
            subStr = newString;
        }
    } else if (oldString.length == 3) {
        if (range.location == 0) {
            subStr = [NSString stringWithFormat:@"%@百", newString];
        } else if (range.location == 1) {
            subStr = [NSString stringWithFormat:@"%@十", newString];
        } else if (range.location == 2) {
            subStr = newString;
        }
    }
    return subStr;
}

#pragma mark - ***** 手机号码格式化样式：344【中间空格】，示例：13855556666 --> 138 5555 6666
+ (NSString *)phoneNumberFormatterSpace:(NSString *)phoneNumber {
    NSString *phone = phoneNumber;
    
    while (phone.length > 0) {
        NSString *subString = [phone substringToIndex:MIN(phone.length, 3)];
        if (phone.length >= 7) {
            subString = [subString stringByAppendingString:@" "];
            subString = [subString stringByAppendingString:[phone substringWithRange:NSMakeRange(3, 4)]];
        }
        if ( phone.length == 11) {
            subString = [subString stringByAppendingString:@" "];
            subString = [subString stringByAppendingString:[phone substringWithRange:NSMakeRange(7, 4)]];
            phone = subString;
            break;
        }
    }
    
    return phone;
}

#pragma mark - ***** 手机号码格式化样式：3*4【中间4位为*】，示例：13855556666 --> 138****6666
+ (NSString *)phoneNumberFormatterCenterStar:(NSString *)phoneNumber {
    NSString *phone = phoneNumber;
    
    while (phone.length > 0) {
        phone = [phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        break;
    }
    
    return phone;
}

#pragma mark - ***** 数字格式化样式，示例：12345678.89 --> 12,345,678.89
+ (NSString *)stringFormatterWithStyle:(NSNumberFormatterStyle)numberStyle numberString:(NSString *)numberString {
    NSString *numString = numberString;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *number = [formatter numberFromString:numString];
    formatter.numberStyle = numberStyle;
    NSString *string = [formatter stringFromNumber:number];
    
    return string;
}

#pragma mark - ***** 格式化为带小数点的数字，示例：12345678.89 --> 12,345,678.89
+ (NSString *)stringFormatterWithDecimalStyleWithNumberString:(NSString *)numberString {
    /*! 输出结果示例：numberFormatter == 12,345,678.89 */
    return [NSString stringFormatterWithStyle:NSNumberFormatterDecimalStyle numberString:numberString];
}

#pragma mark - ***** 格式化为货币样式，示例：12345678.89 --> $12,345,678.89
+ (NSString *)stringFormatterWithCurrencyStyleWithNumberString:(NSString *)numberString {
    NSString *numString = numberString;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *number = [formatter numberFromString:numString];
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    NSString *string = [formatter stringFromNumber:number];
    
    /*! 输出结果示例：numberFormatter == 12,345,678.89 */
    return string;
}

#pragma mark - ***** 格式化为百分比样式，示例：12345678.89 --> 1,234,567,889%
+ (NSString *)stringFormatterWithPercentStyleWithNumberString:(NSString *)numberString {
    NSString *numString = numberString;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *number = [formatter numberFromString:numString];
    formatter.numberStyle = NSNumberFormatterPercentStyle;
    NSString *string = [formatter stringFromNumber:number];
    
    /*! 输出结果示例：numberFormatter == 1,234,567,889% */
    return string;
}

#pragma mark - ***** 格式化为科学计数样式，示例：12345678.89 --> 1.234567889E7
+ (NSString *)stringFormatterWithScientificStyleWithNumberString:(NSString *)numberString {
    NSString *numString = numberString;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *number = [formatter numberFromString:numString];
    formatter.numberStyle = NSNumberFormatterScientificStyle;
    NSString *string = [formatter stringFromNumber:number];
    
    /*! 输出结果示例：numberFormatter == 1.234567889E7 */
    return string;
}

#pragma mark - ***** 格式化为英文输出样式（注：此处根据系统语言输出），示例：12345678.89 --> 一千二百三十四万五千六百七十八点八九
+ (NSString *)stringFormatterWithSpellOutStyleWithNumberString:(NSString *)numberString {
    NSString *numString = numberString;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *number = [formatter numberFromString:numString];
    formatter.numberStyle = NSNumberFormatterSpellOutStyle;
    NSString *string = [formatter stringFromNumber:number];
    
    /*! 输出结果示例：numberFormatter == twelve million three hundred forty-five thousand six hundred seventy-eight point eight nine */
    return string;
}

#pragma mark - ***** 格式化为序数样式，示例：12345678.89 --> 第1234,5679
+ (NSString *)stringFormatterWithOrdinalStyleWithNumberString:(NSString *)numberString {
    NSString *numString = numberString;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *number = [formatter numberFromString:numString];
    formatter.numberStyle = NSNumberFormatterOrdinalStyle;
    NSString *string = [formatter stringFromNumber:number];
    
    /*! 输出结果示例：numberFormatter == 第1234,5679 */
    return string;
}

#pragma mark - ***** 格式化为货币ISO代码样式样式，示例：123456889.86 --> CNY123,456,889.86
+ (NSString *)stringFormatterWithCurrencyISOCodeStyleWithNumberString:(NSString *)numberString {
    NSString *numString = numberString;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *number = [formatter numberFromString:numString];
    formatter.numberStyle = NSNumberFormatterCurrencyISOCodeStyle;
    NSString *string = [formatter stringFromNumber:number];
    
    /*! 输出结果示例：numberFormatter == 12,345,679 */
    return string;
}

#pragma mark - ***** 格式化为货币多样式，示例：12345678.89 --> USD 12,345,678.89
+ (NSString *)stringFormatterWithCurrencyPluralStyleWithNumberString:(NSString *)numberString {
    NSString *numString = numberString;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *number = [formatter numberFromString:numString];
    formatter.numberStyle = NSNumberFormatterCurrencyPluralStyle;
    NSString *string = [formatter stringFromNumber:number];
    
    /*! 输出结果示例：numberFormatter == USD 12,345,678.89 */
    return string;
}

#pragma mark - ***** 格式化为货币会计样式，示例：12345678.89 --> 12,345,678.89美元
+ (NSString *)stringFormatterWithCurrencyAccountingStyleWithNumberString:(NSString *)numberString {
    NSString *numString = numberString;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *number = [formatter numberFromString:numString];
    formatter.numberStyle = NSNumberFormatterCurrencyAccountingStyle;
    NSString *string = [formatter stringFromNumber:number];
    
    /*! 输出结果示例：numberFormatter == 12,345,678.89美元 */
    return string;
}

#pragma mark - 保留纯数字
- (NSString *)removeStringSaveNumber {
    NSCharacterSet *setToRemove = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    return [[self componentsSeparatedByCharactersInSet:setToRemove] componentsJoinedByString:@""];
}

#pragma mark - 点赞数处理：2.1千，3.4万
/**
 点赞数处理：2.1千，3.4万
 
 @param string 传入的 string 类型的 数字
 @return 2.1千，3.4万
 */
+ (NSString *)stringTransformNumberWithString:(NSString *)string {
    float number = [string integerValue];
    
    NSString *numberString = @"";
    if (number < 1000) {
        numberString = [NSString stringWithFormat:@"%.0f", number];
    } else {
        if (number / 1000 && number / 10000 < 1) {
            numberString = [NSString stringWithFormat:@"%.1f千", number/1000];
        } else {
            numberString = [NSString stringWithFormat:@"%.1f万", number/10000];
        }
    }
    return numberString;
}

- (NSString *)stringByDeletingPictureResolution {
    NSString *doubleResolution = @"@2x";
    NSString *tribleResolution = @"@3x";
    NSString *fileName = self.stringByDeletingPathExtension;
    NSString *res = [self copy];
    if ([fileName hasSuffix:doubleResolution] || [fileName hasSuffix:tribleResolution]) {
        res = [fileName substringToIndex:fileName.length - 3];
        if (self.pathExtension.length) {
            res = [res stringByAppendingPathExtension:self.pathExtension];
        }
    }
    return res;
}

- (NSString *)md2String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] md2String];
}

- (NSString *)md4String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] md4String];
}

- (NSString *)md5String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] md5String];
}

- (NSString *)sha1String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] sha1String];
}

- (NSString *)sha224String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] sha224String];
}

- (NSString *)sha256String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] sha256String];
}

- (NSString *)sha384String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] sha384String];
}

- (NSString *)sha512String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] sha512String];
}

- (NSString *)crc32String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] crc32String];
}

- (NSString *)hmacMD5StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            hmacMD5StringWithKey:key];
}

- (NSString *)hmacSHA1StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            hmacSHA1StringWithKey:key];
}

- (NSString *)hmacSHA224StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            hmacSHA224StringWithKey:key];
}

- (NSString *)hmacSHA256StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            hmacSHA256StringWithKey:key];
}

- (NSString *)hmacSHA384StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            hmacSHA384StringWithKey:key];
}

- (NSString *)hmacSHA512StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            hmacSHA512StringWithKey:key];
}

- (NSString *)base64EncodedString {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] base64EncodedString];
}

+ (NSString *)stringWithBase64EncodedString:(NSString *)base64EncodedString {
    NSData *data = [NSData dataWithBase64EncodedString:base64EncodedString];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
@end
