//
//  SkyNetworkTool.h
//  MiaoBoLive
//
//  Created by sky on 16/11/4.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

//超时时间
#define HTTP_TIMEOUT      10

@interface SkyNetworkTool : AFHTTPSessionManager

+ (instancetype)share;

@end
