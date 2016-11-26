//
//  SkyCategoryModel.m
//  QuanMinTV_iPhone
//
//  Created by sky on 16/11/14.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "SkyCategoryModel.h"

@implementation SkyCategoryModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"categoryId":@"id",
             @"isDefault" : @"is_default"};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    if (_list.count != 0)
    {
        NSMutableArray *mList = [NSMutableArray new];
        for (NSDictionary *category in _list)
        {
            SkyCategoryListModel *model  = [SkyCategoryListModel modelWithJSON:category];
            [mList addObject:model];
        }
        _list = mList;
    }
    return YES;
}


@end



@implementation SkyCategoryListModel


+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"categoryName":@"category_name",
             @"categoryId" : @"category_id",
             @"categorySlug":@"category_slug"};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    NSInteger watch = [_view integerValue];
    if (watch > 10000)
    {
        _view = [NSString stringWithFormat:@"%.1f万",watch/10000.f];
    }
    return YES;
}


@end
