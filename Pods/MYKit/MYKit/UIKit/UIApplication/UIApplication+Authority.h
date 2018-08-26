//
//  UIApplication+Authority.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2018/3/14.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CLPermissionBlock)(BOOL granted);

@interface UIApplication (Authority)

#pragma mark - 权限查询
/**
 获取UIApplication的定位是否授权
 
 @return BOOL
 */
+ (BOOL)getApplicationLocationPermit;

/**
 获取UIApplication的通信录是否授权
 
 @return BOOL
 */
+ (BOOL)getApplicationAddressBookPermit;

/**
 获取UIApplication的相机是否授权
 
 @return BOOL
 */
+ (BOOL)getApplicationCameraPermit;

/**
 获取UIApplication的推送功能是否授权
 
 @return BOOL
 */
+ (BOOL)getApplicationRemindersPermit;

/**
 获取UIApplication的相册是否授权
 
 @return BOOL
 */
+ (BOOL)getApplicationPhotosLibraryPermit;

/**
 获取UIApplication的麦克风是否开启
 
 @param block CLPermissionBlock
 */
+ (void)getApplicationMicrophonePermitWithBlock:(CLPermissionBlock)block;


@end
