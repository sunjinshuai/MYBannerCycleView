//
//  NSNumber+Round.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/28.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "NSNumber+Round.h"
#import "NSString+Addition.h"

@implementation NSNumber (Round)

#pragma mark - Display
- (NSString *)toDisplayNumberWithDigit:(NSInteger)digit {
    NSString *result = nil;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    [formatter setMaximumFractionDigits:digit];
    result = [formatter stringFromNumber:self];
    if (result == nil) {
        return @"";
    }
    return result;
}

- (NSString *)toDisplayPercentageWithDigit:(NSInteger)digit {
    NSString *result = nil;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterPercentStyle];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    [formatter setMaximumFractionDigits:digit];
    //NSLog(@"percentage target:%@ result:%@",number,[formatter  stringFromNumber:number]);
    result = [formatter  stringFromNumber:self];
    return result;
}

#pragma mark - ceil , round, floor
- (NSNumber *)doRoundWithDigit:(NSUInteger)digit {
    NSNumber *result = nil;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    [formatter setMaximumFractionDigits:digit];
    [formatter setMinimumFractionDigits:digit];
    //NSLog(@"round target:%@ result:%@",number,[formatter  stringFromNumber:number]);
    result = [NSNumber numberWithDouble:[[formatter  stringFromNumber:self] doubleValue]];
    return result;
}

- (NSNumber *)doCeilWithDigit:(NSUInteger)digit {
    NSNumber *result = nil;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setRoundingMode:NSNumberFormatterRoundCeiling];
    [formatter setMaximumFractionDigits:digit];
    //NSLog(@"ceil target:%@ result:%@",number,[formatter  stringFromNumber:number]);
    result = [NSNumber numberWithDouble:[[formatter  stringFromNumber:self] doubleValue]];
    return result;
}

- (NSNumber *)doFloorWithDigit:(NSUInteger)digit {
    NSNumber *result = nil;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setRoundingMode:NSNumberFormatterRoundFloor];
    [formatter setMaximumFractionDigits:digit];
    result = [NSNumber numberWithDouble:[[formatter  stringFromNumber:self] doubleValue]];
    //NSLog(@"prev:%@, result:%@",number, result);
    return result;
}

static NSDictionary *numberKeyToTraditionalValues;

+ (NSString *)tranditionalCharByNumberString:(NSString *)numberString {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        numberKeyToTraditionalValues = @{
                                         @"1": @"壹",
                                         @"2": @"貳",
                                         @"3": @"叁",
                                         @"4": @"肆",
                                         @"5": @"伍",
                                         @"6": @"陸",
                                         @"7": @"柒",
                                         @"8": @"捌",
                                         @"9": @"玖",
                                         @"10": @"拾",
                                         @"100": @"佰",
                                         @"1000": @"仟",
                                         };
    });
    return [numberKeyToTraditionalValues objectForKey:numberString];
}

- (NSString *)traditionalMoneyString {
    NSUInteger startIndex = 0;
    NSString *moneyString = [[self moneyString] reverse];
    NSMutableString *traditionalMoneyString = [NSMutableString string];
    NSString *tranditionalChar = nil;
    if ([moneyString characterAtIndex:2] == '.') { // 有小数点
        tranditionalChar =
        [NSNumber tranditionalCharByNumberString:[moneyString substringWithRange:NSMakeRange(startIndex, 1)]];
        if (tranditionalChar) {
            [traditionalMoneyString insertString:@"分" atIndex:0];
            [traditionalMoneyString insertString:tranditionalChar atIndex:0];
        }
        moneyString = [moneyString substringFromIndex:1];
        
        tranditionalChar =
        [NSNumber tranditionalCharByNumberString:[moneyString substringWithRange:NSMakeRange(startIndex, 1)]];
        if (tranditionalChar) {
            [traditionalMoneyString insertString:@"角" atIndex:0];
            [traditionalMoneyString insertString:tranditionalChar atIndex:0];
        }
        moneyString = [moneyString substringFromIndex:2];
    } else {
        [traditionalMoneyString insertString:@"整" atIndex:0];
    }
    
    [traditionalMoneyString insertString:@"圓" atIndex:0];
    
    NSUInteger mileRangeLen = moneyString.length < 4 ? moneyString.length : 4;
    NSString *mileString = [self traditionalString:[moneyString substringWithRange:NSMakeRange(0, mileRangeLen)]];
    if (mileString && mileString.length > 0) {
        [traditionalMoneyString insertString:mileString atIndex:0];
    }
    moneyString = [moneyString substringFromIndex:mileRangeLen];
    if (moneyString.length > 0) {
        mileRangeLen = moneyString.length < 4 ? moneyString.length : 4;
        mileString = [self traditionalString:[moneyString substringWithRange:NSMakeRange(0, mileRangeLen)]];
        if (mileString && mileString.length > 0) {
            [traditionalMoneyString insertString:@"萬" atIndex:0];
            [traditionalMoneyString insertString:mileString atIndex:0];
        }
        moneyString = [moneyString substringFromIndex:mileRangeLen];
        if (moneyString.length > 0) {
            mileRangeLen = moneyString.length < 4 ? moneyString.length : 4;
            mileString = [self traditionalString:[moneyString substringWithRange:NSMakeRange(0, mileRangeLen)]];
            if (mileString && mileString.length > 0) {
                [traditionalMoneyString insertString:@"億" atIndex:0];
                [traditionalMoneyString insertString:mileString atIndex:0];
            }
        }
    }
    
    return [traditionalMoneyString copy];
}

- (NSString *)traditionalString:(NSString *)numberString {
    NSMutableString *traditionalString = [NSMutableString string];
    NSString *tranditionalChar = nil;
    NSString *tranditionalUnitChar = nil;
    NSUInteger startIndex = 0;
    while (startIndex < numberString.length) {
        tranditionalChar =
        [NSNumber tranditionalCharByNumberString:[numberString substringWithRange:NSMakeRange(startIndex, 1)]];
        if (tranditionalChar) {
            if (startIndex > 0) {
                tranditionalUnitChar = [NSNumber tranditionalCharByNumberString:@(pow(10, startIndex)).stringValue];
            }
            if (tranditionalUnitChar) {
                [traditionalString insertString:tranditionalUnitChar atIndex:0];
                tranditionalUnitChar = nil;
            }
            [traditionalString insertString:tranditionalChar atIndex:0];
        }
        startIndex++;
        tranditionalChar = nil;
    }
    return [traditionalString copy];
}

- (NSString *)moneyString {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencySymbol:@"¥"];
    return [[formatter stringFromNumber:self] stringByReplacingOccurrencesOfString:@"," withString:@""];
}

@end
