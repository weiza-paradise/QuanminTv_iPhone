//
//  SkyCollectionViewCell.h
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/14.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 非颜值cell */
@class SkyCategoryListModel;

@interface SkyCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)   UIColor *titleBGColor;
@property (nonatomic, strong)   SkyCategoryListModel *categoryListModel;

@end
