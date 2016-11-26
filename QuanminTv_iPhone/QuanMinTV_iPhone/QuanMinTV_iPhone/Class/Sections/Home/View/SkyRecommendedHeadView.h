//
//  SkyRecommendedHeadView.h
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/14.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 点击 瞅瞅 */
typedef void(^SeletedLookBtn)();

@interface SkyRecommendedHeadView : UICollectionReusableView

@property (nonatomic, strong) NSString *title;

@property (nonatomic, copy)   SeletedLookBtn selectedLookBlack;

@end
