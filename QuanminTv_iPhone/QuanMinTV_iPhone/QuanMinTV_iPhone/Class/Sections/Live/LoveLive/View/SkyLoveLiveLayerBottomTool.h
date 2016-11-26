//
//  SkyLoveLiveLayerBottomTool.h
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/26.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LayerBottomToolType) {
    LayerBottomToolTypeMessage,
    LayerBottomToolTypeShare,
    LayerBottomToolTypeGift,
    LayerBottomToolTypePraise
};

@interface SkyLoveLiveLayerBottomTool : UIView

@property(nonatomic, copy)void (^clickBottomToolBlock)(LayerBottomToolType type);

@end
