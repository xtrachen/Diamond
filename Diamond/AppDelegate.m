//
//  AppDelegate.m
//  Diamond
//
//  Created by Xtra on 2018/11/8.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import "AppDelegate.h"
#import "XDLoginViewController.h"
#import "XDSearchViewController.h"
#import "XDHomeViewController.h"
#import "XDMyViewController.h"
#import "XDSettingViewController.h"




@interface AppDelegate () <XDLoginViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    ///////////
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    XDLoginViewController *vc = [[XDLoginViewController alloc] init];
    vc.delegate = self;
    UINavigationController *rootNavi = [[UINavigationController alloc] initWithRootViewController:vc];
    
    self.window.rootViewController = rootNavi;
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)XDLoginViewControllerLoginFinish
{

    XDHomeViewController *homeVC = [[XDHomeViewController alloc] initWithNibName:@"XDHomeViewController" bundle:nil];
    homeVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"广场" image:[UIImage imageNamed:@"xd_img_bottombar_ground"] tag:1];
    
    XDSearchViewController *searchVC = [[XDSearchViewController alloc] initWithNibName:@"XDSearchViewController" bundle:nil];
    searchVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"查找" image:[UIImage imageNamed:@"xd_img_bottombar_search"] tag:2];
    
    XDMyViewController *myVC = [[XDMyViewController alloc] initWithNibName:@"XDMyViewController" bundle:nil];
    myVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"xd_img_bottombar_my"] tag:3];
    
    XDSettingViewController *settingVC = [[XDSettingViewController alloc] initWithNibName:@"XDSettingViewController" bundle:nil];
    settingVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"设置" image:[UIImage imageNamed:@"xd_img_bottombar_setting"] tag:4];

    UITabBarController *tabbar = [[UITabBarController alloc] init];

    tabbar.viewControllers = @[homeVC,searchVC,myVC,settingVC];
    
    [[UITabBar appearance] setBarTintColor:RGBCOLOR(169, 199, 161)];
    
    self.window.rootViewController = tabbar;
}


@end
