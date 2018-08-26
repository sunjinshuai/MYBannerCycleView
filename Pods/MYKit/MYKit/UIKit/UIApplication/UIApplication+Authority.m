//
//  UIApplication+Authority.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2018/3/14.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "UIApplication+Authority.h"
#import <CoreLocation/CoreLocation.h>
#import <Photos/Photos.h>
#import <Contacts/Contacts.h>
#import <AddressBook/AddressBook.h>
#import <EventKit/EventKit.h>

@implementation UIApplication (Authority)

#pragma mark - 权限查询
+ (BOOL)getApplicationLocationPermit {
    
    BOOL authorizedAlways    = [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways;
    BOOL authorizedWhenInUse = [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse;
    
    if (authorizedAlways || authorizedWhenInUse) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)getApplicationAddressBookPermit {
    
    if (@available(iOS 9.0, *)) {
        
        BOOL authorizationStatusAuthorized = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusAuthorized;
        
        return authorizationStatusAuthorized;
        
    } else {
        
        BOOL authorizationStatusAuthorized = ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized;
        
        return authorizationStatusAuthorized;
    }
}

+ (BOOL)getApplicationCameraPermit {
    
    BOOL authorizationStatusAuthorized = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent] == EKAuthorizationStatusAuthorized;
    
    return authorizationStatusAuthorized;
}

+ (BOOL)getApplicationRemindersPermit {
    
    BOOL authorizationStatusAuthorized = [EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder] == EKAuthorizationStatusAuthorized;
    
    return authorizationStatusAuthorized;
}

+ (BOOL)getApplicationPhotosLibraryPermit {
    
    BOOL authorizationStatusAuthorized = [PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized;
    
    return authorizationStatusAuthorized;
}

+ (void)getApplicationMicrophonePermitWithBlock:(CLPermissionBlock)block {
    
    [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
        
        if (block) {
            block(granted);
        }
    }];
}

@end
