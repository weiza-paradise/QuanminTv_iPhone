//
//  SkyNetworkTool.m
//  MiaoBoLive
//
//  Created by sky on 16/11/4.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "SkyNetworkTool.h"

@implementation SkyNetworkTool

static SkyNetworkTool *_manager;

+ (instancetype)share
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [SkyNetworkTool manager];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
        // 设置超时时间
        _manager.requestSerializer.timeoutInterval = HTTP_TIMEOUT;
    });
    return _manager;
}




@end
