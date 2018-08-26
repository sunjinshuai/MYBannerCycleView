//
//  NSMutableArray+Stack.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/12/29.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (Stack)

- (void)pushObject:(id)anObject;

- (nullable id)popObject;

- (nullable id)peekObject;

@end

NS_ASSUME_NONNULL_END

