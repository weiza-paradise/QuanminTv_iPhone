//
//  SkyLoveCollectionViewCell.m
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/14.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "SkyLoveCollectionViewCell.h"
#import "SkyCategoryModel.h"

@interface SkyLoveCollectionViewCell ()

@property (nonatomic, strong) UIImageView *bigImageView;

@end

@implementation SkyLoveCollectionViewCell

- (UIImageView*)bigImageView
{
    if (!_bigImageView) {
        _bigImageView = [[UIImageView alloc]init];
        _bigImageView.clipsToBounds = YES;
        _bigImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bigImageView.backgroundColor = Home_List_BGColor;
        _bigImageView.frame = self.bounds;
    }
    return _bigImageView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.bigImageView];
    }
    return self;
}

- (void)setCategoryListModel:(SkyCategoryListModel *)categoryListModel
{
    _categoryListModel = categoryListModel;
    [self.bigImageView setImageWithURL:categoryListModel.thumb placeholder:[UIImage imageNamed:@"img_yanzhi_content_default_172x172_"]];
}

@end
