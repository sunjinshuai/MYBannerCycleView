//
//  UIView+RedDot.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/11/18.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "UIView+RedDot.h"
#import "NSObject+AssociatedObject.h"
#import <objc/runtime.h>

@interface UIView ()

@property (nonatomic, strong) UIView *badgeView;

@end

@implementation UIView (RedDot)

- (void)addRedDotWithRadius:(CGFloat)radius offsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY {
    CAShapeLayer *redDot = [self redDot];
    
    if (redDot) {
        [redDot removeFromSuperlayer];
    }
    
    UIBezierPath *redDotPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius*2, radius*2)];
    CAShapeLayer *redDotLayer = [CAShapeLayer layer];
    redDotLayer.fillColor = [UIColor redColor].CGColor;
    redDotLayer.frame = CGRectMake(CGRectGetWidth(self.frame)-radius+offsetX, -radius+offsetY, radius*2, radius*2);
    redDotLayer.path = redDotPath.CGPath;
    [self setRedDot:redDotLayer];
    [self.layer addSublayer:redDotLayer];
    redDotLayer.hidden = YES;
}

- (void)showRedDotWithRadius:(CGFloat)radius offsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY {
    
    CAShapeLayer *redDot = [self redDot];
    
    if (redDot) {
        [redDot removeFromSuperlayer];
    }
    
    UIBezierPath *redDotPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius*2, radius*2)];
    CAShapeLayer *redDotLayer = [CAShapeLayer layer];
    redDotLayer.fillColor = [UIColor redColor].CGColor;
    redDotLayer.frame = CGRectMake(CGRectGetMaxX(self.frame)-radius+offsetX, -radius+offsetY, radius*2, radius*2);
    redDotLayer.path = redDotPath.CGPath;
    [self setRedDot:redDotLayer];
    [self.layer addSublayer:redDotLayer];
}

- (void)showRedDot {
    CAShapeLayer *redDot = [self redDot];
    if (redDot) {
        redDot.hidden = NO;
    }
}

- (void)hiddenRedDot {
    CAShapeLayer *redDot = [self redDot];
    if (redDot) {
        redDot.hidden = YES;
    }
}

#pragma mark - private

- (CAShapeLayer *)redDot {
    return [self object:@selector(setRedDot:)];
}

- (void)setRedDot:(CAShapeLayer *)layer {
    [self setRetainNonatomicObject:layer withKey:@selector(setRedDot:)];
}

@end
