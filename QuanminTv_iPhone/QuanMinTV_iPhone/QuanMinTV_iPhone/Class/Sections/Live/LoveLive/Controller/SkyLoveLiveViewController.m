//
//  SkyLoveLiveViewController.m
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/15.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "SkyLoveLiveViewController.h"
#import "SkyLoveLiveLayerView.h"

@interface SkyLoveLiveViewController ()
{
    NSString *_liveUrl;
}

/** 直播播放器 */
@property (nonatomic, strong) IJKFFMoviePlayerController *moviePlayer;
/** 关闭按钮 */
@property (nonatomic, strong) UIButton *clearButton;
/** 全民直播 */
@property (nonatomic, strong) UIImageView *logoImageView;
/** 播放器占位图 */
@property (nonatomic, weak)   UIImageView *placeHolderView;
/** 播放器上浮层 */
@property (nonatomic, strong) SkyLoveLiveLayerView *layerView;

@end

@implementation SkyLoveLiveViewController

- (SkyLoveLiveLayerView*)layerView
{
    if (!_layerView) {
        _layerView = [[SkyLoveLiveLayerView alloc]init];
        _layerView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.0];
    }
    return _layerView;
}

- (UIImageView*)logoImageView
{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc]init];
        _logoImageView.image = [UIImage imageNamed:@"img_shuiyin_60x24_"];
    }
    return _logoImageView;
}

- (UIButton*)clearButton
{
    if (!_clearButton) {
        @weakify(self);
        _clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clearButton setImage:[UIImage imageNamed:@"alert_error_icon"] forState:UIControlStateNormal];
        [_clearButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [weak_self callBack];
        }];
    }
    return _clearButton;
}

- (UIImageView*)placeHolderView
{
    if (!_placeHolderView) {
        UIImageView *imageView  = [[UIImageView alloc]init];
        imageView.frame = self.view.bounds;
        imageView.image = [UIImage imageNamed:@"player_enter_loading_375x667_"];
        [self.view addSubview:imageView];
        UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        visualEffectView.frame = imageView.bounds;
        [imageView addSubview:visualEffectView];
        [self showGifLoding:nil inView:imageView];
        [imageView layoutIfNeeded];
        _placeHolderView = imageView;
    }
    return _placeHolderView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //添加手势
    @weakify(self)
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        [weak_self panGestureView:sender];
    }]];
    //添加播放器
    [self configureIJKplayerView];
    //添加全民logo
    [self.view addSubview:self.logoImageView];
    [self.logoImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(@(-55));
        make.size.mas_equalTo(CGSizeMake(60, 24));
        make.top.mas_equalTo(@38);;
    }];
    //添加点赞,聊天视图
    [self.view addSubview:self.layerView];
    self.layerView.model = self.model;
    [self.layerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    //添加返回按钮
    [self.view addSubview:self.clearButton];
    [self.clearButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35, 35.f));
        make.top.mas_equalTo(@30);
        make.right.mas_equalTo(@(-15));
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.moviePlayer shutdown];
    [self.moviePlayer.view removeFromSuperview];
    self.moviePlayer = nil;
    [self.layerView removeTimer];
    [self.layerView removeFromSuperview];
    self.layerView = nil;
}

//MARK: - 返回按钮
- (void)callBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

//MARK: - 播放视图
- (void)configureIJKplayerView
{
    @weakify(self);
    [self.placeHolderView setImageWithURL:self.thumb placeholder:[UIImage imageNamed:@"player_enter_loading_375x667_"] options:YYWebImageOptionUseNSURLCache completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weak_self showGifLoding:nil inView:weak_self.placeHolderView];
            weak_self.placeHolderView.image = image;
        });
    }];
    
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    _moviePlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:Live_url(self.uid) withOptions:options];
    _moviePlayer.view.frame = self.view.bounds;
    _moviePlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
    _moviePlayer.shouldAutoplay    = YES;
    _moviePlayer.shouldShowHudView = NO;
    [self.view addSubview:_moviePlayer.view];
    
    [self.view insertSubview:self.logoImageView aboveSubview:_moviePlayer.view];
    
    [_moviePlayer prepareToPlay];
    // 设置监听
    [self initObserver];
}

//MARK: - notify method
- (void)initObserver
{
    // 监听视频是否播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinish) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateDidChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:self.moviePlayer];
}

- (void)removeObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)stateDidChange
{
    if ((self.moviePlayer.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0)
    {
        if (!self.moviePlayer.isPlaying)
        {
            [self.moviePlayer play];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.placeHolderView) {
                    [self.placeHolderView removeFromSuperview];
                    self.placeHolderView = nil;
                    //[self.moviePlayer.view addSubview:_renderer.view];
                }
                [self hideGufLoding];
            });
        }else
        {
            // 如果是网络状态不好, 断开后恢复, 也需要去掉加载
            if (self.gifView.isAnimating) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self hideGufLoding];
                });
            }
        }
    }else if (self.moviePlayer.loadState & IJKMPMovieLoadStateStalled) //网络不佳,自动暂停状态
    {
        [self showGifLoding:nil inView:self.moviePlayer.view];
    }
}

- (void)didFinish
{
    NSLog(@"加载状态...%ld %ld %s", self.moviePlayer.loadState, self.moviePlayer.playbackState, __func__);
    // 因为网速或者其他原因导致直播stop了, 也要显示GIF
    if (self.moviePlayer.loadState & IJKMPMovieLoadStateStalled && !self.gifView) {
        [self showGifLoding:nil inView:self.moviePlayer.view];
        return;
    }
    //方法：
    @weakify(self)
    [SkyHttpClient requestWithType:SkyHttpRequestTypeGet UrlString:Live_url(self.uid) Parameters:nil SuccessBlock:^(id responseObject) {
        NSLog(@"请求成功, 等待继续播放");
    } FailureBlock:^(NSError *error) {
        NSLog(@"请求失败, 直播结束, 关闭播放器");
        [weak_self.moviePlayer shutdown];
        [weak_self.moviePlayer.view removeFromSuperview];
        weak_self.moviePlayer = nil;
        [weak_self callBack];
    }];
}


//MARK: - 手势
- (void)panGestureView:(UIPanGestureRecognizer*)pan
{
    CGPoint point = [pan translationInView:pan.view];
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGRect rect = self.layerView.frame;
            rect.origin.x =  SCREEN_WIDTH + point.x;
            self.layerView.frame = rect;
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            if (SCREEN_WIDTH + point.x > SCREEN_WIDTH - SCREEN_WIDTH/4)
            {
                [UIView animateWithDuration:0.3 animations:^{
                    CGRect rect = self.layerView.frame;
                    rect.origin.x = SCREEN_WIDTH;
                    self.layerView.frame = rect;
                }];
            }else
            {
                [UIView animateWithDuration:0.3 animations:^{
                    CGRect rect = self.layerView.frame;
                    rect.origin.x = 0;
                    self.layerView.frame = rect;
                }];
            }
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
