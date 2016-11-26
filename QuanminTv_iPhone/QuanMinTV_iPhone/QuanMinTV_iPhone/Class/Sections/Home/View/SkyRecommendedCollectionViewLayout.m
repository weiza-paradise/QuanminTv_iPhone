//
//  SkyRecommendedCollectionViewLayout.m
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/14.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "SkyRecommendedCollectionViewLayout.h"

@implementation SkyRecommendedCollectionViewLayout

- (void)prepareLayout
{
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.itemSize = CGSizeMake((SCREEN_WIDTH-30)/2, 155);
    self.minimumLineSpacing      = 10;
    self.minimumInteritemSpacing = 5;
    self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //self.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 30.f);
    self.collectionView.showsHorizontalScrollIndicator = NO;
}

@end
