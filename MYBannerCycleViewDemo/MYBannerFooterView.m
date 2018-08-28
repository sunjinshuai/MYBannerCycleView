//
//  MYBannerFooterView.m
//  MYBannerCycleViewDemo
//
//  Created by QMMac on 2018/8/28.
//  Copyright © 2018 QMMac. All rights reserved.
//

#import "MYBannerFooterView.h"

@interface MYBannerFooterView ()

@property (nonatomic, strong) UIImageView *arrowView;
@property (nonatomic, strong) UILabel *label;

@end

@implementation MYBannerFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.arrowView];
        [self addSubview:self.label];
        
        self.status = MYBannerViewStatusIdle;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat arrowWH = 15;
    
    CGFloat arrowX = self.bounds.size.width * 0.5 - arrowWH - 2.5;
    CGFloat arrowY = (self.bounds.size.height - arrowWH) * 0.5;
    
    self.arrowView.frame = CGRectMake(arrowX, arrowY, arrowWH, arrowWH);
    
    CGFloat labelX = self.bounds.size.width * 0.5 + 2.5;
    CGFloat labelY = 0;
    CGFloat labelW = arrowWH;
    CGFloat labelH = self.bounds.size.height;
    self.label.frame = CGRectMake(labelX, labelY, labelW, labelH);
}

#pragma mark - setters & getters
- (void)setStatus:(MYBannerViewStatus)status {
    
    _status = status;
    switch (status) {
        case MYBannerViewStatusIdle: {
            self.label.text = self.idleTitle;
            [UIView animateWithDuration:0.25 animations:^{
                self.arrowView.transform = CGAffineTransformMakeRotation(0);
            }];
        }
            break;
        case MYBannerViewStatusTrigger: {
            self.label.text = self.triggerTitle;
            [UIView animateWithDuration:0.25 animations:^{
                self.arrowView.transform = CGAffineTransformMakeRotation(M_PI);
            }];
        }
            break;
        default:
            self.label.text = self.idleTitle;
            [UIView animateWithDuration:0.25 animations:^{
                self.arrowView.transform = CGAffineTransformMakeRotation(0);
            }];
            break;
    }
}

- (void)setFooterTitleFont:(UIFont *)footerTitleFont{
    _footerTitleFont = footerTitleFont;
    self.label.font = _footerTitleFont;
}

- (void)setFooterTitleColor:(UIColor *)footerTitleColor{
    _footerTitleColor = footerTitleColor;
    self.label.textColor = _footerTitleColor;
}

- (void)setIndicateImageName:(NSString *)IndicateImageName{
    _IndicateImageName = IndicateImageName;
    if (_IndicateImageName.length > 0 && self.arrowView.image == nil) {
        self.arrowView.image = [UIImage imageNamed:_IndicateImageName];
    }
}

- (void)setIdleTitle:(NSString *)idleTitle{
    _idleTitle = idleTitle;
    if (self.status == MYBannerViewStatusIdle) {
        self.label.text = idleTitle;
    }
}

- (void)setTriggerTitle:(NSString *)triggerTitle{
    _triggerTitle = triggerTitle;
    if (self.status == MYBannerViewStatusTrigger) {
        self.label.text = triggerTitle;
    }
}
- (UIImageView *)arrowView {
    if (!_arrowView) {
        _arrowView = [[UIImageView alloc] init];
    }
    return _arrowView;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.numberOfLines = 0;
    }
    return _label;
}

@end
