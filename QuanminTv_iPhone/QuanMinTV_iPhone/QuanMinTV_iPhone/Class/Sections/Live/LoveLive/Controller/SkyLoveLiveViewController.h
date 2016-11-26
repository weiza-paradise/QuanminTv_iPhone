//
//  SkyLoveLiveViewController.h
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/15.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 颜值直播视图(毕竟有颜) */
@class SkyCategoryListModel;
@interface SkyLoveLiveViewController : UIViewController

@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, strong) NSURL     *thumb;
//
@property (nonatomic, strong) SkyCategoryListModel *model;

@end
