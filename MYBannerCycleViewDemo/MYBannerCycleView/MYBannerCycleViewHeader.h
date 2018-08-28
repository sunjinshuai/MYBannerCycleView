//
//  MYBannerCycleViewHeader.h
//  MYBannerCycleViewDemo
//
//  Created by QMMac on 2018/8/28.
//  Copyright © 2018 QMMac. All rights reserved.
//

#ifndef MYBannerCycleViewHeader_h
#define MYBannerCycleViewHeader_h

typedef NS_ENUM(NSInteger, MYBannerViewStatus) {
    MYBannerViewStatusIdle = 0,  // 闲置
    MYBannerViewStatusTrigger    // 触发
};

typedef NS_ENUM(NSInteger, BannerViewDirection) {
    BannerViewDirectionLeft = 0,    // 水平向左
    BannerViewDirectionRight,       // 水平向右
    BannerViewDirectionTop,         // 竖直向上
    BannerViewDirectionBottom       // 竖直向下
};

#endif /* MYBannerCycleViewHeader_h */
