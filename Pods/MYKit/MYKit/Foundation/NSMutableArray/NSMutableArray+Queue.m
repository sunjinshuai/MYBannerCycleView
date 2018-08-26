//
//  NSMutableArray+Queue.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/12/29.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "NSMutableArray+Queue.h"
#import "NSObject+AssociatedObject.h"

@implementation NSMutableArray (Queue)

BOOL queueSizeFlag = NO;

- (void)enqueueObject:(id)anObject {
    [self addObject:anObject];
    if (queueSizeFlag && self.count > self.queueSize) {
        [self removeObjectAtIndex:0];
    }
}

- (id)dequeueObject {
    id anObject = [self firstObject];
    if (self.count > 0) {
        [self removeObjectAtIndex:0];
    }
    return anObject;
}

#pragma mark - propertes

- (NSInteger)queueSize {
    return [[self object:@selector(setQueueSize:)] integerValue];
}

- (void)setQueueSize:(NSInteger)queueSize {
    [self setRetainNonatomicObject:@(queueSize) withKey:@selector(setQueueSize:)];
    if (queueSize > 0) {
        queueSizeFlag = YES;
    } else {
        queueSizeFlag = NO;
    }
}

@end
