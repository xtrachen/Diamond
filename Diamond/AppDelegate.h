//
//  AppDelegate.h
//  Diamond
//
//  Created by Xtra on 2018/11/8.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)shareToWeixin:(NSString *)imageUrl text:(NSString *)text title:(NSString *)title;


@end

