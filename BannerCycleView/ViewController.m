//
//  ViewController.m
//  BannerCycleView
//
//  Created by Michael on 2017/2/8.
//  Copyright © 2017年 com.chinabidding. All rights reserved.
//

#import "ViewController.h"
#import "BannerCycleView.h"
#import "BannerViewCell.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen]bounds].size.width)

@interface ViewController ()<BannerCycleViewDelegate,BannerCycleViewDataSource>

@property (nonatomic, strong) BannerCycleView *cycleView;

@end

@implementation ViewController

static NSString * const reusableProductViewIdentifier = @"BannerViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.cycleView];
}

#pragma mark - BannerCycleViewDataSource
- (NSInteger)numberOfRowsInCycleView:(BannerCycleView *)cycleView
{
    return 4;
}

- (UICollectionViewCell *)cycleView:(BannerCycleView *)cycleView cellForItemAtRow:(NSInteger)row
{
    BannerViewCell *cell = (BannerViewCell *)[cycleView dequeueReusableCellWithReuseIdentifier:reusableProductViewIdentifier forRow:row];
    return cell;
}

- (CGSize)cycleView:(BannerCycleView *)cycleView sizeForItemAtRow:(NSInteger)row
{
    return CGSizeMake(SCREEN_WIDTH - 40, 180);
}

#pragma mark - getter and setter
- (BannerCycleView *)cycleView
{
    if (_cycleView == nil) {
        _cycleView = [[BannerCycleView alloc] initWithType:BannerCycleViewTypeDefault];
        _cycleView.frame = CGRectMake(0, 200, SCREEN_WIDTH, 200);
        _cycleView.itemSize = CGSizeMake(SCREEN_WIDTH - 40, 180);
        _cycleView.dataSource = self;
        _cycleView.delegate = self;
        _cycleView.showPageControl = YES;
        _cycleView.itemSpace = 5;
        _cycleView.itemMargin = 20;
        _cycleView.timeInterval = 2.f;
        [_cycleView registerClass:[BannerViewCell class] forCellWithReuseIdentifier:reusableProductViewIdentifier];
    }
    return _cycleView;
}

@end
