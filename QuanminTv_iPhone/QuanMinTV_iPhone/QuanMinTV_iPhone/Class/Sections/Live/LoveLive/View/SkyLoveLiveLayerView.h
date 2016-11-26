//
//  SkyLoveLiveLayerView.h
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/22.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  SkyCategoryListModel;
@interface SkyLoveLiveLayerView : UIView

@property (nonatomic, strong) SkyCategoryListModel *model;

/** 移除定时器 */
- (void)removeTimer;

@end
