//
//  SkyRefreshGifHeader.m
//  MiaoBoLive
//
//  Created by sky on 16/11/4.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "SkyRefreshGifHeader.h"

@implementation SkyRefreshGifHeader

- (instancetype)init
{
    if (self = [super init]) {
        self.lastUpdatedTimeLabel.hidden = YES;
        self.stateLabel.hidden = YES;
        [self setImages:@[[UIImage imageNamed:@"img_top_refresh_gy1"],
                          [UIImage imageNamed:@"img_top_refresh_gy2"],
                          [UIImage imageNamed:@"img_top_refresh_gy3"],
                          [UIImage imageNamed:@"img_top_refresh_gy4"],
                          [UIImage imageNamed:@"img_top_refresh_gy5"],
                          [UIImage imageNamed:@"img_top_refresh_gy6"]]
               forState:MJRefreshStateRefreshing];
        
        [self setImages:@[[UIImage imageNamed:@"img_top_refresh_gy1"],
                          [UIImage imageNamed:@"img_top_refresh_gy2"],
                          [UIImage imageNamed:@"img_top_refresh_gy3"],
                          [UIImage imageNamed:@"img_top_refresh_gy4"],
                          [UIImage imageNamed:@"img_top_refresh_gy5"],
                          [UIImage imageNamed:@"img_top_refresh_gy6"]]
               forState:MJRefreshStatePulling];
        
        [self setImages:@[[UIImage imageNamed:@"img_top_refresh_gy1"]]
               forState:MJRefreshStateIdle];
    }
    return self;
}

@end
