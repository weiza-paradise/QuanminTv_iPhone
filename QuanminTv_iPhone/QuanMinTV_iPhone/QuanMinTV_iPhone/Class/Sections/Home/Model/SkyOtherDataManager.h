//
//  SkyOtherDataManager.h
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/14.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HOME_OTHER_MANAGER [SkyOtherDataManager share]

@class SkyCategoryModel;
@interface SkyOtherDataManager : NSObject

//@property (nonatomic, strong) NSMutableDictionary *otherAllData;

//@property (nonatomic, strong) SkyCategoryModel    *categoryModel;

/** 单利 */
//+ (SkyOtherDataManager*)share;

///**
// *  得到数据列表
// *
// *  @param slug        列表名称
// *  @param type        0 下拉， 1 上拉
// *  @param dataBlocks  结果
// */
//
//- (void)getOtherAllListDataWithSlug:(NSString*)slug
//                               type:(int)type
//                              block:(DataParseBlock)dataBlocks;

@end



@class SkyCategoryListModel;

@interface SkyOtherModel : NSObject

/** 总页数 */
@property (nonatomic, assign) NSInteger pageCount;
/** 当前页数 */
@property (nonatomic, assign) NSInteger page;
/** 一页多少个 */
@property (nonatomic, assign) NSInteger size;
/** 总个数 */
@property (nonatomic, assign) NSInteger total;
/** 下一页 */
@property (nonatomic)         int       nextPage;
/** 数据 */
@property (nonatomic, strong) NSMutableArray<SkyCategoryListModel *> *data;

@end
