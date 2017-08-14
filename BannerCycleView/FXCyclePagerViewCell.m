//
//  FXCyclePagerViewCell.m
//  FXKitExampleDemo
//
//  Created by sunjinshuai on 2017/8/14.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "FXCyclePagerViewCell.h"

@interface FXCyclePagerViewCell ()

@property (nonatomic, weak) UILabel *label;

@end
@implementation FXCyclePagerViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addLabel];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor clearColor];
        [self addLabel];
    }
    return self;
}


- (void)addLabel {
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:18];
    [self addSubview:label];
    _label = label;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _label.frame = self.bounds;
}

@end
