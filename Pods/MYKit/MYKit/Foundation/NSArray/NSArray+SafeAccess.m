//
//  NSArray+SafeAccess.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/9/8.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "NSArray+SafeAccess.h"

@implementation NSArray (SafeAccess)

- (id)objectWithIndex:(NSUInteger)index {
    if (index >= [self count]) {
        return nil;
    }
    
    id value = [self objectAtIndex:index];
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
}

- (NSString *)stringWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null] || [[value description] isEqualToString:@"<null>"]) {
        return nil;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString *)value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    return nil;
}

- (NSNumber *)numberWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    if ([value isKindOfClass:[NSNumber class]]) {
        return (NSNumber *)value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        return [f numberFromString:(NSString *)value];
    }
    return nil;
}

- (NSDecimalNumber *)decimalNumberWithIndex:(NSUInteger)index{
    id value = [self objectWithIndex:index];
    if ([value isKindOfClass:[NSDecimalNumber class]]) {
        return value;
    } else if ([value isKindOfClass:[NSNumber class]]) {
        NSNumber *number = (NSNumber *)value;
        return [NSDecimalNumber decimalNumberWithDecimal:[number decimalValue]];
    } else if ([value isKindOfClass:[NSString class]]) {
        NSString *str = (NSString *)value;
        return [str isEqualToString:@""] ? nil : [NSDecimalNumber decimalNumberWithString:str];
    }
    return nil;
}

- (NSArray *)arrayWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    if ([value isKindOfClass:[NSArray class]]) {
        return value;
    }
    return nil;
}

- (NSDictionary *)dictionaryWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    if ([value isKindOfClass:[NSDictionary class]]) {
        return value;
    }
    return nil;
}

- (NSInteger)integerWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value integerValue];
    }
    return 0;
}

- (NSUInteger)unsignedIntegerWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value unsignedIntegerValue];
    }
    return 0;
}

- (BOOL)boolWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return NO;
    }
    
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value boolValue];
    }
    
    if ([value isKindOfClass:[NSString class]]) {
        return [value boolValue];
    }
    return NO;
}

- (int16_t)int16WithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value shortValue];
    }
    
    if ([value isKindOfClass:[NSString class]]) {
        return [value intValue];
    }
    return 0;
}

- (int32_t)int32WithIndex:(NSUInteger)index {
    
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value intValue];
    }
    return 0;
}

- (int64_t)int64WithIndex:(NSUInteger)index {
    
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value longLongValue];
    }
    return 0;
}

- (char)charWithIndex:(NSUInteger)index {
    
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value charValue];
    }
    return 0;
}

- (short)shortWithIndex:(NSUInteger)index {
    
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [value intValue];
    }
    return 0;
}

- (float)floatWithIndex:(NSUInteger)index {
    
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value floatValue];
    }
    return 0;
}

- (double)doubleWithIndex:(NSUInteger)index {
    
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value doubleValue];
    }
    return 0;
}

- (NSDate *)dateWithIndex:(NSUInteger)index dateFormat:(NSString *)dateFormat {
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = dateFormat;
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    
    if ([value isKindOfClass:[NSString class]] && ![value isEqualToString:@""] && !dateFormat) {
        return [formater dateFromString:value];
    }
    return nil;
}

- (CGFloat)my_floatWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    return [value doubleValue];
}

- (CGPoint)my_pointWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    return CGPointFromString(value);
}

- (CGSize)my_sizeWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    return CGSizeFromString(value);
}

- (CGRect)my_rectWithIndex:(NSUInteger)index {
    id value = [self objectWithIndex:index];
    return CGRectFromString(value);
}

@end
