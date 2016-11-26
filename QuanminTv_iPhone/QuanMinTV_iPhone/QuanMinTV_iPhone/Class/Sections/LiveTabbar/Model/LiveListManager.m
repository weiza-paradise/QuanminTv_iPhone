//
//  LiveListManager.m
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/25.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "LiveListManager.h"
#import "SkyOtherDataManager.h"

@class SkyCategoryModel;
@implementation LiveListManager

+ (LiveListManager*)share
{
    static LiveListManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LiveListManager alloc]init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.liveListData = [[NSMutableArray alloc]init];
    }
    return self;
}

/** 请求数据 */
- (void)requestLiveListData:(DataParseBlock)block
{
    [SkyHttpClient requestWithType:SkyHttpRequestTypeGet
                         UrlString:HOME_ALL_LIST
                        Parameters:nil
                      SuccessBlock:^(id responseObject) {
                          //NSLog(@"直播列表数据 = %@",responseObject);
                          if (responseObject)
                          {
                              SkyOtherModel * model = [SkyOtherModel modelWithJSON:responseObject];
                              [model.data enumerateObjectsUsingBlock:^(SkyCategoryListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                  [self.liveListData addObject:obj];
                              }];
                              block(RES_CODE_OK,@"");
                          }else
                              block(CH_ERR_DATAPARSE,@"数据有误");
                          
                      } FailureBlock:^(NSError *error) {
                          block(CH_ERR_NETDATA,@"网络有误");
                      }];
}
@end
