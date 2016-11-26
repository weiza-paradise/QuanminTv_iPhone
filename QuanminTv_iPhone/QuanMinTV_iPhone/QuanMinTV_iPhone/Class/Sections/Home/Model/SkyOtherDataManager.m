//
//  SkyOtherDataManager.m
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/14.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "SkyOtherDataManager.h"
#import "SkyCategoryModel.h"

//全部的接口 http://www.quanmin.tv/json/play/list.json?1114223726
//其它(love频道名称) http://www.quanmin.tv/json/categories/love/list.json?1114223734

@implementation SkyOtherDataManager
/*
+ (SkyOtherDataManager*)share
{
    static SkyOtherDataManager *otherManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        otherManager = [[SkyOtherDataManager alloc]init];
    });
    return otherManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.otherAllData = [[NSMutableDictionary alloc]init];
    }
    return self;
}
*/
//- (void)getOtherAllListDataWithSlug:(NSString*)slug
//                               type:(int)type
//                              block:(DataParseBlock)dataBlocks
//{
//    __block SkyOtherModel *otherModel = [self.otherAllData objectForKey:slug];
//    int cursor = 0;
//    if (otherModel)
//    {
//        if (type == 1)//上拉
//        {
//            otherModel.nextPage ++ ;
//            cursor = otherModel.nextPage;
//        }
//    }else return; //必须存在
//    
//    BOOL isPlay = NO;
//    isPlay = [slug isEqualToString:@"play"] ? YES : NO ; //是否是全部
//    
//    [SkyHttpClient requestWithType:SkyHttpRequestTypeGet
//                         UrlString:isPlay ? HOME_ALL_LIST : HOME_OTHER_LIST(slug)
//                        Parameters:nil
//                      SuccessBlock:^(id responseObject) {
//                          NSLog(@"列表数据 思密达 = %@",responseObject);
//                          NSArray *listdata = [responseObject objectForKey:@"data"];
//                          if (listdata.count)
//                          {
////                              if (type == 0)//下来清除数据
////                                  [otherModel clear];
//                              //没上拉刷新
//                              otherModel = [SkyOtherModel modelWithJSON:responseObject];
//                              otherModel.categoryName = slug;
//                              //添加到数据源
//                              [self.otherAllData setObject:otherModel forKey:slug];
//                              dataBlocks(RES_CODE_OK,@"OK");
//                          }else
//                          {
//                              dataBlocks(CH_ERR_DATAPARSE,@"数据错误");
//                          }
//                          
//                          
//    } FailureBlock:^(NSError *error) {
//        dataBlocks(CH_ERR_NETDATA,@"网络❎");
//    }];
//    
//}

@end




@implementation SkyOtherModel

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if (_data.count != 0)
    {
        NSMutableArray *mList = [NSMutableArray new];
        for (NSDictionary *category in _data)
        {
            SkyCategoryListModel *model  = [SkyCategoryListModel modelWithJSON:category];
            [mList addObject:model];
        }
        _data = mList;
    }
    return YES;
}

@end
