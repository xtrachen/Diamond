//
//  XDUser.m
//  Diamond
//
//  Created by Xtra on 2018/11/15.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import "XDUser.h"

static id _instance;


@implementation XDUser

+ (XDUser *)defaultManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[XDUser alloc] init];
    });
    return _instance;
}


@end
