//
//  Harpy.h
//  Harpy
//
//  Created by Arthur Ariel Sabintsev on 11/14/12.
//  Copyright (c) 2012 Arthur Ariel Sabintsev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LBHarpyDelegate <NSObject>

- (void)getAppStoreVersionSuccess:(NSString *)appStoreVersion;

@end

@interface LBHarpy : NSObject <UIAlertViewDelegate>

/*
  Checks the installed version of your application against the version currently available on the iTunes store.
  If a newer version exists in the AppStore, it prompts the user to update your app.
 */
+ (void)checkVersion;
+ (NSString *)getAppStoreVersion:(id)delegate;

@end
