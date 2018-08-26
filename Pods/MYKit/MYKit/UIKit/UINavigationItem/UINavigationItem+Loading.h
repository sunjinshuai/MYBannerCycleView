//
//  UINavigationItem+Loading.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/9/6.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Position to show UIActivityIndicatorView in a navigation bar
 */
typedef NS_ENUM(NSUInteger, ANNavBarLoaderPosition){
    /**
     *  Will show UIActivityIndicatorView in place of title view
     */
    ANNavBarLoaderPositionCenter = 0,
    /**
     *  Will show UIActivityIndicatorView in place of left item
     */
    ANNavBarLoaderPositionLeft,
    /**
     *  Will show UIActivityIndicatorView in place of right item
     */
    ANNavBarLoaderPositionRight
};

@interface UINavigationItem (Loading)

/**
 *  Add UIActivityIndicatorView to view hierarchy and start animating immediately
 *
 *  @param position Left, center or right
 */
- (void)startAnimatingAt:(ANNavBarLoaderPosition)position;

/**
 *  Stop animating, remove UIActivityIndicatorView from view hierarchy and restore item
 */
- (void)stopAnimating;

@end
