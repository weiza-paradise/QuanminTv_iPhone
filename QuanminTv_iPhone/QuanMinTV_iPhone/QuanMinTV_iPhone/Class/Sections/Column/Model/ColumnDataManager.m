//
//  ColumnDataManager.m
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/25.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "ColumnDataManager.h"

@implementation ColumnDataManager

+ (ColumnDataManager*)share
{
    static ColumnDataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ColumnDataManager alloc]init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.columnListData = [[NSMutableArray alloc]init];
    }
    return self;
}

/** 请求数据 */
- (void)requestColumnListData:(DataParseBlock)block
{

    [SkyHttpClient requestWithType:SkyHttpRequestTypeGet
                         UrlString:COLUMN_TABBAR_URL
                        Parameters:nil
                      SuccessBlock:^(id responseObject) {
                          //NSLog(@"栏目数据 = %@",responseObject);
                          if (responseObject)
                          {
                              NSArray *array = [NSArray arrayWithArray:responseObject];
                              [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                  ColumnModel *model = [ColumnModel modelWithJSON:obj];
                                  [self.columnListData addObject:model];
                              }];
                              NSLog(@"self.columnListData.count = %td",self.columnListData.count);
                              block(RES_CODE_OK,@"");
                          }else
                              block(CH_ERR_DATAPARSE,@"数据有误");

    } FailureBlock:^(NSError *error) {
        block(CH_ERR_NETDATA,@"网络有误");
    }];
}

@end


@implementation ColumnModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"columnId":@"id"};
}

@end
