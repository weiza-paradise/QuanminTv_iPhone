//
//  SkyHttpClient.h
//  MiaoBoLive
//
//  Created by sky on 16/11/4.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <Foundation/Foundation.h>

#define Sky_NetWork   [SkyHttpClient share]

/** http通讯成功的block */
typedef void (^SkyHTTPRequestSuccessBlock)(id responseObject);
/** http通讯失败后的block */
typedef void (^SkyHTTPRequestFailedBlock)(NSError *error);

/** 获取当前网络状态 */
typedef NS_ENUM(NSUInteger, SkyNetworkStatus)
{
    /** 未知网络 */
    SkyNetworkStatusUnknown           = 0,
    /** 没有网络 */
    SkyNetworkStatusNotReachable,
    /** 2G/3G/4G 网络 */
    SkyNetworkStatusReachableViaWWAN,
    /** wifi */
    SkyNetworkStatusReachableViaWiFi
};

/** 定义请求类型的枚举 */
typedef NS_ENUM(NSUInteger, SkyHttpRequestType)
{
    /** get请求 */
    SkyHttpRequestTypeGet = 0,
    /** post请求 */
    SkyHttpRequestTypePost
};

//超时时间
#define HTTP_TIMEOUT      10

@interface SkyHttpClient : NSObject

/** 获取当前的网络状态 */
@property (nonatomic, assign) SkyHttpRequestType   netWorkStatus;

/** 获得全局唯一的网络请求实例单例方法 */
+ (instancetype)share;


/**
 *  网络请求的实例方法
 *
 *  @param type         get / post (项目目前只支持这倆中)
 *  @param urlString    请求的地址
 *  @param parameters   请求的参数
 *  @param successBlock 请求成功回调
 *  @param failureBlock 请求失败回调
 */
+ (void)requestWithType:(SkyHttpRequestType)type
              UrlString:(NSString *)urlString
             Parameters:(NSDictionary *)parameters
           SuccessBlock:(SkyHTTPRequestSuccessBlock)successBlock
           FailureBlock:(SkyHTTPRequestFailedBlock)failureBlock;



@end
