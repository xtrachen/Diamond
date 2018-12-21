//
//  XDSignupViewController.m
//  Diamond
//
//  Created by Xtra on 2018/12/21.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import "XDSignupViewController.h"
#import "XDTimeupButtonView.h"

@interface XDSignupViewController ()
@property (nonatomic, weak) IBOutlet UITextField *phoneField;
@property (nonatomic, weak) IBOutlet UITextField *pwdField;
@property (nonatomic, weak) IBOutlet UITextField *emailField;
@property (nonatomic, weak) IBOutlet UITextField *verifyCodeField;
@property (nonatomic, weak) IBOutlet UIView *timeupWrapperView;
@property (nonatomic, strong) XDTimeupButtonView *timeupView;
@end

@implementation XDSignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.timeupView = [[XDTimeupButtonView alloc] initWithFrame:self.timeupWrapperView.bounds];
    [self.timeupWrapperView addSubview:self.timeupView];
    

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

@end
