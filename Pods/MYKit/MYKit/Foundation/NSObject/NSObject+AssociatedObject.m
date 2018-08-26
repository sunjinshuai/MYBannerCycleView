//
//  NSObject+AssociatedObject.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/28.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "NSObject+AssociatedObject.h"
#import <objc/runtime.h>

@implementation NSObject (AssociatedObject)

- (id)object:(SEL)key {
    return objc_getAssociatedObject(self, key);
}

- (void)setAssignObject:(id)object withKey:(SEL)key {
    objc_setAssociatedObject(self, key, object, OBJC_ASSOCIATION_ASSIGN);
}

- (void)setRetainNonatomicObject:(id)object withKey:(SEL)key {
    objc_setAssociatedObject(self, key, object,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setCopyNonatomicObject:(id)object withKey:(SEL)key {
    objc_setAssociatedObject(self, key, object, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setRetainObject:(id)object withKey:(SEL)key {
    objc_setAssociatedObject(self, key, object, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setCopyObject:(id)object withKey:(SEL)key {
    objc_setAssociatedObject(self, key, object, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
