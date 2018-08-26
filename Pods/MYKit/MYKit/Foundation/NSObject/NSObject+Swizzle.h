//
//  NSObject+Swizzle.h
//  MYKitDemo
//
//  Created by QMMac on 2018/6/13.
//  Copyright © 2018 com.51fanxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (Swizzle)

/**
 对类方法进行拦截并替换

 @param originalSelector 类的原类方法
 @param replaceSelector 替代方法
 */
+ (void)swizzleClassMethod:(SEL)originalSelector replaceMethod:(SEL)replaceSelector;

/**
 对对象的实例方法进行拦截并替换

 @param originalSelector 对象的原实例方法
 @param replaceSelector 替代方法
 */
- (void)instanceSwizzleMethod:(SEL _Nonnull )originalSelector replaceMethod:(SEL _Nonnull )replaceSelector;

/**
 对类方法进行拦截并替换
 
 @param klass 被拦截的具体类
 @param originalSelector 类的原类方法
 @param replaceSelector 替代方法
 */
+ (void)classSwizzleMethodWithClass:(Class _Nonnull)klass orginalMethod:(SEL _Nonnull)originalSelector replaceMethod:(SEL _Nonnull)replaceSelector;

/**
 对对象的实例方法进行拦截并替换
 
 @param klass 被拦截的具体类
 @param originalSelector 对象的原实例方法
 @param replaceSelector 替代方法
 */
+ (void)instanceSwizzleMethodWithClass:(Class _Nonnull)klass orginalMethod:(SEL _Nonnull)originalSelector replaceMethod:(SEL _Nonnull)replaceSelector;

@end
