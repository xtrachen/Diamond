//
//  XDDetailViewController.h
//  Diamond
//
//  Created by 陈国贤 on 2018/11/29.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class XDProductDetailInfo;

@interface XDDetailViewController : UIViewController


- (void)setupWithInfo:(XDProductDetailInfo *)info;

@end

NS_ASSUME_NONNULL_END
