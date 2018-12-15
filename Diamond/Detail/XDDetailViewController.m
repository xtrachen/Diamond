//
//  XDDetailViewController.m
//  Diamond
//
//  Created by 陈国贤 on 2018/11/29.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import "XDDetailViewController.h"
#import "UIDetailImageTableViewCell.h"
#import "XDProductDetailInfo.h"
#import "XDDetailDoubleTableViewCell.h"
#import "XDDetailSingleTableViewCell.h"


@interface XDDetailViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) XDProductDetailInfo *detailInfo;
@end

@implementation XDDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.tableView registerClass:[UIDetailImageTableViewCell class] forCellReuseIdentifier:@"UIDetailImageTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"UIDetailImageTableViewCell" bundle:nil] forCellReuseIdentifier:@"UIDetailImageTableViewCell"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    switch (indexPath.row) {
        case 0: {
            UIDetailImageTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"UIDetailImageTableViewCell" owner:self options:nil] lastObject];
            [cell setupWith:self.detailInfo];
            return cell;
        }
            break;
        case 1: {
            XDDetailSingleTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"XDDetailSingleTableViewCell" owner:self options:nil] lastObject];
            [cell.nameLabel setText:@"价格"];
            [cell.attributeLabel setText:[NSString stringWithFormat:@"%d",self.detailInfo.price]];
            return cell;
        }
            break;
        case 2: {
            XDDetailDoubleTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"XDDetailDoubleTableViewCell" owner:self options:nil] lastObject];
            cell.leftNameLabel.text = @"种类";
            cell.rightNameLabel.text = @"佩戴";
            cell.leftAttributeLabel.text = self.detailInfo.category;
            cell.rightAttributeLabel.text = self.detailInfo.ptype;
            return cell;
        }
            break;
        default:
            return [UITableViewCell new];
            break;
    }
    
    
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return self.view.frame.size.width*3/4;
            break;
        case 1: {
            return 50;
        }
            break;
        case 2: {
            return 50;
        }
            break;
        default:
            return 0;
    }
}

- (void)setupWithInfo:(XDProductDetailInfo *)info
{
    self.detailInfo = info;
}

@end
