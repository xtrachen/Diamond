//
//  XDHomeViewController.m
//  Diamond
//
//  Created by Xtra on 2018/11/15.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import "XDHomeViewController.h"
#import "XDUser.h"
#import "XDNetworkManager.h"
#import "XDProductDetailInfo.h"
#import "XDProductListTableViewCell.h"
#import "XDDetailViewController.h"
#import "XDProductDetailInfo.h"


@interface XDHomeViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array;


@end

@implementation XDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *uid = [XDUser defaultManager].uid;
    self.array = [NSMutableArray array];
    [self queryEntryList:uid];
    [self queryUploadToken];
    
    
    [self.tableView registerClass:[XDProductListTableViewCell class] forCellReuseIdentifier:@"XDProductListTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XDProductListTableViewCell" bundle:nil] forCellReuseIdentifier:@"XDProductListTableViewCell"];
    
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
    return [self.array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XDProductListTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"XDProductListTableViewCell" forIndexPath:indexPath];
    
    XDProductDetailInfo *info = [self.array objectAtIndex:indexPath.row];
    [cell setupWith:info];
    
    return cell;
}

- (void)queryEntryList:(NSString *)userId
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:(int)[self.array count]],@"index",[NSNumber numberWithInt:20],@"count", nil];
    
    [[XDNetworkManager defaultManager] sendRequestMethod:HTTPMethodGET serverUrl:@"http://www.xtra.ltd:8888" apiPath:@"/ios/plist" parameters:dict progress:^(NSProgress * _Nullable progress) {
        ;
    } success:^(BOOL isSuccess, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        NSArray *list = [responseObject objectForKey:@"list"];
        
        for (NSDictionary *dict in list) {
            XDProductDetailInfo *detail = [XDProductDetailInfo infoFromDict:dict];
            [self.array addObject:detail];
            
        }
        [self.tableView reloadData];
    } failure:^(NSString * _Nullable errorMessage) {
        NSLog(@"%@",errorMessage);
    }];
}

- (void)queryUploadToken
{

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XDProductDetailInfo *detailInfo = [self.array objectAtIndex:indexPath.row];
    
    XDDetailViewController *vc = [[XDDetailViewController alloc] initWithNibName:@"XDDetailViewController" bundle:nil];
    [vc setupWithInfo:detailInfo];
    
    [self.navigationController pushViewController:vc animated:YES];
}


@end
