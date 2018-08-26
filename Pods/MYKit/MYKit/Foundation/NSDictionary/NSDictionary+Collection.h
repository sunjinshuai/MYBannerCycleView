//
//  NSDictionary+Collection.h
//  Collection
//
//  Created by Jordi Puigdellívol on 10/8/16.
//  Copyright © 2016 Revo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Collection)

+ (NSDictionary * _Nullable)fromData:(NSData* _Nullable)data;
+ (NSDictionary * _Nullable)fromString:(NSString* _Nullable)string;
- (NSString * _Nullable)toString;
- (NSDictionary * _Nullable)except:(NSArray* _Nullable)exceptKeys;
- (NSDictionary* _Nullable)only:(NSArray* _Nullable)keysToKeep;

- (void)each:(void(^ _Nullable)(id _Nonnull key, id _Nonnull object))operation;
- (NSDictionary* _Nullable)filter:(BOOL (^ _Nullable)(id _Nonnull key, id _Nonnull object))condition;
- (NSDictionary* _Nullable)reject:(BOOL (^ _Nullable)(id _Nonnull key, id _Nonnull object))condition;
- (NSDictionary* _Nullable)map:(id _Nonnull (^ _Nullable)(id _Nonnull key, id _Nonnull object))callback;
@end
