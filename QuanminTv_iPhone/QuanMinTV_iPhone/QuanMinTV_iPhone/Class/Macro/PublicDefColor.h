//
//  PublicDefColor.h
//  MiaoBoLive_iPhone
//
//  Created by sky on 16/11/3.
//  Copyright © 2016年 sky. All rights reserved.
//

/**
 *  通用色值
 */

#ifndef PublicDefColor_h
#define PublicDefColor_h


//Home
#define Home_List_BGColor  HexRGB(0xf7fcff)



//根据RGB值返回颜色
#define RGBColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//随机颜色
#define RANDOMCOLOR     [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1]


#endif /* PublicDefColor_h */
