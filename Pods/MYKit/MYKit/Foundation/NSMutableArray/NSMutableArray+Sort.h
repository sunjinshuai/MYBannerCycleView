//
//  NSMutableArray+Sort.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/12/4.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSComparisonResult(^MYSortComparator)(id obj1, id obj2);
typedef void(^MYSortExchangeCallBack)(id obj1, id obj2);

@interface NSMutableArray (Sort)

#pragma mark - 选择排序
/*!
 *  选择排序
 *
 *  @param comparator           排序的对象
 *  @param sortExchangeCallBack 回调排序的结果
 */
- (void)selectSortWithComparator:(MYSortComparator)comparator
                     didExchange:(MYSortExchangeCallBack)sortExchangeCallBack;

/*!
 *  冒泡排序
 *
 *  @param comparator           排序的对象
 *  @param sortExchangeCallBack 回调排序的结果
 */
- (void)bubbleSortWithComparator:(MYSortComparator)comparator
                     didExchange:(MYSortExchangeCallBack)sortExchangeCallBack;

/*!
 *  插入排序
 *
 *  @param comparator           排序的对象
 *  @param sortExchangeCallBack 回调排序的结果
 */
- (void)insertSortWithComparator:(MYSortComparator)comparator
                     didExchange:(MYSortExchangeCallBack)sortExchangeCallBack;

/*!
 *  快速排序
 *
 *  @param comparator           排序的对象
 *  @param sortExchangeCallBack 回调排序的结果
 */
- (void)quickSortWithComparator:(MYSortComparator)comparator
                    didExchange:(MYSortExchangeCallBack)sortExchangeCallBack;

/*!
 *  堆排序
 *
 *  @param comparator           排序的对象
 *  @param sortExchangeCallBack 回调排序的结果
 */
- (void)heapSortWithComparator:(MYSortComparator)comparator
                   didExchange:(MYSortExchangeCallBack)sortExchangeCallBack;



@end
