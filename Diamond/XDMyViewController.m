//
//  XDMyViewController.m
//  Diamond
//
//  Created by Xtra on 2018/11/20.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import "XDMyViewController.h"
#import "XDUploadViewController.h"
#import "XDNetworkManager.h"
#import "XDUser.h"
#import "XDProductDetailInfo.h"
#import "XDProductListTableViewCell.h"
#import "XDDetailViewController.h"



@interface XDMyViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView* tableView;
@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation XDMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.array = [NSMutableArray array];
    

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    if ([self.array count] > 0){
        return;
    }
    
 
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[[XDUser defaultManager] uid] forKey:@"user_id"];
    
    [self.tableView registerClass:[XDProductListTableViewCell class] forCellReuseIdentifier:@"XDProductListTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XDProductListTableViewCell" bundle:nil] forCellReuseIdentifier:@"XDProductListTableViewCell"];
    
    [[XDNetworkManager defaultManager] sendRequestMethod:HTTPMethodGET serverUrl:@"http://www.xtra.ltd:8888" apiPath:@"/ios/mylist" parameters:dict progress:^(NSProgress * _Nullable progress) {
        ;
    } success:^(BOOL isSuccess, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        NSArray *array = [responseObject objectForKey:@"list"];
        
        if ([array isKindOfClass:[NSArray class]] && [array count] > 0) {
            
            for (NSDictionary *dict in array) {
                XDProductDetailInfo *info = [XDProductDetailInfo infoFromDict:dict];
                [self.array addObject:info];
            }
            [self.tableView reloadData];
        }
    } failure:^(NSString * _Nullable errorMessage) {
        NSLog(@"%@",errorMessage);
    }];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    XDProductListTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"XDProductListTableViewCell" forIndexPath:indexPath];
    
    XDProductDetailInfo *info = [self.array objectAtIndex:indexPath.row];
    [cell setupWith:info];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

- (IBAction)addButtonClicked:(id)sender
{
    XDUploadViewController *vc = [[XDUploadViewController alloc] initWithNibName:@"XDUploadViewController" bundle:nil];
    [self presentViewController:vc animated:YES completion:^{
        ;
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XDProductDetailInfo *detailInfo = [self.array objectAtIndex:indexPath.row];
    
    XDDetailViewController *vc = [[XDDetailViewController alloc] initWithNibName:@"XDDetailViewController" bundle:nil];
    [vc setupWithInfo:detailInfo];

    [self.navigationController pushViewController:vc animated:YES];
}

@end
