//
//  NSObject+Addition.m
//  MYKitDemo
//
//  Created by QMMac on 2018/7/31.
//  Copyright © 2018 com.51fanxing. All rights reserved.
//

#import "NSObject+Addition.h"
#import <objc/runtime.h>

@implementation NSObject (Addition)


- (NSArray *)findAllOf:(Class)defaultClass {
    
    int count = objc_getClassList(NULL, 0);
    if (count <= 0) {
        @throw @"Couldn't retrieve Obj-C class-list";
        return @[defaultClass];
    }
    
    NSMutableArray *output = @[].mutableCopy;
    Class *classes = (Class *)malloc(sizeof(Class) * count);
    objc_getClassList(classes, count);
    for (int i = 0; i < count; ++i) {
        if (defaultClass == class_getSuperclass(classes[i])) { //子类
            [output addObject:classes[i]];
        }
    }
    free(classes);
    return output.copy;
}

@end
