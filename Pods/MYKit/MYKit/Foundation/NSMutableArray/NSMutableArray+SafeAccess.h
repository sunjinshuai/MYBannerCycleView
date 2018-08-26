//
//  NSMutableArray+SafeAccess.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2018/3/1.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (SafeAccess)

/**
 安全的添加一个对象
 
 @param object 对象
 */
- (void)addSafeObject:(id)object;

/**
 根据索引安全的插入一个对象
 
 @param object 对象
 @param index NSUInteger
 */
- (void)insertSafeObject:(id)object
                      index:(NSUInteger)index;

/**
 根据索引安全的插入一个数组
 
 @param array NSArray
 @param indexSet NSIndexSet
 */
- (void)insertSafeArray:(NSArray *)array
                  indexSet:(NSIndexSet *)indexSet;

/**
 根据索引安全的删除一个对象
 
 @param index NSUInteger
 */
- (void)safeRemoveObjectAtIndex:(NSUInteger)index;

/**
 根据范围安全的删除
 
 @param range NSRange
 */
- (void)safeRemoveObjectsInRange:(NSRange)range;

@end
