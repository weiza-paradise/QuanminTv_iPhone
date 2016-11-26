//
//  UIViewController+SLExtension.m
//  XueShengHui
//
//  Created by ALin on 16/4/6.
//  Copyright © 2016年 ALin. All rights reserved.
//

#import "UIViewController+SLExtension.h"
#import "UIImageView+Extension.h"
#import <objc/message.h>

static const void *GifKey    = &GifKey;
static const void *ImageViewKey = &ImageViewKey;


@implementation UIViewController (SLExtension)

- (UIImageView *)gifView
{
    return objc_getAssociatedObject(self, GifKey);
}

- (void)setGifView:(UIImageView *)gifView
{
    objc_setAssociatedObject(self, GifKey, gifView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView *)loadImageView
{
    return objc_getAssociatedObject(self, ImageViewKey);
}


- (void)setLoadImageView:(UIImageView *)loadImageView
{
    objc_setAssociatedObject(self, ImageViewKey, loadImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}



// 显示GIF加载动画
- (void)showGifLoding:(NSArray *)images inView:(UIView *)view
{
    if (!images.count) {
        images = @[[UIImage imageNamed:@"portrait_loading1_107x31_"],
                   [UIImage imageNamed:@"portrait_loading2_107x31_"],
                   [UIImage imageNamed:@"portrait_loading3_107x31_"],
                   [UIImage imageNamed:@"portrait_loading4_107x31_"],
                   [UIImage imageNamed:@"portrait_loading5_107x31_"],
                   [UIImage imageNamed:@"portrait_loading6_107x31_"],
                   [UIImage imageNamed:@"portrait_loading7_107x31_"],
                   [UIImage imageNamed:@"portrait_loading8_107x31_"],
                   [UIImage imageNamed:@"portrait_loading9_107x31_"],
                   [UIImage imageNamed:@"portrait_loading10_107x31_"],];
    }
    UIImageView *gifView = [[UIImageView alloc] init];
    if (!view) {
        view = self.view;
    }
    [view addSubview:gifView];
    [gifView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.equalTo(@107);
        make.height.equalTo(@31);
    }];
    self.gifView = gifView;
    [gifView playGifAnim:images];
    
}
// 取消GIF加载动画
- (void)hideGufLoding
{
    [self.gifView stopGifAnim];
    self.gifView = nil;
}

- (BOOL)isNotEmpty:(NSArray *)array
{
    if ([array isKindOfClass:[NSArray class]] && array.count) {
        return YES;
    }
    return NO;
}

/** 开始显示loading视图 */
-(void)showLoading:(NSString*)text
{
    NSArray *images = @[[UIImage imageNamed:@"loading_0_130x130_"],
                        [UIImage imageNamed:@"loading_1_130x130_"],
                        [UIImage imageNamed:@"loading_2_130x130_"],
                        [UIImage imageNamed:@"loading_3_130x130_"],
                        [UIImage imageNamed:@"loading_4_130x130_"],
                        [UIImage imageNamed:@"loading_5_130x130_"],
                        [UIImage imageNamed:@"loading_6_130x130_"],
                        [UIImage imageNamed:@"loading_7_130x130_"],
                        [UIImage imageNamed:@"loading_8_130x130_"],
                        [UIImage imageNamed:@"loading_9_130x130_"],
                        [UIImage imageNamed:@"loading_10_130x130_"]];
    UIImageView *loadView = [[UIImageView alloc] init];
    
    [self.view addSubview:loadView];
    [loadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.equalTo(@130);
        make.height.equalTo(@130);
    }];
    self.loadImageView = loadView;
    [loadView playGifAnim:images];
}

/** 关闭loading视图 */
-(void)hideLoading
{
    [self.loadImageView stopGifAnim];
    self.loadImageView = nil;
}

@end
