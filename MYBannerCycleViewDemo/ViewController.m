//
//  ViewController.m
//  MYBannerCycleViewDemo
//
//  Created by QMMac on 2017/2/8.
//  Copyright © 2017 QMMac. All rights reserved.
//

#import "ViewController.h"
#import "MYBannerCycleView.h"
#import "MYBannerCycleViewCell.h"
#import "MYPageControl.h"

@interface ViewController ()<MYBannerCycleViewDelegate, MYBannerCycleViewDataSource>

@property (nonatomic, strong) MYBannerCycleView *bannerCycleView;
@property (nonatomic, strong) MYPageControl *pageControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBannerCycleView];
    
    [self addPageControl];
    
    _pageControl.numberOfPages = 5;
}

- (void)addBannerCycleView {
    MYBannerCycleView *bannerCycleView = [[MYBannerCycleView alloc] init];
    bannerCycleView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 200);
    bannerCycleView.delegate = self;
    bannerCycleView.dataSource = self;
    [bannerCycleView registerClass:[MYBannerCycleViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MYBannerCycleViewCell class])];
    [self.view addSubview:bannerCycleView];
    _bannerCycleView = bannerCycleView;
}

- (void)addPageControl {
    MYPageControl *pageControl = [[MYPageControl alloc]init];
    pageControl.frame = CGRectMake(0, CGRectGetHeight(_bannerCycleView.frame) - 26, CGRectGetWidth(_bannerCycleView.frame), 26);
    pageControl.currentPageIndicatorSize = CGSizeMake(6, 6);
    pageControl.pageIndicatorSize = CGSizeMake(12, 6);
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [_bannerCycleView addSubview:pageControl];
    _pageControl = pageControl;
}

- (NSInteger)numberOfRowsInCycleView:(MYBannerCycleView *)cycleView {
    return 5;
}

- (UICollectionViewCell *)cycleView:(MYBannerCycleView *)cycleView cellForItemAtRow:(NSInteger)row {
    MYBannerCycleViewCell *cell = [cycleView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MYBannerCycleViewCell class]) forRow:row];
    return cell;
}

- (void)cycleView:(MYBannerCycleView *)cycleView didScrollToItemAtRow:(NSInteger)row {
    _pageControl.currentPage = row;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
