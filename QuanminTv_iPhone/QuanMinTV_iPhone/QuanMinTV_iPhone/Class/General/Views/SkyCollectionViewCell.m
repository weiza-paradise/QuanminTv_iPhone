//
//  SkyCollectionViewCell.m
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/14.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "SkyCollectionViewCell.h"
#import "SkyCategoryModel.h"

@interface SkyCollectionViewCell ()


@property (nonatomic, strong) UIImageView *bigImageView;
@property (nonatomic, strong) UIImageView *headImage;
//这里写反了 ~
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *msgLaebl;

@end

@implementation SkyCollectionViewCell

- (UIImageView*)bigImageView
{
    if (!_bigImageView) {
        _bigImageView = [[UIImageView alloc]init];
        _bigImageView.clipsToBounds = YES;
        _bigImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bigImageView.backgroundColor = Home_List_BGColor;
        _bigImageView.width  = self.contentView.width;
        _bigImageView.height = SCREEN_SCALE_HEIGHT(97.f);
        _bigImageView.left   =
        _bigImageView.top    =
        _bigImageView.right  = 0 ;
    }
    return _bigImageView;
}

- (UIImageView*)headImage
{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        _headImage.clipsToBounds = YES;
        _headImage.contentMode = UIViewContentModeScaleToFill;
        _headImage.backgroundColor = Home_List_BGColor;
        _headImage.left = 0 ;
        _headImage.top  = self.bigImageView.bottom + 10.f ;
        _headImage.size = CGSizeMake(32, 32);
    }
    return _headImage;
}

- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.backgroundColor = Home_List_BGColor;
        _titleLabel.layer.masksToBounds = YES;
        _titleLabel.textColor = HexRGB(0x373c3f);
        _titleLabel.text   = @"title";
        _titleLabel.font   = [UIFont systemFontOfSize:12.f];
        _titleLabel.left   = self.headImage.right + 5.f ;
        _titleLabel.top    = self.headImage.top;
        _titleLabel.height = 15.f;
        _titleLabel.width  = self.contentView.width - self.headImage.right - 10.f;
    }
    return _titleLabel;
}

- (UILabel*)msgLaebl
{
    if (!_msgLaebl) {
        _msgLaebl = [[UILabel alloc]init];
        _msgLaebl.backgroundColor = Home_List_BGColor;
        _msgLaebl.layer.masksToBounds = YES;
        _msgLaebl.textColor = HexRGB(0xabb0b4);
        _msgLaebl.text    = @"msg";
        _msgLaebl.font    = [UIFont systemFontOfSize:11.f];
        _msgLaebl.left    = self.titleLabel.left;
        _msgLaebl.top     = self.titleLabel.bottom + 2.f;
        _msgLaebl.height  = self.titleLabel.height;
        _msgLaebl
        .width = self.titleLabel.width;
    }
    return _msgLaebl;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.bigImageView];
        [self.contentView addSubview:self.headImage];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.msgLaebl];
    }
    return self;
}

- (void)setCategoryListModel:(SkyCategoryListModel *)categoryListModel
{
    _categoryListModel = categoryListModel;
    [self.bigImageView setImageWithURL:categoryListModel.thumb placeholder:[UIImage imageNamed:@"img_content_default_172x97_"]];
    //头像圆角
    [self.headImage setImageWithURL:categoryListModel.avatar
                        placeholder:nil
                            options:kNilOptions
                            manager:[SkyStatusHelper avatarImageManager]                           progress:nil
                          transform:nil
                         completion:nil];

    self.titleLabel.text = categoryListModel.nick;
    self.msgLaebl.text   = categoryListModel.title;
}

- (void)setTitleBGColor:(UIColor *)titleBGColor
{
    _titleBGColor = titleBGColor;
    self.titleLabel.backgroundColor =
    self.msgLaebl.backgroundColor   = _titleBGColor;
}

@end
