//
//  AppDelegate.h
//  MiaoBoLive
//
//  Created by sky on 16/11/3.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)showMainViewController;
- (void)showLoginViewController;
+ (AppDelegate*)shareAppDelegate;

@end

