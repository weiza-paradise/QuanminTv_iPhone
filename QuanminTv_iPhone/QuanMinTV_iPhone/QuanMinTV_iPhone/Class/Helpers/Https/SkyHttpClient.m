//
//  SkyHttpClient.m
//  MiaoBoLive
//
//  Created by sky on 16/11/4.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "SkyHttpClient.h"
#import "AFNetworkActivityIndicatorManager.h"

@implementation SkyHttpClient

static SkyHttpClient *httpClient;

+ (instancetype)share
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpClient = [[self alloc]init];
    });
    return httpClient;
}


static AFHTTPSessionManager *magager;

+ (AFHTTPSessionManager *)sharedAFManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        magager = [AFHTTPSessionManager manager];
        magager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
        // 设置超时时间
        magager.requestSerializer.timeoutInterval = HTTP_TIMEOUT;
    });
    return magager;
}

+ (void)requestWithType:(SkyHttpRequestType)type
              UrlString:(NSString *)urlString
             Parameters:(NSDictionary *)parameters
           SuccessBlock:(SkyHTTPRequestSuccessBlock)successBlock
           FailureBlock:(SkyHTTPRequestFailedBlock)failureBlock
{
    if (urlString == nil)
    {
        return;
    }
    NSString *URLString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    if (type == SkyHttpRequestTypeGet)
    {
        
        [[self sharedAFManager] GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           
            if (successBlock)
            {
                successBlock(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (failureBlock)
            {
                failureBlock(error);
            }
            
        }];
    }else if (type == SkyHttpRequestTypePost)
    {
    
        [[self sharedAFManager] POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (successBlock)
            {
                successBlock(responseObject);
            }

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           
            if (failureBlock)
            {
                failureBlock(error);
            }

        }];
    }
    
}

+ (void)ba_startNetWorkMonitoring
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                NSLog(@"未知网络");
                Sky_NetWork.netWorkStatus = SkyNetworkStatusUnknown;
                break;
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                NSLog(@"没有网络");
                Sky_NetWork.netWorkStatus = SkyNetworkStatusNotReachable;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 2G/3G/4G
                NSLog(@"手机自带网络");
                Sky_NetWork.netWorkStatus = SkyNetworkStatusReachableViaWWAN;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                Sky_NetWork.netWorkStatus = SkyNetworkStatusReachableViaWiFi;
                NSLog(@"WIFI--%lu", (unsigned long)Sky_NetWork.netWorkStatus);
                break;
        }
    }];
    [manager startMonitoring];
}

@end
