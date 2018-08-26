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

@interface ViewController ()<MYBannerCycleViewDelegate, MYBannerCycleViewDataSource>

@property (nonatomic, strong) MYBannerCycleView *bannerCycleView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBannerCycleView];
}

- (void)addBannerCycleView {
    MYBannerCycleView *bannerCycleView = [[MYBannerCycleView alloc] init];
    bannerCycleView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 200);
    bannerCycleView.delegate = self;
    bannerCycleView.dataSource = self;
    [bannerCycleView registerClass:[MYBannerCycleViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MYBannerCycleViewCell class])];
    [self.view addSubview:bannerCycleView];
}


- (NSInteger)numberOfRowsInCycleView:(MYBannerCycleView *)cycleView {
    return 5;
}

- (UICollectionViewCell *)cycleView:(MYBannerCycleView *)cycleView cellForItemAtRow:(NSInteger)row {
    MYBannerCycleViewCell *cell = [cycleView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MYBannerCycleViewCell class]) forRow:row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
