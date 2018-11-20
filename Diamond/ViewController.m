//
//  ViewController.m
//  Diamond
//
//  Created by Xtra on 2018/11/8.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import "ViewController.h"
#import "XDNetworkManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"xtrachen@msn.com",@"email",@"123456",@"password", nil];
    
    
    [[XDNetworkManager defaultManager] sendRequestMethod:HTTPMethodGET serverUrl:@"http://www.xtra.ltd:8888" apiPath:@"/ios/auth/login" parameters:dict progress:^(NSProgress * _Nullable progress) {
        ;
    } success:^(BOOL isSuccess, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        NSArray *cookie = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:@"http://www.xtra.ltd:8888"]];//得到cookie
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookie];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"cookie"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSLog(@"cookies:%@",cookie);
        
        __weak ViewController *weakself = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself queryEntryList:@"1"];
        });
        
    } failure:^(NSString * _Nullable errorMessage) {
        NSLog(@"%@",errorMessage);
    }];
}

- (void)queryEntryList:(NSString *)userId
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:userId,@"uid", nil];
    
    [[XDNetworkManager defaultManager] sendRequestMethod:HTTPMethodGET serverUrl:@"http://www.xtra.ltd:8888" apiPath:@"/ios/entry" parameters:dict progress:^(NSProgress * _Nullable progress) {
        ;
    } success:^(BOOL isSuccess, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSString * _Nullable errorMessage) {
        NSLog(@"%@",errorMessage);
    }];
}

@end
