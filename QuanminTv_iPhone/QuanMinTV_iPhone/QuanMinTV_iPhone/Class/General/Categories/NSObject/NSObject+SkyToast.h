//
//  NSObject+SkyToast.h
//  MiaoBoLive
//
//  Created by sky on 16/11/4.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <Foundation/Foundation.h>

//上下左右距离
#define TOAST_TEXT_MARGIN_TOP_BOTTOM  7.0f
#define TOAST_TEXT_MARGIN_LEFT_RIGHT  10.0f
//默认toast位置Y
#define TOAST_POSITION_Y   (SCREEN_HEIGHT-80.0f)

//字体
#define TOAST_TEXT_FONTSIZE         16.0f
//动画时间
#define TOAST_ANIMATION_DURATION    1.8f
//显示和消失时间
#define TOAST_ANI_STARTEND_DURATION 0.2f

@interface NSObject (SkyToast)

- (void)sky_make:(NSString*)text duration:(CGFloat)duration backgroundColor:(UIColor*)color position:(CGPoint)point;

- (void)sky_make:(NSString*)text duration:(CGFloat)duration position:(CGPoint)point;

- (void)sky_make:(NSString*)text;

@end
