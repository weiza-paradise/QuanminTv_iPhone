//
//  SkyCategoryModel.h
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/14.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SkyCategoryListModel;
@interface SkyCategoryModel : NSObject

/** 名字 */
@property (nonatomic, strong) NSString  *name ;
/**  */
@property (nonatomic, assign) NSInteger categoryId;
/**  */
@property (nonatomic, assign) NSInteger screen;
/** 1为推荐 2为其它 */
@property (nonatomic, assign) NSInteger type;
/** 是否显示在推荐列表 */
@property (nonatomic, assign) NSInteger isDefault;
/** 类型 空为推荐 */
@property (nonatomic, strong) NSString  *slug;
/** 数据 */
@property (nonatomic, strong) NSArray<SkyCategoryListModel *> *list;

@end


/** 列表数据 */
@interface SkyCategoryListModel : NSObject

/** 大图地址 */
@property (nonatomic, strong) NSURL    *thumb;
/** 标题 */
@property (nonatomic, strong) NSString *title;
/** 头像 */
@property (nonatomic, strong) NSURL    *avatar;
/** 名字 */
@property (nonatomic, strong) NSString *nick;
/** uid */
@property (nonatomic, assign) NSInteger uid;
/** 观看人数 */
@property (nonatomic, strong) NSString *view;
/** 类型名字 */
@property (nonatomic, strong) NSString *categoryName;
/** 类型id */
@property (nonatomic, strong) NSString *categoryId;
/** 类型 */
@property (nonatomic, strong) NSString *categorySlug;


@end
