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

@property (nonatomic, strong) MYBannerCycleView *bannerCycleView;
@property (nonatomic, strong) MYBannerCycleView *goodDetailBannerView;
@property (nonatomic, strong) MYPageControl *pageControl;
@property (nonatomic, strong) MYBannerFooterView *footer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBannerCycleView];
    
    [self addPageControl];
    
    _pageControl.numberOfPages = self.customBannerViewImages.count;
    
    [self.bannerCycleView reloadData];
    [self.goodDetailBannerView reloadData];
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
    
    MYBannerCycleView *goodDetailBannerView = [[MYBannerCycleView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bannerCycleView.frame), [UIScreen mainScreen].bounds.size.width, 180)];
    goodDetailBannerView.delegate = self;
    goodDetailBannerView.dataSource = self;
    goodDetailBannerView.emptyImage = [UIImage imageNamed:@"placeholder"];
    goodDetailBannerView.showFooter = YES;
    [goodDetailBannerView registerClass:[MYBannerCycleViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MYBannerCycleViewCell class])];
    [goodDetailBannerView registerClass:[MYBannerFooterView class] forFooterWithReuseIdentifier:NSStringFromClass([MYBannerFooterView class])];
    [self.view addSubview:goodDetailBannerView];
    _goodDetailBannerView = goodDetailBannerView;
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

#pragma mark - DataSource
- (NSArray *)bannerViewImages:(MYBannerCycleView *)bannerView {
    return self.customBannerViewImages;
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
    self.pageControl.currentPage = index;
}

- (void)cycleView:(MYBannerCycleView *)bannerView didSelectItemAtIndex:(NSInteger)index {
    
}

- (void)cycleViewTriggerForFooter:(MYBannerCycleView *)cycleView {
    
}

- (void)cycleView:(MYBannerCycleView *)bannerView didScrollCurrentIndex:(NSInteger)currentIndex contentOffset:(CGFloat)contentOffset {
    NSLog(@"currentIndex-->%d : contentOffset-->%f", currentIndex, contentOffset);
}

- (NSArray *)customBannerViewImages{
    return @[@"http://img.zcool.cn/community/01f5ce56e112ef6ac72531cb37bec4.png@900w_1l_2o_100sh.jpg",
             @"http://img.zcool.cn/community/01c41656cbf3eb32f875520f71f47a.png",
             @"http://pic.58pic.com/58pic/17/27/94/54d350c57f5f8_1024.jpg"
             ];
}

@end
