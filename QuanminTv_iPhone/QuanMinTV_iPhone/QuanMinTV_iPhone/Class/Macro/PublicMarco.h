//
//  PublicMarco.h
//  MiaoBoLive_iPhone
//
//  Created by sky on 16/11/3.
//  Copyright © 2016年 sky. All rights reserved.
//

/**
 *  常用一些宏定义
 */

#ifndef PublicMarco_h
#define PublicMarco_h


//得到屏幕的高
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
//得到屏幕的宽
#define SCREEN_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
//计算比例后的宽度
#define SCREEN_SCALE_WIDTH(w)  (w*(SCREEN_WIDTH/320.0f))
//计算比例后高度
#define SCREEN_SCALE_HEIGHT(h)  (h*(SCREEN_HEIGHT/568.0f))

//白色
#define SYSTEM_STATE_LIGHT  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
//黑色
#define SYSTEM_STATE_BLACK [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];

// 首页的选择器的宽度
#define Home_Seleted_Item_W 60
#define DefaultMargin       10

//直播地址
#define Live_url(x)  [NSString stringWithFormat:@"http://hls.quanmin.tv/live/%td/playlist.m3u8",x]


/////////////////////////////////////////////网络相关/////////////////////////////////////////////
//用户数据处理的block
typedef void (^DataParseBlock)(int code, NSString* msg);
//返回正确
#define RES_CODE_OK                      100
//数据错误
#define CH_ERR_DATAPARSE                 0xe0000001
//网络通讯错误
#define CH_ERR_NETDATA                   0xe0000002

//全民这里经常变化 ~ 我这里写死了

#define QUANMIN_TV_JSON  @"http://www.quanmin.tv/json/"
#define HOME_OTHER_JSON  @"http://www.quanmin.tv/json/categories/"
#define LIST_JSON        @"/list.json?"
#define List_iphone_json @"/list-iphone.json?"
//拼接URL (最后乱拼的时间戳)
#define REQ_URL(x)         [NSString stringWithFormat:@"%@%@%@%@",QUANMIN_TV_JSON,x,LIST_JSON,[SkyStatusHelper getCurrentTimeSP]]
#define REQ_IPHONE_URL(x)  [NSString stringWithFormat:@"%@%@%@%@",QUANMIN_TV_JSON,x,List_iphone_json,[SkyStatusHelper getCurrentTimeSP]]
#define REQ_HOME_OTHER_URL(x)         [NSString stringWithFormat:@"%@%@%@%@",HOME_OTHER_JSON,x,LIST_JSON,[SkyStatusHelper getCurrentTimeSP]]

/** 推荐 */
#define RECOMMENDED_URL     REQ_IPHONE_URL(@"app/index/recommend")

/** 全部 */
#define HOME_ALL_LIST       REQ_URL(@"play")

/** 其他 */
#define HOME_OTHER_LIST(x)  REQ_HOME_OTHER_URL(x)

/** 栏目频道接口 */
#define COLUMN_TABBAR_URL   REQ_HOME_OTHER_URL(@"")

/** 直播频道接口(全部接口) */

////////////////////////////////////////////////////////////////////////////////////////////////


#endif /* PublicMarco_h */
