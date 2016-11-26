//
//  SkyLivePlayerView.h
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/24.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 点击方向buttn */
typedef void(^SelectedOrientationButton)();
/** 点击返回按钮 */
typedef void(^SelectedBackButton)();

@interface SkyLivePlayerView : UIView

@property (nonatomic, copy) SelectedOrientationButton orientationBackBlock;
@property (nonatomic, copy) SelectedBackButton        backButtonBlock;

/**  */
- (instancetype)initWithFrame:(CGRect)frame
             ContentURLString:(NSString*)aUrlString;

/** 销毁播放器 */
- (void)playerShutdown;

/** 销毁通知 */
- (void)removeObserver;

@end
