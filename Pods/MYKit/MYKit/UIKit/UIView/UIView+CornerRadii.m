//
//  UIView+CornerRadii.m
//  LPDCrowdsource
//
//  Created by eMr.Wang on 16/1/29.
//  Copyright © 2016年 elm. All rights reserved.
//

#import "UIView+CornerRadii.h"

@implementation UIView (CornerRadii)

- (void)setCornerRadii:(CGFloat)cornerRadii roundingCorners:(UIRectCorner)roundingCorners {
    return [self setCornerRadii:cornerRadii roundingCorners:roundingCorners borderWidth:0 borderColor:[UIColor whiteColor]];
}

- (void)setCornerRadii:(CGFloat)cornerRadii roundingCorners:(UIRectCorner)roundingCorners borderWidth:(CGFloat)borderWidth
           borderColor:(UIColor *)borderColor  {
    if (self.layer.mask) {
        self.layer.mask = nil;
    }
    self.layer.masksToBounds = YES;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:roundingCorners
                                                         cornerRadii:CGSizeMake(cornerRadii, cornerRadii)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.path = maskPath.CGPath;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = borderColor.CGColor;
    borderLayer.lineWidth = borderWidth;
    borderLayer.frame = self.bounds;
    
    [self.layer addSublayer:borderLayer];
}

@end
