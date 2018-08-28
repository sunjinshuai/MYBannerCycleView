//
//  MYBannerCycleView.h
//  MYBannerCycleViewDemo
//
//  Created by QMMac on 2017/2/8.
//  Copyright © 2017 QMMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYBannerCycleViewHeader.h"

@class MYBannerCycleView;

@protocol MYBannerCycleViewDataSource <NSObject>

@required
/**
 显示Banner数据源代理方法
 
 @param bannerView 当前Banner
 @return 兼容 http(s):// 和 本地图片Name 类型: NSString 数组
 */
- (NSArray *)bannerViewImages:(MYBannerCycleView *)bannerView;

/**
 代理方法取轮播子视图（参考UITableView或UICollectionView）
 */
- (UICollectionViewCell *)cycleView:(MYBannerCycleView *)cycleView cellForItemAtRow:(NSInteger)row;

@optional

/**
 footerView
 */
- (UICollectionReusableView *)viewForSupplementaryElementOfFooter:(MYBannerCycleView *)cycleView;

/**
 Footer 高度 默认是 49.0
 */
- (CGFloat)cycleViewFooterViewHeight:(MYBannerCycleView *)cycleView;

@end

@protocol MYBannerCycleViewDelegate <NSObject>

@optional
/**
 滚动到子视图时回调
 */
- (void)cycleView:(MYBannerCycleView *)cycleView didScrollToItemAtIndex:(NSInteger)index;

/**
 子视图点击时回调
 */
- (void)cycleView:(MYBannerCycleView *)bannerView didSelectItemAtIndex:(NSInteger)index;

/**
 Footer 触发
 */
- (void)cycleViewTriggerForFooter:(MYBannerCycleView *)cycleView;

/**
 Footer 状态
 */
- (void)footerViewTriggerStatus:(MYBannerViewStatus)status;

@end

@interface MYBannerCycleView : UIView

@property (nonatomic, weak) id<MYBannerCycleViewDataSource> dataSource;
@property (nonatomic, weak) id<MYBannerCycleViewDelegate> delegate;

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong, readonly) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong, readonly) UICollectionView *collectionView;
/**
 是否循环(default = YES)
 */
@property (nonatomic, assign) BOOL autoScroll;
/**
 自动滚动时间间隔 默认3s
 */
@property (nonatomic, assign) CGFloat autoDuration;
/**
 是否首尾循环 默认是YES
 */
@property (nonatomic, assign) BOOL cycleScrollEnable;
/**
 滚动方向 默认水平向左
 */
@property (nonatomic, assign) BannerViewDirection bannerViewScrollDirection;
/**
 显示footerView
 */
@property (nonatomic, assign) BOOL showFooter;
@property (nonatomic, assign) NSInteger repeatCount;

@property (nonatomic, strong) UIImage *placeholderImage;
@property (nonatomic, strong) UIImage *emptyImage;

@property (nonatomic, copy) void(^didScroll2IndexBlock)(NSInteger index);
@property (nonatomic, copy) void(^didSelectItemAtIndexBlock)(NSInteger index);
@property (nonatomic, copy) void(^didEndTriggerFooterBlock)(void);

- (void)reloadData;

/** 停止定时器接口 */
- (void)invalidateTimerWhenAutoScroll;

/** 重新开启定时器 */
- (void)startTimerWhenAutoScroll;

/** 如果卡屏请在控制器 viewWillAppear 内调用此方法 */
- (void)adjustBannerViewWhenCardScreen;

/**
 滚动到指定索引
 */
- (void)scrollToIndex:(NSInteger)index animation:(BOOL)animation;

/**
 注册子视图
 */
- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;

/**
 从缓存中取重用子视图
 */
- (__kindof UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forRow:(NSInteger)row;

/**
 注册footerView
 */
- (void)registerClass:(nullable Class)viewClass forFooterWithReuseIdentifier:(NSString *)identifier;

/**
 从缓存中取重用footerView
 */
- (__kindof UICollectionReusableView *)dequeueReusableEelementKindOfFooterwithReuseIdentifier:(NSString *)identifier forIndex:(NSInteger)index;

@end
