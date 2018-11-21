//
//  XDMyViewController.m
//  Diamond
//
//  Created by Xtra on 2018/11/20.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import "XDMyViewController.h"
#import "XDUploadViewController.h"

@interface XDMyViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView* tableView;

@end

@implementation XDMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (IBAction)addButtonClicked:(id)sender
{
    XDUploadViewController *vc = [[XDUploadViewController alloc] initWithNibName:@"XDUploadViewController" bundle:nil];
    [self presentViewController:vc animated:YES completion:^{
        ;
    }];
}

@end
