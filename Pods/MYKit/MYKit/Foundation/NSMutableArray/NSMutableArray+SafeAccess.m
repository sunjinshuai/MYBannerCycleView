//
//  NSMutableArray+SafeAccess.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2018/3/1.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "NSMutableArray+SafeAccess.h"

@implementation NSMutableArray (SafeAccess)

- (void)addSafeObject:(id)object {
    
    if (object == nil) {
        return;
    }
    [self addObject:object];
}

- (void)insertSafeObject:(id)object
                   index:(NSUInteger)index {
    
    if (object == nil) {
        return;
    }
    
    if (index > self.count) {
        [self insertObject:object
                   atIndex:self.count];
    } else {
        
        [self insertObject:object
                   atIndex:index];
    }
}

- (void)insertSafeArray:(NSArray *)array
               indexSet:(NSIndexSet *)indexSet {
    
    if (indexSet == nil) {
        return;
    }
    
    if (indexSet.count != array.count || indexSet.firstIndex > array.count) {
        [self insertObject:array
                   atIndex:self.count];
    } else {
        [self insertObjects:array
                  atIndexes:indexSet];
    }
}

- (void)safeRemoveObjectAtIndex:(NSUInteger)index {
    
    if (index >= self.count) {
        return;
    }
    [self removeObjectAtIndex:index];
}

- (void)safeRemoveObjectsInRange:(NSRange)range {
    
    NSUInteger location = range.location;
    NSUInteger length   = range.length;
    
    if (location + length > self.count) {
        return;
    }
    [self removeObjectsInRange:range];
}

@end
