//
//  SkyHomeDataManager.h
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/14.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HomeDataManager   [SkyHomeDataManager share]
//这里面只有 推荐的数据
@interface SkyHomeDataManager : NSObject

/** 上面标签数据(写死的) */
@property (nonatomic, strong) NSMutableArray *categoryInfo;

/** 推荐列表数据 */
@property (nonatomic, strong) NSMutableArray *recommendedDataList;

/** 单列 */
+ (SkyHomeDataManager*)share;

/** 得到banner数据 */
- (void)getBannerData:(DataParseBlock)dataBlock;

/** 得到推荐列表数据 */
- (void)getRecommendedData:(DataParseBlock)dataBlock;

@end

/** banner 数据 */

@interface SkyLinkObjectModel : NSObject

@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *app_shuffling_image;
@property (nonatomic, strong) NSString *create_at;
@property (nonatomic, strong) NSString *nick;
@property (nonatomic, strong) NSString *recommend_image;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger uid;

@end



@interface SkyBannerModel : NSObject

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *create_at;
@property (nonatomic, assign) NSInteger banner_id;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) SkyLinkObjectModel *linkObject;

@end

