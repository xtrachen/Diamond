//
//  XDProductDetailInfo.m
//  Diamond
//
//  Created by Xtra on 2018/11/15.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import "XDProductDetailInfo.h"

@implementation XDProductDetailInfo



+ (XDProductDetailInfo *)infoFromDict:(NSDictionary *)dict
{
    XDProductDetailInfo *detail = [[XDProductDetailInfo alloc] init];
    
    
    detail.html = [dict objectForKey:@"html"];
    detail.uid = [dict objectForKey:@"user_id"];
    detail.markdown = [dict objectForKey:@"markdown"];
    detail.title = [dict objectForKey:@"title"];
    detail.pid = [dict objectForKey:@"id"];
    
    NSString *imagesStr = [dict objectForKey:@"imgstr"];
    if ([imagesStr length] > 0) {
        detail.imageArray = [imagesStr componentsSeparatedByString:@","];
    }
    
    detail.category = [dict objectForKey:@"category"];
    detail.ptype = [dict objectForKey:@"ptype"];
    NSNumber *price = [dict objectForKey:@"price"];
    if ([price isKindOfClass:[NSNumber class]]) {
        detail.price = [price intValue];
    }
    detail.color = [dict objectForKey:@"color"];

    NSNumber *length = [dict objectForKey:@"length"];
    if ([length isKindOfClass:[NSNumber class]]) {
        detail.length = [length intValue];
    }

    NSNumber *width = [dict objectForKey:@"width"];
    if ([width isKindOfClass:[NSNumber class]]) {
        detail.width = [width intValue];
    }
    
    NSNumber *height = [dict objectForKey:@"height"];
    if ([height isKindOfClass:[NSNumber class]]) {
        detail.height = [height intValue];
    }
    
    NSNumber *lat = [dict objectForKey:@"lat"];
    if ([lat isKindOfClass:[NSNumber class]]) {
        detail.lat = [lat doubleValue];
    }
    
    NSNumber *lng = [dict objectForKey:@"lnt"];
    if ([lng isKindOfClass:[NSNumber class]]) {
        detail.lng = [lng doubleValue];
    }
    
    detail.city = [dict objectForKey:@"city"];
    detail.region = [dict objectForKey:@"region"];
    detail.tag = [dict objectForKey:@"tag"];
    detail.sideStone = [dict objectForKey:@"sidestone"];
    detail.gold = [dict objectForKey:@"gold"];
    detail.designBy = [dict objectForKey:@"designby"];
    
    NSNumber *storage = [dict objectForKey:@"storage"];
    if ([storage isKindOfClass:[NSNumber class]]) {
        detail.storage = [storage intValue];
    }
    
    detail.store = [dict objectForKey:@"store"];
    detail.remarks = [dict objectForKey:@"remarks"];
    
    return detail;
}

@end
