//
//  XDProductDetailInfo.h
//  Diamond
//
//  Created by Xtra on 2018/11/15.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XDProductDetailInfo : NSObject
@property (nonatomic, strong) NSString *pid;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *html;
@property (nonatomic, strong) NSString *markdown;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *ptype;
@property (nonatomic, assign) int price;
@property (nonatomic, strong) NSString *color;
@property (nonatomic, assign) int length;
@property (nonatomic, assign) int width;
@property (nonatomic, assign) int height;
@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double lng;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *region;
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, strong) NSString *sideStone;
@property (nonatomic, strong) NSString *gold;
@property (nonatomic, strong) NSString *designBy;
@property (nonatomic, assign) int storage;
@property (nonatomic, strong) NSString *store;
@property (nonatomic, strong) NSString *remarks;


+ (XDProductDetailInfo *)infoFromDict:(NSDictionary *)dict;


@end

NS_ASSUME_NONNULL_END
