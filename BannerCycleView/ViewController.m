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
    // Do any additional setup after loading the view, typically from a nib.
    [self addPagerView];
    [self addPageControl];
    
    [self loadData];
}

- (void)addPagerView {
    FXCyclePagerView *pagerView = [[FXCyclePagerView alloc]init];
    pagerView.layer.borderWidth = 1;
    pagerView.isInfiniteLoop = YES;
    pagerView.autoScrollInterval = 3.0;
    pagerView.dataSource = self;
    pagerView.delegate = self;
    pagerView.layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 60, 200);
    pagerView.layout.itemSpacing = 15;
    // registerClass or registerNib
    [pagerView registerClass:[FXCyclePagerViewCell class] forCellWithReuseIdentifier:@"cellId"];
    [self.view addSubview:pagerView];
    _pagerView = pagerView;
}

- (void)addPageControl {
    FXPageControl *pageControl = [[FXPageControl alloc]init];
    //pageControl.numberOfPages = _datas.count;
    pageControl.currentPageIndicatorSize = CGSizeMake(8, 8);
    //    pageControl.pageIndicatorImage = [UIImage imageNamed:@"Dot"];
    //    pageControl.currentPageIndicatorImage = [UIImage imageNamed:@"DotSelected"];
    //    pageControl.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
    //    pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //    pageControl.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //    [pageControl addTarget:self action:@selector(pageControlValueChangeAction:) forControlEvents:UIControlEventValueChanged];
    [_pagerView addSubview:pageControl];
    _pageControl = pageControl;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _pagerView.frame = CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 200);
    _pageControl.frame = CGRectMake(0, CGRectGetHeight(_pagerView.frame) - 26, CGRectGetWidth(_pagerView.frame), 26);
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

#pragma mark - FXCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(FXCyclePagerView *)pageView {
    return _datas.count;
}

- (UICollectionViewCell *)pagerView:(FXCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    FXCyclePagerViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndex:index];
    cell.backgroundColor = _datas[index];
    cell.label.text = [NSString stringWithFormat:@"index->%ld",index];
    return cell;
}

- (FXCyclePagerViewLayout *)layoutForPagerView:(FXCyclePagerView *)pageView {
    FXCyclePagerViewLayout *layout = [[FXCyclePagerViewLayout alloc]init];
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

#pragma mark - action

//- (IBAction)switchValueChangeAction:(UISwitch *)sender {
//    if (sender.tag == 0) {
//        _pagerView.isInfiniteLoop = sender.isOn;
//        [_pagerView updateData];
//    }else if (sender.tag == 1) {
//        _pagerView.autoScrollInterval = sender.isOn ? 3.0:0;
//    }else if (sender.tag == 2) {
//        _pagerView.layout.itemHorizontalCenter = sender.isOn;
//        [UIView animateWithDuration:0.3 animations:^{
//            [_pagerView setNeedUpdateLayout];
//        }];
//    }
//}
//
//- (IBAction)sliderValueChangeAction:(UISlider *)sender {
//    if (sender.tag == 0) {
//        _pagerView.layout.itemSize = CGSizeMake(CGRectGetWidth(_pagerView.frame)*sender.value, CGRectGetHeight(_pagerView.frame)*sender.value);
//        [_pagerView setNeedUpdateLayout];
//    }else if (sender.tag == 1) {
//        _pagerView.layout.itemSpacing = 30*sender.value;
//        [_pagerView setNeedUpdateLayout];
//    }else if (sender.tag == 2) {
//        _pageControl.pageIndicatorSize = CGSizeMake(6*(1+sender.value), 6*(1+sender.value));
//        _pageControl.currentPageIndicatorSize = CGSizeMake(8*(1+sender.value), 8*(1+sender.value));
//        _pageControl.pageIndicatorSpaing = (1+sender.value)*10;
//    }
//}

- (IBAction)buttonAction:(UIButton *)sender {
    _pagerView.layout.layoutType = sender.tag;
    [_pagerView setNeedUpdateLayout];
}

- (void)pageControlValueChangeAction:(FXPageControl *)sender {
    NSLog(@"pageControlValueChangeAction: %ld",sender.currentPage);
}

@end
