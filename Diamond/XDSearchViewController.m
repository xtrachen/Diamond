//
//  XDSearchViewController.m
//  Diamond
//
//  Created by Xtra on 2018/11/20.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import "XDSearchViewController.h"
#import "XDListSearchBar.h"
#import "XDNetworkManager.h"
#import "XDProductDetailInfo.h"
#import "XDProductListTableViewCell.h"
#import "XDDetailViewController.h"

@interface XDSearchViewController () <XDListSearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UIView *searchView;
@property (nonatomic, strong) XDListSearchBar *searchBar;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation XDSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.searchBar = [[XDListSearchBar alloc] initWithFrame:self.searchView.bounds];
    [self.searchView addSubview:self.searchBar];
    [self.searchBar setDelegate:self];
    
    self.array = [NSMutableArray array];
    
    [self.tableView registerClass:[XDProductListTableViewCell class] forCellReuseIdentifier:@"XDProductListTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XDProductListTableViewCell" bundle:nil] forCellReuseIdentifier:@"XDProductListTableViewCell"];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.searchBar setFrame:self.searchView.bounds];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

- (void)XDListSearchBarSearchWith:(NSString *)str
{
    [self.array removeAllObjects];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:str forKey:@"key_word"];
    
    [[XDNetworkManager defaultManager] sendRequestMethod:HTTPMethodGET serverUrl:@"http://www.xtra.ltd:8888" apiPath:@"/ios/search" parameters:dict progress:^(NSProgress * _Nullable progress) {
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XDProductDetailInfo *detailInfo = [self.array objectAtIndex:indexPath.row];
    
    XDDetailViewController *vc = [[XDDetailViewController alloc] initWithNibName:@"XDDetailViewController" bundle:nil];
    [vc setupWithInfo:detailInfo];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
