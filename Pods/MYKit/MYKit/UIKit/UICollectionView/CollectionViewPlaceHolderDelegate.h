//
//  CollectionViewPlaceHolderDelegate.h
//  MYKitDemo
//
//  Created by QMMac on 2018/7/27.
//  Copyright © 2018 com.51fanxing. All rights reserved.
//

@protocol CollectionViewPlaceHolderDelegate <NSObject>

@required
/*!
 @brief  make an empty overlay view when the tableView is empty
 @return an empty overlay view
 */
- (UIView *)makePlaceHolderView;

@optional
/*!
 @brief enable collectionView scroll when place holder view is showing, it is disabled by default.
 @attention There is no need to return  NO, it will be NO by default
 @return enable collectionView scroll, you can only return YES
 */
- (BOOL)enableScrollWhenPlaceHolderViewShowing;

@end
