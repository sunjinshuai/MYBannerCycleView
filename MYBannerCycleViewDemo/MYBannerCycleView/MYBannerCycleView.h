//
//  MYBannerCycleView.h
//  MYBannerCycleViewDemo
//
//  Created by QMMac on 2017/2/8.
//  Copyright © 2017 QMMac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BannerCyclePageControlPosition) {
    BannerCyclePageControlPositionCenter, // default
    BannerCyclePageControlPositionLeft,   // left
    BannerCyclePageControlPositionRight,  // right
};
@class MYBannerCycleView;

@protocol MYBannerCycleViewDataSource <NSObject>

@required
/**
 *  代理方法取轮播总数（参考UITableView或UICollectionView）
 *
 *  @param cycleView 轮播视图
 *
 *  @return 轮播总数
 */
- (NSInteger)numberOfRowsInCycleView:(MYBannerCycleView *)cycleView;
/**
 *  代理方法取轮播子视图（参考UITableView或UICollectionView）
 *
 *  @param cycleView 轮播视图
 *  @param row       子视图索引
 *
 *  @return 轮播子视图（继承自系统UICollectionViewCell）
 */
- (UICollectionViewCell *)cycleView:(MYBannerCycleView *)cycleView cellForItemAtRow:(NSInteger)row;

@end

@protocol MYBannerCycleViewDelegate <NSObject>

@optional
/**
 *  代理方法取子视图大小
 *
 *  @param cycleView 轮播视图
 *  @param row       子视图索引
 *
 *  @return 子视图大小
 */
- (CGSize)cycleView:(MYBannerCycleView *)cycleView sizeForItemAtRow:(NSInteger)row;
/**
 *  代理方法视图滚动到子视图时回调
 *
 *  @param cycleView 滚动视图
 *  @param row       子视图索引
 */
- (void)cycleView:(MYBannerCycleView *)cycleView didScrollToItemAtRow:(NSInteger)row;
/**
 *  代理方法子视图点击时回调
 *
 *  @param cycleView 滚动视图
 *  @param row       子视图索引
 */
- (void)cycleView:(MYBannerCycleView *)cycleView didSelectItemAtRow:(NSInteger)row;

@end

@interface MYBannerCycleView : UIView

/** 子视图大小 */
@property (nonatomic, assign) CGSize itemSize;
/** 子视图间隔 */
@property (nonatomic, assign) CGFloat itemSpace;
/** 数据源 */
@property (nonatomic, weak) id <MYBannerCycleViewDataSource> dataSource;
/** 代理 */
@property (nonatomic, weak) id <MYBannerCycleViewDelegate> delegate;
/** 当前索引 */
@property (nonatomic, assign, readonly) NSInteger index;
/** 是否显示页面指示器 */
@property (nonatomic, assign) BOOL showPageControl;
/** 页面指示器显示位置 */
@property (nonatomic, assign) BannerCyclePageControlPosition pageControlPosition;
/** 用于设置页面指示器位置偏移 */
@property (nonatomic, assign) CGPoint pageControlOffset;
/** 是否循环(default = YES) */
@property (nonatomic, assign) BOOL cycleEnabled;
/** 自动滚动间隔(default = 0) */
@property (nonatomic, assign) CGFloat timeInterval;

/** 重新载入视图 */
- (void)reloadData;
/** 滚动到下一个子视图 */
- (void)scrollToNextIndex;
/** 滚动到上一个子视图 */
- (void)scrollToPreviousIndex;
/** 滚动到指定索引 */
- (void)scrollToIndex:(NSInteger)index animation:(BOOL)animation;
/**
 *  注册子视图
 *
 *  @param cellClass  子视图类
 *  @param identifier 子视图重用标示
 */
- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;
/**
 *  从缓存中取重用子视图
 *
 *  @param identifier 子视图重用标示
 *  @param row        子视图索引
 *
 *  @return 重用的子视图
 */
- (__kindof UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forRow:(NSInteger)row;

@end
