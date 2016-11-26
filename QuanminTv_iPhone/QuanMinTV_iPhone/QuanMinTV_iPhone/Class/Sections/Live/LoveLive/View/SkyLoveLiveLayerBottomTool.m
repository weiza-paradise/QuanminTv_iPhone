//
//  SkyLoveLiveLayerBottomTool.m
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/26.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "SkyLoveLiveLayerBottomTool.h"

@implementation SkyLoveLiveLayerBottomTool


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        @weakify(self)
        UIButton *leftbutton1  = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftbutton1 setImage:[UIImage imageNamed:@"btn_player_back_normal_33x33_"] forState:UIControlStateNormal];
        [leftbutton1 setImage:[UIImage imageNamed:@"btn_player_back_selected_33x33_"] forState:UIControlStateHighlighted];
        [leftbutton1 addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [weak_self selectedButtonTag:0];
        }];
        [self addSubview:leftbutton1];
        
        UIButton *leftbutton2  = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftbutton2 setImage:[UIImage imageNamed:@"btn_player_share_normal_33x33_"] forState:UIControlStateNormal];
        [leftbutton2 setImage:[UIImage imageNamed:@"btn_player_share_selected_33x33_"] forState:UIControlStateHighlighted];
        [leftbutton2 addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [weak_self selectedButtonTag:1];
        }];
        [self addSubview:leftbutton2];

        
        UIButton *rightbutton1  = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightbutton1 setImage:[UIImage imageNamed:@"btn_player_gift_normal_33x33_"] forState:UIControlStateNormal];
        [rightbutton1 setImage:[UIImage imageNamed:@"btn_player_gift_selected_33x33_"] forState:UIControlStateHighlighted];
        [rightbutton1 addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [weak_self selectedButtonTag:2];
        }];
        [self addSubview:rightbutton1];
        
        
        UIButton *rightbutton2  = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightbutton2 setImage:[UIImage imageNamed:@"btn_player_dianzan_normal_33x33_"] forState:UIControlStateNormal];
        [rightbutton2 setImage:[UIImage imageNamed:@"btn_player_dianzan_selected_33x33_"] forState:UIControlStateHighlighted];
        [rightbutton2 addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [weak_self selectedButtonTag:3];
        }];
        [self addSubview:rightbutton2];
        
        [leftbutton1 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@10);
            make.bottom.mas_equalTo(@(-10));
            make.size.mas_equalTo(CGSizeMake(33, 33));
        }];
        
        
        [leftbutton2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(leftbutton1);
            make.left.equalTo(leftbutton1.mas_right).mas_offset(@10);
            make.size.equalTo(leftbutton1);
        }];
        
        [rightbutton2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(leftbutton1);
            make.right.mas_equalTo(@(-10));
            make.size.equalTo(leftbutton1);
        }];
        
        [rightbutton1 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(rightbutton2.mas_left).mas_offset(@(-10));
            make.bottom.equalTo(leftbutton1);
            make.size.equalTo(leftbutton1);
        }];
        
    }
    return self;
}


- (void)selectedButtonTag:(int)tag
{
    if (self.clickBottomToolBlock) {
        self.clickBottomToolBlock(tag);
    }
}


@end
