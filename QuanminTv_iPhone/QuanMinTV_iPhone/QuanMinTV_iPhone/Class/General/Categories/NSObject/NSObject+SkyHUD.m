//
//  NSObject+SkyHUD.m
//  MiaoBoLive
//
//  Created by sky on 16/11/4.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "NSObject+SkyHUD.h"

@implementation NSObject (SkyHUD)

- (void)showInfo:(NSString *)info
{
    if ([self isKindOfClass:[UIViewController class]] || [self isKindOfClass:[UIView class]]) {
        [[[UIAlertView alloc] initWithTitle:@"喵播" message:info delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
    }
}

@end
