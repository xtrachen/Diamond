//
//  XDSignupViewController.m
//  Diamond
//
//  Created by Xtra on 2018/12/21.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import "XDSignupViewController.h"
#import "XDTimeupButtonView.h"
#import "XDNetworkManager.h"


@interface XDSignupViewController ()
@property (nonatomic, weak) IBOutlet UITextField *nameField;
@property (nonatomic, weak) IBOutlet UITextField *phoneField;
@property (nonatomic, weak) IBOutlet UITextField *pwdField;
@property (nonatomic, weak) IBOutlet UITextField *emailField;
@property (nonatomic, weak) IBOutlet UITextField *verifyCodeField;
@property (nonatomic, weak) IBOutlet UIView *timeupWrapperView;
@property (nonatomic, strong) XDTimeupButtonView *timeupView;
@property (nonatomic, weak) IBOutlet UIButton *signupButton;


@end

@implementation XDSignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timeupView = [[XDTimeupButtonView alloc] initWithFrame:self.timeupWrapperView.bounds];
    [self.timeupWrapperView addSubview:self.timeupView];
    
    
    self.signupButton.layer.cornerRadius = 6.0;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)gotoSignup
{
    NSString *phone = self.phoneField.text;
    NSString *pwd = self.pwdField.text;
    NSString *email = self.emailField.text;
    NSString *name = self.nameField.text;

    if ([phone length] == 0 || [pwd length] == 0 || [email length] == 0 || [name length] == 0) {
        [self showAlertMessage:@"内容不全" message:@"请输入内容"];
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:phone forKey:@"cell"];
    [dict setObject:pwd forKey:@"password"];
    [dict setObject:email forKey:@"email"];
    [dict setObject:name forKey:@"name"];
    

    [[XDNetworkManager defaultManager] sendRequestMethod:HTTPMethodGET serverUrl:@"http://www.xtra.ltd:8888" apiPath:@"/ios/signup" parameters:dict progress:^(NSProgress * _Nullable progress) {
        ;
    } success:^(BOOL isSuccess, id  _Nullable responseObject) {
        [self dismissViewControllerAnimated:YES completion:^{
            ;
        }];
    } failure:^(NSString * _Nullable errorMessage) {
        [self dismissViewControllerAnimated:YES completion:^{
            ;
        }];
    }];
}


- (void)showAlertMessage:(NSString *)title message:(NSString *)str
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:title message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    [actionSheet addAction:action1];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)signupButtonClicked:(id)sender
{
    [self gotoSignup];
}

@end
