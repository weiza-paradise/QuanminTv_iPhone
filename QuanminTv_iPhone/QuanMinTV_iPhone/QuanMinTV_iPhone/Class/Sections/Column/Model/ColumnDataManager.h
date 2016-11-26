//
//  ColumnDataManager.h
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/25.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <Foundation/Foundation.h>

#define COLUMN_MANAGER  [ColumnDataManager share]

@interface ColumnDataManager : NSObject

/** 列表数据 */
@property (nonatomic, strong) NSMutableArray *columnListData;

/** 单列 */
+ (ColumnDataManager*)share;

/** 请求数据 */
- (void)requestColumnListData:(DataParseBlock)block;

@end




@interface ColumnModel : NSObject
/** 栏目id */
@property (nonatomic)   int columnId;
/** 栏目名字 */
@property (nonatomic, strong) NSString *name;
/** 栏目类型 */
@property (nonatomic, strong) NSString *slug;
/**  */
@property (nonatomic, strong) NSString *first_letter;
/** 状态 */
@property (nonatomic)   int  status;
/**  */
@property (nonatomic)   int  prompt;
/**  */
@property (nonatomic, strong) NSURL *image;
/**  */
@property (nonatomic, strong) NSURL *thumb;
/** 优先级 */
@property (nonatomic)   int priority;
/** 栏目类型 */
@property (nonatomic)   int screen;

@end


