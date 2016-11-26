//
//  SkyStatusHelper.h
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/15.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SkyStatusHelper : NSObject

/** 获取当前时间戳 */
+(NSString *)getCurrentTimeSP;

/** 圆角头像manager */
+ (YYWebImageManager *)avatarImageManager;

/**
 *  切换横竖屏
 *
 *  @param orientation ：UIInterfaceOrientation
 */
+ (void)forceOrientation: (UIInterfaceOrientation)orientation;

/**
 *  判断是否竖屏
 *
 *  @return 布尔值
 */
+ (BOOL)isOrientationLandscape;
@end
