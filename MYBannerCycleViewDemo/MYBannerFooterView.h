//
//  MYBannerFooterView.h
//  MYBannerCycleViewDemo
//
//  Created by QMMac on 2018/8/28.
//  Copyright © 2018 QMMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYBannerCycleViewHeader.h"

@interface MYBannerFooterView : UICollectionReusableView

@property (nonatomic, assign) MYBannerViewStatus status;
@property (nonatomic, strong) UIFont *footerTitleFont;
@property (nonatomic, strong) UIColor *footerTitleColor;
@property (nonatomic, copy) NSString *IndicateImageName;    /**< 指示图片的名字 */
@property (nonatomic, copy) NSString *idleTitle;            /**< 闲置 */
@property (nonatomic, copy) NSString *triggerTitle;         /**< 触发 */


@end
