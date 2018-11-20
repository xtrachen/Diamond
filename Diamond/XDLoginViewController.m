//
//  XDLoginViewController.m
//  Diamond
//
//  Created by Xtra on 2018/11/15.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import "XDLoginViewController.h"
#import "XDNetworkManager.h"

#import "XDHomeViewController.h"
#import "XDUser.h"



@interface XDLoginViewController () <UITextFieldDelegate>
@property (nonatomic, weak) IBOutlet UITextField *phonefield;
@property (nonatomic, weak) IBOutlet UITextField *pwdField;
@property (nonatomic, weak) IBOutlet UIButton *loginButton;


@end

@implementation XDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    self.loginButton.layer.cornerRadius = 3;
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginButtonClicked:(id)sender
{
    NSString *username = self.phonefield.text;
    NSString *pwd = self.pwdField.text;
    
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:username,@"email",pwd,@"password", nil];

    
    [[XDNetworkManager defaultManager] sendRequestMethod:HTTPMethodGET serverUrl:@"http://www.xtra.ltd:8888" apiPath:@"/ios/auth/login" parameters:dict progress:^(NSProgress * _Nullable progress) {
        ;
    } success:^(BOOL isSuccess, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        NSArray *cookie = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:@"http://www.xtra.ltd:8888"]];//得到cookie
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookie];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"cookie"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSLog(@"cookies:%@",cookie);

        NSDictionary *dict = responseObject;
        
        NSString *uid = [responseObject objectForKey:@"uid"];
        
        if ([uid isKindOfClass:[NSString class]] && [uid length] > 0) {
            
            [XDUser defaultManager].uid = uid;
            
            XDHomeViewController *vc = [[XDHomeViewController alloc] initWithNibName:@"XDHomeViewController" bundle:nil];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        

        
//        __weak XDLoginViewController *weakself = self;
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//
//
//
//
//        });
        
    } failure:^(NSString * _Nullable errorMessage) {
        NSLog(@"%@",errorMessage);
    }];
    
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;              // called when 'return' key pressed. return NO to ignore.
{
    if (textField==self.phonefield) {
        [self.pwdField becomeFirstResponder];
    } else if (textField==self.pwdField){
        [self.view endEditing:YES];
    }
    return NO;
}



@end
