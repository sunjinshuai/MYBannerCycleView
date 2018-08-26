//
//  NSMutableArray+Queue.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/12/29.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (Queue)

/**
 *  @brief 队列的容量，大于0为有效容量，小于等于0表示不限制容量
 */
@property (nonatomic, assign) NSInteger queueSize;

- (void)enqueueObject:(id)anObject;

- (nullable id)dequeueObject;

@end

NS_ASSUME_NONNULL_END
