//
//  ColumnCell.m
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/25.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "ColumnCell.h"
#import "ColumnDataManager.h"

@interface ColumnCell ()

@property (nonatomic, weak) UIImageView *bigImageView;
@property (nonatomic, weak) UILabel     *titleLabel;

@end


@implementation ColumnCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:imageView];
        _bigImageView = imageView;
        [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        UILabel *label = [[UILabel alloc]init];
        label.backgroundColor     = [UIColor clearColor];
        label.textColor           = HexRGB(0x8fa1a3);
        label.textAlignment       = NSTextAlignmentCenter;
        label.font                = [UIFont systemFontOfSize:13.f];
        label.layer.masksToBounds = YES;
        [self.contentView addSubview:label];
        _titleLabel = label;
        [label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(@0);
            make.height.mas_equalTo(@30);
        }];
    }
    return self;
}

- (void)setModel:(ColumnModel *)model
{
    _model  = model;
    [_bigImageView setImageWithURL:model.thumb placeholder:nil];
    _titleLabel.text = model.name;
}


@end
