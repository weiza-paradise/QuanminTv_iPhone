//
//  SkyRecommendedViewController.h
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/14.
//  Copyright © 2016年 sky. All rights reserved.
//

/** 点击瞅瞅移动pageview */
typedef  void(^MoveViewController)(NSInteger index);

/** 推荐 */
@interface SkyRecommendedViewController : UICollectionViewController

@property (nonatomic, copy) MoveViewController moveToControllerBlock;

@end
