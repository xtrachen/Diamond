//
//  XDSearchViewController.m
//  Diamond
//
//  Created by Xtra on 2018/11/20.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import "XDSearchViewController.h"
#import "XDListSearchBar.h"

@interface XDSearchViewController () <XDListSearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UIView *searchView;
@property (nonatomic, strong) XDListSearchBar *searchBar;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation XDSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.searchBar = [[XDListSearchBar alloc] initWithFrame:self.searchView.bounds];
    [self.searchView addSubview:self.searchBar];
    [self.searchBar setDelegate:self];

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
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell new];
}

- (void)XDListSearchBarSearchWith:(NSString *)str
{
    
}


@end
