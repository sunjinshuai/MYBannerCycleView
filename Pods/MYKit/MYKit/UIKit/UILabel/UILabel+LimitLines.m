//
//  UILabel+LimitLines.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/7.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "UILabel+LimitLines.h"
#import "NSString+Size.h"
#import <objc/runtime.h>

@implementation UILabel (LimitLines)

/**
 文本适应于指定的行数
 @return 文本是否被numberOfLines限制
 */
- (BOOL)my_adjustTextToFitLines:(NSInteger)numberOfLines {
    
    if (!self.text || self.text.length == 0) {
        return NO;
    }
    
    self.numberOfLines = numberOfLines;
    BOOL isLimitedToLines = NO;
    
    CGSize textSize = [self.text textSizeWithFont:self.font
                                    numberOfLines:self.numberOfLines
                                      lineSpacing:self.myLineSpacing
                                 constrainedWidth:self.myConstrainedWidth
                                 isLimitedToLines:&isLimitedToLines];
    
    // 单行的情况
    if (fabs(textSize.height - self.font.lineHeight) < 0.00001f) {
        self.myLineSpacing = 0.0f;
    }
    
    // 设置文字的属性
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:self.myLineSpacing];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;//结尾部分的内容以……方式省略
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(0, [self.text length])];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:self.textColor
                             range:NSMakeRange(0, [self.text length])];
    [attributedString addAttribute:NSFontAttributeName
                             value:self.font
                             range:NSMakeRange(0, [self.text length])];
    [self setAttributedText:attributedString];
    self.bounds = CGRectMake(0, 0, textSize.width, textSize.height);
    return isLimitedToLines;
}

#pragma MARK - setter & getter
/**
 行间距
 */
- (void)setMyLineSpacing:(CGFloat)myLineSpacing {
    
    objc_setAssociatedObject(self, @selector(myLineSpacing), [NSNumber numberWithFloat:myLineSpacing], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)myLineSpacing {
    
    return [objc_getAssociatedObject(self, @selector(myLineSpacing)) floatValue];
}

/**
 最大显示宽度
 */
- (void)setMyConstrainedWidth:(CGFloat)myConstrainedWidth {
    
    objc_setAssociatedObject(self, @selector(myConstrainedWidth), [NSNumber numberWithFloat:myConstrainedWidth], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)myConstrainedWidth {
    
    CGFloat constrainedWidth = [objc_getAssociatedObject(self, @selector(myConstrainedWidth)) floatValue];
    if (constrainedWidth == 0) {
        constrainedWidth = [UIScreen mainScreen].bounds.size.width;
        objc_setAssociatedObject(self, @selector(myConstrainedWidth), [NSNumber numberWithFloat:constrainedWidth], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return constrainedWidth;
}

@end
