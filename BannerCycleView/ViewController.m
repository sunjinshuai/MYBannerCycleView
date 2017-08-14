//
//  ViewController.m
//  BannerCycleView
//
//  Created by Michael on 2017/2/8.
//  Copyright © 2017年 com.chinabidding. All rights reserved.
//

#import "ViewController.h"
#import "FXCyclePagerViewCell.h"
#import "FXCyclePagerView.h"
#import "FXPageControl.h"

@interface ViewController ()<FXCyclePagerViewDataSource, FXCyclePagerViewDelegate>

@property (nonatomic, strong) FXCyclePagerView *pagerView;
@property (nonatomic, strong) FXPageControl *pageControl;
@property (nonatomic, strong) NSArray *datas;

@end

@implementation ViewController

static NSString * const identifier = @"FXCyclePagerViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"轮播图";
    
    [self addPagerView];
    [self addPageControl];
    
    [self loadData];
}

#pragma mark - FXCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(FXCyclePagerView *)pageView {
    return _datas.count;
}

- (UICollectionViewCell *)pagerView:(FXCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    FXCyclePagerViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:identifier forIndex:index];
    cell.backgroundColor = _datas[index];
    cell.label.text = [NSString stringWithFormat:@"index->%ld",index];
    return cell;
}

- (FXCyclePagerViewLayout *)layoutForPagerView:(FXCyclePagerView *)pageView {
    FXCyclePagerViewLayout *layout = [[FXCyclePagerViewLayout alloc] init];
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 60, 200);
    layout.itemSpacing = 15;
    layout.itemHorizontalCenter = YES;
    return layout;
}

- (void)pagerView:(FXCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    _pageControl.currentPage = toIndex;
    //[_pageControl setCurrentPage:newIndex animate:YES];
    NSLog(@"%ld ->  %ld",fromIndex,toIndex);
}

- (void)addPageControl {
    FXPageControl *pageControl = [[FXPageControl alloc]init];
    pageControl.currentPageIndicatorSize = CGSizeMake(8, 8);
    [_pagerView addSubview:pageControl];
    _pageControl = pageControl;
}

- (void)loadData {
    NSMutableArray *datas = [NSMutableArray array];
    for (int i = 0; i < 5; ++i) {
        if (i == 0) {
            [datas addObject:[UIColor redColor]];
            continue;
        }
        [datas addObject:[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:arc4random()%255/255.0]];
    }
    _datas = [datas copy];
    _pageControl.numberOfPages = _datas.count;
    [_pagerView reloadData];
}

- (void)addPagerView {
    FXCyclePagerView *pagerView = [[FXCyclePagerView alloc] init];
    pagerView.isInfiniteLoop = YES;
    pagerView.autoScrollInterval = 3.0;
    pagerView.dataSource = self;
    pagerView.delegate = self;
    pagerView.layout.itemHorizontalCenter = YES;
    pagerView.layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 60, 200);
    pagerView.layout.itemSpacing = 15;
    [pagerView registerClass:[FXCyclePagerViewCell class] forCellWithReuseIdentifier:identifier];
    [self.view addSubview:pagerView];
    _pagerView = pagerView;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _pagerView.frame = CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 200);
    _pageControl.frame = CGRectMake(0, CGRectGetHeight(_pagerView.frame) - 26, CGRectGetWidth(_pagerView.frame), 26);
}
@end
