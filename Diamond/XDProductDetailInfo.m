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
    
    NSString *price = [dict objectForKey:@"price"];
    detail.price = [price intValue];
    
    detail.color = [dict objectForKey:@"color"];

    NSString *length = [dict objectForKey:@"length"];
    detail.length = [length intValue];

    NSString *width = [dict objectForKey:@"width"];
    detail.width = [width intValue];
    
    NSString *height = [dict objectForKey:@"height"];
    detail.height = [height intValue];
    
    NSString *lat = [dict objectForKey:@"lat"];
    detail.lat = [lat doubleValue];
    
    NSString *lng = [dict objectForKey:@"lnt"];
    detail.lng = [lng doubleValue];
    
    detail.city = [dict objectForKey:@"city"];
    detail.region = [dict objectForKey:@"region"];
    detail.tag = [dict objectForKey:@"tag"];
    detail.sideStone = [dict objectForKey:@"sidestone"];
    detail.gold = [dict objectForKey:@"gold"];
    detail.designBy = [dict objectForKey:@"designby"];
    
    NSString *storage = [dict objectForKey:@"storage"];
    detail.storage = [storage intValue];
    
    detail.store = [dict objectForKey:@"store"];
    detail.remarks = [dict objectForKey:@"remarks"];
    
    return detail;
}

@end
