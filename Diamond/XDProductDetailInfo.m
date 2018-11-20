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
    
    return detail;
}

@end
