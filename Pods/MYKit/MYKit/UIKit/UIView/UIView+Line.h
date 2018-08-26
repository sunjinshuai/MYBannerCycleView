//
//  UIView+Line.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/11/18.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Line)

/**
 *  划各种线 和分割线
 */
- (CAShapeLayer *)addBezierLine:(UIBezierPath *)bezierLine color:(UIColor *)lineColor;

- (CAShapeLayer *)addDottedLine:(CGPoint)startLine endPoint:(CGPoint)endPoint color:(UIColor *)lineColor;

- (CAShapeLayer *)addLine:(CGPoint)startLine endPoint:(CGPoint)endPoint color:(UIColor *)lineColor;

- (CAShapeLayer *)addLine:(CGPoint)startLine endPoint:(CGPoint)endPoint lineWidth:(CGFloat)lineWidth color:(UIColor *)lineColor;

- (CAShapeLayer *)addCornerRadius:(CGFloat)cornerRadius;

- (CAShapeLayer *)addCornerRadius:(CGFloat)cornerRadius color:(UIColor *)borderColor;

- (CAShapeLayer *)addCornerRadius:(CGFloat)cornerRadius lineWidth:(CGFloat)lineWidth color:(UIColor *)borderColor;

- (CAShapeLayer *)addCornerRadius:(CGFloat)cornerRadius lineWidth:(CGFloat)lineWidth color:(UIColor *)borderColor backgroundColor:(UIColor *)backgroundColor;

@end
