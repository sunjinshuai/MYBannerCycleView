//
//  MYBannerCycleViewCell.m
//  MYBannerCycleViewDemo
//
//  Created by sunjinshuai on 2018/8/26.
//  Copyright © 2018年 QMMac. All rights reserved.
//

#import "MYBannerCycleViewCell.h"
#import <UIColor+Addition.h>
#import <UIImageView+WebCache.h>

@interface MYBannerCycleViewCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation MYBannerCycleViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    self.imageView = [UIImageView new];
    self.imageView.frame = self.contentView.bounds;
    [self.contentView addSubview:self.imageView];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"https://img.zcool.cn/community/01430a572eaaf76ac7255f9ca95d2b.jpg"]];
}

@end
