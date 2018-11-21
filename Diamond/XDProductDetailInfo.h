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

+ (XDProductDetailInfo *)infoFromDict:(NSDictionary *)dict;


@end

NS_ASSUME_NONNULL_END
