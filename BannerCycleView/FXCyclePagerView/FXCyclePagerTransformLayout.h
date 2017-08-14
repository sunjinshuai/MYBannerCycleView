//
//  FXCyclePagerTransformLayout.h
//  FXKitExampleDemo
//
//  Created by sunjinshuai on 2017/8/11.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, FXCyclePagerTransformLayoutType) {
    FXCyclePagerTransformLayoutNormal,
    FXCyclePagerTransformLayoutLinear,
    FXCyclePagerTransformLayoutCoverflow,
};

@class FXCyclePagerTransformLayout;
@protocol FXCyclePagerTransformLayoutDelegate <NSObject>

// initialize layout attributes
- (void)pagerViewTransformLayout:(FXCyclePagerTransformLayout *)pagerViewTransformLayout initializeTransformAttributes:(UICollectionViewLayoutAttributes *)attributes;

// apply layout attributes
- (void)pagerViewTransformLayout:(FXCyclePagerTransformLayout *)pagerViewTransformLayout applyTransformToAttributes:(UICollectionViewLayoutAttributes *)attributes;

@end


@interface FXCyclePagerViewLayout : NSObject

@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGFloat itemSpacing;
@property (nonatomic, assign) UIEdgeInsets sectionInset;

@property (nonatomic, assign) FXCyclePagerTransformLayoutType layoutType;

@property (nonatomic, assign) CGFloat minimumScale; // sacle default 0.8
@property (nonatomic, assign) CGFloat minimumAlpha; // alpha default 1.0
@property (nonatomic, assign) CGFloat maximumAngle; // angle is % default 0.2

@property (nonatomic, assign) BOOL isInfiniteLoop;  // infinte scroll
@property (nonatomic, assign) CGFloat rateOfChange; // scale and angle change rate
@property (nonatomic, assign) BOOL adjustSpacingWhenScroling;

/**
 pageView cell item vertical centering
 */
@property (nonatomic, assign) BOOL itemVerticalCenter;

/**
 first and last item horizontalc enter, when isInfiniteLoop is NO
 */
@property (nonatomic, assign) BOOL itemHorizontalCenter;

// sectionInset
@property (nonatomic, assign, readonly) UIEdgeInsets onlyOneSectionInset;
@property (nonatomic, assign, readonly) UIEdgeInsets firstSectionInset;
@property (nonatomic, assign, readonly) UIEdgeInsets lastSectionInset;
@property (nonatomic, assign, readonly) UIEdgeInsets middleSectionInset;

@end


@interface FXCyclePagerTransformLayout : UICollectionViewFlowLayout

@property (nonatomic, strong) FXCyclePagerViewLayout *layout;

@property (nonatomic, weak, nullable) id<FXCyclePagerTransformLayoutDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
