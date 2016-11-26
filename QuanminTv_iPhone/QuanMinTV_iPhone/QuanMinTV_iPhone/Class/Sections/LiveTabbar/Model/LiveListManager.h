//
//  LiveListManager.h
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/25.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LIVELIST_MANAGER  [LiveListManager share]

@interface LiveListManager : NSObject

/** 列表数据 */
@property (nonatomic, strong) NSMutableArray *liveListData;

/** 单列 */
+ (LiveListManager*)share;

/** 请求数据 */
- (void)requestLiveListData:(DataParseBlock)block;


//只有下拉,数据就没写 ~

@end
