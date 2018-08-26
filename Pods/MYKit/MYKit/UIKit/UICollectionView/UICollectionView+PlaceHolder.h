//
//  UICollectionView+PlaceHolder.h
//  MYKitDemo
//
//  Created by QMMac on 2018/7/27.
//  Copyright © 2018 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (PlaceHolder)

/**
 my_reloadData 替换 reloadData，自动添加或删除 place holder 视图
 */
- (void)my_reloadData;

@end
