//
//  XDUploadViewController.m
//  Diamond
//
//  Created by Xtra on 2018/11/20.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import "XDUploadViewController.h"

@interface XDUploadViewController () <UITextViewDelegate>
@property (nonatomic, strong) IBOutlet UILabel *textViewNoticeLabel;

@end

@implementation XDUploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView.text.length+text.length > 0) {
        self.textViewNoticeLabel.hidden = YES;
    } else {
        self.textViewNoticeLabel.hidden = NO;
    }
    return YES;
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
