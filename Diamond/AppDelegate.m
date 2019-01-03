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
#import "XDUser.h"
#import "WXApi.h"
#import <UIImageView+WebCache.h>




@interface AppDelegate () <XDLoginViewControllerDelegate,WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    ///////////
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];

    
    BOOL isLogin = [self loadSavedCookies];
    
    if (isLogin) {
        [self doLoginInit];
    } else {
        XDLoginViewController *vc = [[XDLoginViewController alloc] init];
        vc.delegate = self;
        UINavigationController *rootNavi = [[UINavigationController alloc] initWithRootViewController:vc];
        self.window.rootViewController = rootNavi;
    }
    
    // start up weixin
    [WXApi registerApp:@"wxb86be44e1ab23012" enableMTA:NO];

    
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

- (void)doLoginInit
{

    XDHomeViewController *homeVC = [[XDHomeViewController alloc] initWithNibName:@"XDHomeViewController" bundle:nil];
    homeVC.title = @"广场";
    UINavigationController *homeNavi = [[UINavigationController alloc] initWithRootViewController:homeVC];
    homeNavi.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"广场" image:[UIImage imageNamed:@"xd_img_bottombar_ground"] tag:1];
    
    XDSearchViewController *searchVC = [[XDSearchViewController alloc] initWithNibName:@"XDSearchViewController" bundle:nil];
    searchVC.title = @"查找";
    UINavigationController *searchNavi = [[UINavigationController alloc] initWithRootViewController:searchVC];
    searchNavi.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"查找" image:[UIImage imageNamed:@"xd_img_bottombar_search"] tag:2];
    
    XDMyViewController *myVC = [[XDMyViewController alloc] initWithNibName:@"XDMyViewController" bundle:nil];
    myVC.title = @"我的";
    UINavigationController *myNavi = [[UINavigationController alloc] initWithRootViewController:myVC];
    myNavi.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"xd_img_bottombar_my"] tag:3];
    
    XDSettingViewController *settingVC = [[XDSettingViewController alloc] initWithNibName:@"XDSettingViewController" bundle:nil];
    settingVC.title = @"设置";
    UINavigationController *settingNavi = [[UINavigationController alloc] initWithRootViewController:settingVC];
    settingNavi.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"设置" image:[UIImage imageNamed:@"xd_img_bottombar_setting"] tag:4];
    
    UITabBarController *tabbar = [[UITabBarController alloc] init];
    
    tabbar.viewControllers = @[homeNavi,searchNavi,myNavi,settingNavi];
    
    [[UITabBar appearance] setBarTintColor:RGBCOLOR(169, 199, 161)];
    
    self.window.rootViewController = tabbar;
}

- (void)XDLoginViewControllerLoginFinish
{
    [self doLoginInit];
    [self saveCookies];
}



- (void)saveCookies
{
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: cookiesData forKey:@"diamond.xtra.com"];
    [defaults setObject:[[XDUser defaultManager] uid] forKey:@"uid.diamond"];
    [defaults synchronize];
}

// 合适的时机加载持久化后Cookie 一般都是app刚刚启动的时候
- (BOOL)loadSavedCookies
{
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey: @"diamond.xtra.com"]];
    [XDUser defaultManager].uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid.diamond"];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in cookies){
        NSLog(@"cookie,name:= %@,valuie = %@",cookie.name,cookie.value);
    }
    
    if (cookies) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:self];
}

- (void)onReq:(BaseReq*)req
{
    
}

- (void)onResp:(BaseResp*)resp
{
    //把返回的类型转换成与发送时相对于的返回类型,这里为SendMessageToWXResp
    SendMessageToWXResp *sendResp = (SendMessageToWXResp *)resp;
    
    //使用UIAlertView 显示回调信息
    NSString *str = [NSString stringWithFormat:@"%d",sendResp.errCode];
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"回调信息" message:str delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    [alertview show];
//    WXSuccess           = 0,    /**< 成功    */
//    WXErrCodeCommon     = -1,   /**< 普通错误类型    */
//    WXErrCodeUserCancel = -2,   /**< 用户点击取消并返回    */
//    WXErrCodeSentFail   = -3,   /**< 发送失败    */
//    WXErrCodeAuthDeny   = -4,   /**< 授权失败    */
//    WXErrCodeUnsupport  = -5,   /**< 微信不支持    */
    
}

- (void)shareToWeixin:(NSString *)imageUrl text:(NSString *)text title:(NSString *)title
{
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;//分享内容带图片和文字时必须为NO

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    
    WXImageObject *imageObject = [WXImageObject object];

    if (imageView.image != nil) {
        NSData *data = UIImagePNGRepresentation(imageView.image);
        imageObject.imageData = data;
        
    } else {
        imageObject.imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
    }

//    UIImage *image = [UIImage imageNamed:@"opinion"];
    
    
    WXMediaMessage *message = [WXMediaMessage message];
//    [message setThumbImage:image];
    message.mediaObject = imageObject;
    //如果分享的内容包括文字和,这个时候的文字不能使用req.text属性来接收,必须使用下边的两个属性
    message.title = title;
    message.description = text;
    req.message = message;
    req.scene = WXSceneSession;//好友
    //req.scene = WXSceneTimeline;//朋友圈
    
    [WXApi sendReq:req];
    
}

@end
