//
//  SkyHomeDataManager.m
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/14.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "SkyHomeDataManager.h"
#import "SkyCategoryModel.h"

@implementation SkyHomeDataManager

+ (SkyHomeDataManager*)share
{
    static SkyHomeDataManager *homeManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        homeManager = [[SkyHomeDataManager alloc]init];
    });
    return homeManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.categoryInfo        = [[NSMutableArray alloc]init];
        [self loadData];
        self.recommendedDataList = [[NSMutableArray alloc]init];
    }
    return self;
}

//MARK: - Load data
- (void)loadData
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"CategoryInfo" ofType:@"plist"];
    NSDictionary *data = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    NSArray *array = [data objectForKey:@"data"];
    for (NSDictionary *item in array) {
        SkyCategoryModel *model = [SkyCategoryModel modelWithJSON:item];
        [self.categoryInfo addObject:model];
    }
}

- (void)getBannerData:(DataParseBlock)dataBlock
{
    [SkyHttpClient requestWithType:SkyHttpRequestTypeGet
                         UrlString:@"http://www.quanmin.tv/json/page/app-data/info.json"
                        Parameters:nil
                      SuccessBlock:^(id responseObject) {
    } FailureBlock:^(NSError *error) {
        
    }];
}

- (void)getRecommendedData:(DataParseBlock)dataBlock
{
    [SkyHttpClient requestWithType:SkyHttpRequestTypeGet
                         UrlString:RECOMMENDED_URL
                        Parameters:nil
                      SuccessBlock:^(id responseObject) {
                          NSArray *dataSoure = [responseObject objectForKey:@"room"];
//                          NSLog(@"推荐 = %@",dataSoure);
                          if (dataSoure.count > 0 )
                          {
                              [dataSoure enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                  SkyCategoryModel *model = [SkyCategoryModel modelWithJSON:obj];
                                  if (model.isDefault)
                                  {
                                      [self.recommendedDataList addObject:model];
                                  }
                              }];
//                              NSLog(@"recommendedlist %td",self.recommendedDataList.count);
                              dataBlock(RES_CODE_OK,@"OK");
                          }else
                          {
                              dataBlock(CH_ERR_DATAPARSE,@"数据错误");
                          }
    } FailureBlock:^(NSError *error) {
        dataBlock(CH_ERR_NETDATA,@"网络错误");
    }];
}


@end




@implementation SkyLinkObjectModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"linkObject" : [SkyLinkObjectModel class]};
}

@end



@implementation SkyBannerModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"banner_id":@"id"};
}

@end

