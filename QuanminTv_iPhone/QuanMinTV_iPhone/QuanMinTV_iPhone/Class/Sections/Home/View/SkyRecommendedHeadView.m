//
//  SkyRecommendedHeadView.m
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/14.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "SkyRecommendedHeadView.h"

@interface SkyRecommendedHeadView ()

@end

@implementation SkyRecommendedHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CALayer *line = [CALayer layer];
        line.size = CGSizeMake(3,12);
        line.top  = (self.height - 12)/2; //直接设置center有问题
        line.backgroundColor = [UIColor redColor].CGColor;
        [self.layer addSublayer:line];

        UILabel *label = [[UILabel alloc]init];
        label.layer.masksToBounds = YES;
        label.font      = [UIFont systemFontOfSize:15.f];
        label.textColor = HexRGB(0x333333);
        label.tag = 1026;
        [self addSubview:label];
        [label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@10);
            make.top.bottom.right.mas_equalTo(@0);
        }];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [button setTitle:@"瞅瞅" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"btn_home_content_rignt_cc_normal_20x20_"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"btn_home_content_rignt_cc_selected_20x20_"] forState:UIControlStateHighlighted];
        [button setTitleColor:HexRGB(0xc5c5c5) forState:UIControlStateNormal];
        [button setTitleColor:HexRGB(0xff5253) forState:UIControlStateHighlighted];
        button.titleEdgeInsets = UIEdgeInsetsMake(0,-35,0,0);
        button.imageEdgeInsets = UIEdgeInsetsMake(0,30,0,0);
        [self addSubview:button];
        @weakify(self)
        [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            if (weak_self.selectedLookBlack) {
                weak_self.selectedLookBlack();
            }
        }];
        [button mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(@(-10));
            make.size.mas_equalTo(CGSizeMake(50,20));
            make.centerY.equalTo(self);
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    UILabel *label = (UILabel*)[self viewWithTag:1026];
    label.text = title;
}

@end
