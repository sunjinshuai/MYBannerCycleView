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
#import "MYBannerCycleView.h"
#import "MYBannerFooterView.h"

@interface ViewController ()<MYBannerCycleViewDataSource, MYBannerCycleViewDelegate>

/**
 左右滚动
 */
@property (nonatomic, strong) MYBannerCycleView *bannerCycleView;

/**
 淘宝滚动
 */
@property (nonatomic, strong) MYBannerCycleView *taobaoBannerView;
/**
 上下滚动
 */
@property (nonatomic, strong) MYBannerCycleView *bottomCycleView;

@property (nonatomic, strong) MYPageControl *pageControl;
@property (nonatomic, strong) MYPageControl *taobaoControl;
@property (nonatomic, strong) MYPageControl *bottomPageControl;
@property (nonatomic, strong) MYBannerFooterView *footer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBannerCycleView];
    
    [self addPageControl];
    
    _pageControl.numberOfPages = 6;
    _taobaoControl.numberOfPages = 6;
    _bottomPageControl.numberOfPages = 6;
    
    [self.bannerCycleView reloadData];
    [self.taobaoBannerView reloadData];
    [self.bottomCycleView reloadData];
}

- (void)addBannerCycleView {
    MYBannerCycleView *bannerCycleView = [[MYBannerCycleView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 180)];
    bannerCycleView.delegate = self;
    bannerCycleView.dataSource = self;
    bannerCycleView.emptyImage = [UIImage imageNamed:@"placeholder"];
    bannerCycleView.autoScroll = YES;
    bannerCycleView.repeatCount = 10;
    bannerCycleView.bannerViewScrollDirection = BannerViewDirectionTop;
    [bannerCycleView registerClass:[MYBannerCycleViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MYBannerCycleViewCell class])];
    [self.view addSubview:bannerCycleView];
    _bannerCycleView = bannerCycleView;
    
    MYBannerCycleView *taobaoBannerView = [[MYBannerCycleView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bannerCycleView.frame), [UIScreen mainScreen].bounds.size.width, 180)];
    taobaoBannerView.delegate = self;
    taobaoBannerView.dataSource = self;
    taobaoBannerView.emptyImage = [UIImage imageNamed:@"placeholder"];
    taobaoBannerView.showFooter = YES;
    [taobaoBannerView registerClass:[MYBannerCycleViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MYBannerCycleViewCell class])];
    [taobaoBannerView registerClass:[MYBannerFooterView class] forFooterWithReuseIdentifier:NSStringFromClass([MYBannerFooterView class])];
    [self.view addSubview:taobaoBannerView];
    _taobaoBannerView = taobaoBannerView;
    
    MYBannerCycleView *bottomCycleView = [[MYBannerCycleView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(taobaoBannerView.frame), [UIScreen mainScreen].bounds.size.width, 180)];
    bottomCycleView.delegate = self;
    bottomCycleView.dataSource = self;
    bottomCycleView.emptyImage = [UIImage imageNamed:@"placeholder"];
    [bottomCycleView registerClass:[MYBannerCycleViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MYBannerCycleViewCell class])];
    [self.view addSubview:bottomCycleView];
    _bottomCycleView = bottomCycleView;
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
    
    MYPageControl *taobaoControl = [[MYPageControl alloc]init];
    taobaoControl.frame = CGRectMake(0, CGRectGetHeight(_taobaoBannerView.frame) - 26, CGRectGetWidth(_taobaoBannerView.frame), 26);
    taobaoControl.currentPageIndicatorSize = CGSizeMake(6, 6);
    taobaoControl.pageIndicatorSize = CGSizeMake(12, 6);
    taobaoControl.currentPageIndicatorTintColor = [UIColor redColor];
    taobaoControl.pageIndicatorTintColor = [UIColor grayColor];
    [_taobaoBannerView addSubview:taobaoControl];
    _taobaoControl = taobaoControl;
    
    MYPageControl *bottomPageControl = [[MYPageControl alloc]init];
    bottomPageControl.frame = CGRectMake(0, CGRectGetHeight(_bottomCycleView.frame) - 26, CGRectGetWidth(_bottomCycleView.frame), 26);
    bottomPageControl.currentPageIndicatorSize = CGSizeMake(6, 6);
    bottomPageControl.pageIndicatorSize = CGSizeMake(12, 6);
    bottomPageControl.currentPageIndicatorTintColor = [UIColor redColor];
    bottomPageControl.pageIndicatorTintColor = [UIColor grayColor];
    [_bottomCycleView addSubview:bottomPageControl];
    _bottomPageControl = bottomPageControl;
}

#pragma mark - DataSource
- (NSInteger)numberOfRowsInCycleView:(MYBannerCycleView *)cycleView {
    return 6;
}

- (UICollectionViewCell *)cycleView:(MYBannerCycleView *)cycleView cellForItemAtRow:(NSInteger)row {
    
    MYBannerCycleViewCell *cell = [cycleView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MYBannerCycleViewCell class]) forRow:row];
    return cell;
}

- (UICollectionReusableView *)viewForSupplementaryElementOfFooter:(MYBannerCycleView *)cycleView {
    MYBannerFooterView *footer = [cycleView dequeueReusableEelementKindOfFooterwithReuseIdentifier:NSStringFromClass([MYBannerFooterView class]) forIndex:0];
    footer.IndicateImageName = @"MYBannerCycleView.bundle/arrow.png";
    footer.footerTitleFont = [UIFont systemFontOfSize:12.0f];
    footer.footerTitleColor = [UIColor darkGrayColor];
    footer.idleTitle = @"拖动查看详情";
    footer.triggerTitle = @"释放查看详情";
    self.footer = footer;
    return footer;
}

- (void)footerViewTriggerStatus:(MYBannerViewStatus)status {
    self.footer.status = status;
}

- (void)cycleView:(MYBannerCycleView *)cycleView didScrollToItemAtIndex:(NSInteger)index {
    if (cycleView == self.bannerCycleView) {
        self.pageControl.currentPage = index;
    } else if (cycleView == self.taobaoBannerView) {
        
        self.taobaoControl.currentPage = index;
    } else {
        self.bottomPageControl.currentPage = index;
    }
}

- (void)cycleView:(MYBannerCycleView *)bannerView didSelectItemAtIndex:(NSInteger)index {
    
}

- (void)cycleViewTriggerForFooter:(MYBannerCycleView *)cycleView {
    
}

- (void)cycleView:(MYBannerCycleView *)bannerView didScrollCurrentIndex:(NSInteger)currentIndex contentOffset:(CGFloat)contentOffset {
    NSLog(@"currentIndex-->%d : contentOffset-->%f", currentIndex, contentOffset);
}


@end
