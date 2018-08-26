//
//  MYBannerCycleViewCell.m
//  MYBannerCycleViewDemo
//
//  Created by sunjinshuai on 2018/8/26.
//  Copyright © 2018年 QMMac. All rights reserved.
//

#import "MYBannerCycleViewCell.h"
#import <UIColor+Addition.h>

@implementation MYBannerCycleViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor randomColor];
    }
    return self;
}

@end
