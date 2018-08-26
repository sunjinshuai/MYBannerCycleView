//
//  NSMutableArray+Stack.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/12/29.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "NSMutableArray+Stack.h"

@implementation NSMutableArray (Stack)

- (void)pushObject:(id)anObject {
    [self addObject:anObject];
}

- (id)popObject {
    id anObject = [self lastObject];
    if (self.count > 0) {
        [self removeLastObject];
    }
    return anObject;
}

- (id)peekObject {
    return [self lastObject];
}

@end
