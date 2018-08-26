//
//  NSObject+Addition.h
//  MYKitDemo
//
//  Created by QMMac on 2018/7/31.
//  Copyright © 2018 com.51fanxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Addition)

/**
 获取一个类的所有直接子类类簇
 */
- (NSArray *)findAllOf:(Class)defaultClass;

@end
