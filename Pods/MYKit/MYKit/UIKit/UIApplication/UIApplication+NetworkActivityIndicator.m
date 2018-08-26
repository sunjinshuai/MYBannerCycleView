//
//  UIApplication+NetworkActivityIndicator.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/9/7.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "UIApplication+NetworkActivityIndicator.h"
#import <libkern/OSAtomic.h>

@implementation UIApplication (NetworkActivityIndicator)

static volatile int32_t numberOfActiveNetworkConnections;

#pragma mark Public API

- (void)beganNetworkActivity
{
    self.networkActivityIndicatorVisible = OSAtomicAdd32(1, &numberOfActiveNetworkConnections) > 0;
}

- (void)endedNetworkActivity
{
    self.networkActivityIndicatorVisible = OSAtomicAdd32(-1, &numberOfActiveNetworkConnections) > 0;
}

@end
