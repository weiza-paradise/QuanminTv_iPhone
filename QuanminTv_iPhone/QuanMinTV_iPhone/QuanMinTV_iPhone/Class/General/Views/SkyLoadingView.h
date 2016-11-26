//
//  SkyLoadingView.h
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/22.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

//默认大小
#define LOADING_VIEW_SIZE  CGSizeMake(120.0f,120.0f)
#define LOADING_ANI_SIZE   CGSizeMake(120.0f,90.0f)
#define LOADING_IMG_Y_OFFSET      50
//loading框出现的动画时间
#define LOADING_SHOW_ANIDURATION  0.3f
//文字长度
#define LOADING_TEXT_FONTSIZE     15.0f

//动画完成
typedef void (^LoadingAnimateCompleted)(void);


@interface SkyLoadingView : UIView

@property(nonatomic,retain) UIView*       backgroundView;
@property(nonatomic,retain) UIImageView*  animateImageView;
@property(nonatomic,retain) UILabel*      textLabel;

//初始化view
-(void)initView;

//显示对话框
-(void)startAnimating;
//隐藏对话框
-(void)stopAnimating:(LoadingAnimateCompleted)completed;

@end
