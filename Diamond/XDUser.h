//
//  XDUser.h
//  Diamond
//
//  Created by Xtra on 2018/11/15.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XDUser : NSObject
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *cookie;

+ (XDUser *)defaultManager;

@end

NS_ASSUME_NONNULL_END
