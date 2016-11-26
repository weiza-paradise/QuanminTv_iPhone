//
//  SkyLivePlayerView.m
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/24.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "SkyLivePlayerView.h"

@interface SkyLivePlayerView ()

@property (nonatomic, strong) NSString *liveUrl;

/** 播放器 */
@property (nonatomic, strong) IJKFFMoviePlayerController *player;

/** 返回 */
@property (nonatomic, weak)   UIButton *backButton;

/** 屏幕切换 */
@property (nonatomic, weak)   UIButton *orientationButton;

/** loading */
@property (nonatomic, weak)   UIActivityIndicatorView   *indicator;

@end


@implementation SkyLivePlayerView

- (UIButton*)backButton
{
    if (!_backButton) {
        @weakify(self);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"player_backButton_icon_30x30_"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"player_backButton_pressIcon_30x30_"] forState:UIControlStateHighlighted];
        [button addBlockForControlEvents:UIControlEventTouchUpInside
                                   block:^(id  _Nonnull sender) {
                                       if (weak_self.backButtonBlock) {
                                           weak_self.backButtonBlock();
                                       }
        }];
        [self addSubview:button];
        _backButton = button;
        [button mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(@16);
            make.size.mas_equalTo(CGSizeMake(30.f,30.f));
        }];
    }
    return _backButton;
}

- (UIButton*)orientationButton
{
    if (!_orientationButton) {
        @weakify(self);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"player_fullScreen_icon_30x30_"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"player_fullScreen_pressIcon_30x30_"] forState:UIControlStateHighlighted];
        [button addBlockForControlEvents:UIControlEventTouchUpInside
                                   block:^(id  _Nonnull sender) {
                                       if (weak_self.orientationBackBlock) {
                                           weak_self.orientationBackBlock();
                                       }
        }];
        [self addSubview:button];
        _orientationButton = button;
        [button mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.mas_equalTo(@(-16));
            make.size.mas_equalTo(CGSizeMake(30.f, 30.f));
        }];
    }
    return _orientationButton;
}

- (UIActivityIndicatorView*)indicator
{
    if (!_indicator)
    {
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        indicator.size = CGSizeMake(80, 80);
        indicator.center = CGPointMake(self.width / 2, self.height / 2);
        indicator.clipsToBounds = YES;
        indicator.layer.cornerRadius = 6;
        [indicator startAnimating];
        [self addSubview:indicator];
        _indicator = indicator;
    }
    return _indicator;
}

- (instancetype)initWithFrame:(CGRect)frame ContentURLString:(NSString*)aUrlString
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        _liveUrl = aUrlString;
        [self _loadPlayer];
    }
    return self;
}

- (void)_loadPlayer
{
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    IJKFFMoviePlayerController *moviePlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:_liveUrl withOptions:options];
    moviePlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
    moviePlayer.view.backgroundColor = [UIColor blackColor];
    moviePlayer.shouldAutoplay    = NO;
    moviePlayer.shouldShowHudView = NO;
    self.player = moviePlayer;
    [self addSubview:moviePlayer.view];
    [moviePlayer.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [moviePlayer prepareToPlay];
    
    [self insertSubview:self.indicator aboveSubview:self.player.view];
    [self insertSubview:self.backButton aboveSubview:self.player.view];
    [self insertSubview:self.orientationButton aboveSubview:self.player.view];
    // 设置监听
    [self initObserver];
}

//MARK: - notify method
- (void)initObserver
{
    // 监听视频是否播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinish) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:self.player];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateDidChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:self.player];
}

- (void)removeObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)stateDidChange
{
    if ((self.player.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0)
    {
        if (!self.player.isPlaying)
        {
            [self.player play];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.indicator stopAnimating];
            });
        }else
        {
            if (self.indicator.isAnimating) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.indicator stopAnimating];
                });
            }
        }
    }else if (self.player.loadState & IJKMPMovieLoadStateStalled) //网络不佳,自动暂停状态
    {
        [self.indicator startAnimating];
    }
}

- (void)didFinish
{
    if (self.player.loadState & IJKMPMovieLoadStateStalled) {
        [self.indicator startAnimating];
        return;
    }
    __weak typeof(self)weakSelf = self;
    [SkyHttpClient requestWithType:SkyHttpRequestTypeGet
                         UrlString:_liveUrl
                        Parameters:nil
                      SuccessBlock:^(id responseObject) {
        NSLog(@"请求成功, 等待继续播放");
    } FailureBlock:^(NSError *error) {
        NSLog(@"请求失败, 直播结束, 关闭播放器");
        [weakSelf.player shutdown];
        [weakSelf.player.view removeFromSuperview];
        weakSelf.player = nil;
    }];
}

- (void)playerShutdown
{
    if (self.player) {
        [self.player shutdown];
        [self.player.view removeFromSuperview];
        self.player = nil;
    }
}

@end
