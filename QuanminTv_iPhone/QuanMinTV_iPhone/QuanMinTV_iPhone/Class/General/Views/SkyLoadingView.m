//
//  SkyLoadingView.m
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/22.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "SkyLoadingView.h"

@implementation SkyLoadingView


//初始化
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //初始化视图
        [self initView];
    }
    
    return self;
}

-(void)initView
{
    //背景视图
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                   0,
                                                                   LOADING_VIEW_SIZE.width,
                                                                   LOADING_VIEW_SIZE.height)];
    
    self.backgroundView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2-LOADING_IMG_Y_OFFSET);
    self.backgroundView.layer.cornerRadius = 5.0f;
    self.backgroundView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
    [self addSubview:self.backgroundView];
    //动画视图
    self.animateImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,
                                                                         0,
                                                                         LOADING_ANI_SIZE.width,
                                                                         LOADING_ANI_SIZE.height)];
//    self.animateImageView.image = [UIImage imageNamed:@""]];
//    //添加动画帧
//    self.animateImageView.animationImages = @[[CHStaticTools getImage:[CHStaticTools getRes:@"classAnimation1" ofBundle:GOBAL_RES]],
//                                              [CHStaticTools getImage:[CHStaticTools getRes:@"classAnimation2" ofBundle:GOBAL_RES]],
//                                              [CHStaticTools getImage:[CHStaticTools getRes:@"classAnimation3" ofBundle:GOBAL_RES]],
//                                              [CHStaticTools getImage:[CHStaticTools getRes:@"classAnimation4" ofBundle:GOBAL_RES]],
//                                              [CHStaticTools getImage:[CHStaticTools getRes:@"classAnimation5" ofBundle:GOBAL_RES]]];
//    
    self.animateImageView.center = CGPointMake(LOADING_VIEW_SIZE.width/2, LOADING_ANI_SIZE.height/2);
    self.animateImageView.backgroundColor = [UIColor clearColor];
    [self.animateImageView setAnimationDuration:0.3f];
    [self.animateImageView setAnimationRepeatCount:0];
    [self.backgroundView addSubview:self.animateImageView];
    //文本
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                               LOADING_ANI_SIZE.height,
                                                               LOADING_VIEW_SIZE.width,
                                                               LOADING_VIEW_SIZE.height-LOADING_ANI_SIZE.height-15)];
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.font = [UIFont systemFontOfSize:LOADING_TEXT_FONTSIZE];
//    self.textLabel.text = [CHStaticTools getString:@"Loading_Text_1"];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    [self.backgroundView addSubview:self.textLabel];
    
    self.backgroundView.alpha = 0.0f;
}


//显示对话框
-(void)startAnimating
{
    [UIView animateWithDuration:LOADING_SHOW_ANIDURATION
                     animations:^{
                         self.backgroundView.alpha = 1.0f;
                     }
                     completion:^(BOOL finished) {
                         [self.animateImageView startAnimating];
                     }];
}

//隐藏对话框
-(void)stopAnimating:(LoadingAnimateCompleted)completed
{
    [self.animateImageView stopAnimating];
    
    [UIView animateWithDuration:LOADING_SHOW_ANIDURATION
                     animations:^{
                         self.backgroundView.alpha = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         if(completed)
                             completed();
                     }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
