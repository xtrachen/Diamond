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
#import "AppDelegate.h"


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

    [self initShareButton];
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
    return 6;
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
        case 3: {
            XDDetailDoubleTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"XDDetailDoubleTableViewCell" owner:self options:nil] lastObject];
            cell.leftNameLabel.text = @"尺寸";
            cell.rightNameLabel.text = @"颜色";
            cell.leftAttributeLabel.text = [NSString stringWithFormat:@"%d/%d/%d(mm)",self.detailInfo.length,self.detailInfo.width,self.detailInfo.height];
            cell.rightAttributeLabel.text = self.detailInfo.color;
            return cell;
        }
            break;
        case 4: {
            XDDetailDoubleTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"XDDetailDoubleTableViewCell" owner:self options:nil] lastObject];
            cell.leftNameLabel.text = @"产地";
            cell.rightNameLabel.text = @"用金";
            cell.leftAttributeLabel.text = self.detailInfo.region;
            cell.rightAttributeLabel.text = self.detailInfo.gold;
            return cell;
        }
            break;
        case 5: {
            XDDetailDoubleTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"XDDetailDoubleTableViewCell" owner:self options:nil] lastObject];
            cell.leftNameLabel.text = @"库存";
//            cell.rightNameLabel.text = @"用金";
            cell.leftAttributeLabel.text = [NSString stringWithFormat:@"%d",self.detailInfo.storage];//[NSString stringWithString:@"%d",self.detailInfo.storage];
//            cell.rightAttributeLabel.text = self.detailInfo.gold;
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
        case 1:
        case 2:
        case 3:
        case 4:
        case 5: {
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

- (void)doShare
{
    if ([self.detailInfo.imageArray count] > 0) {
        NSString *imageId = [self.detailInfo.imageArray firstObject];
        NSString *urlStr = [NSString stringWithFormat:@"http://img.ndmcj.com/%@.jpg",imageId];
        AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate shareToWeixin:urlStr text:@"我在Diamond找到好货快来查看" title:@"好物分享"];
    }
}

- (void)shareButtonClicked:(id)sender
{
    [self doShare];
}

- (void)initShareButton
{
    UIImage *image = [UIImage imageNamed:@"xd_icon_detail_share"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(shareButtonClicked:)];
    self.navigationItem.rightBarButtonItem = item;
}



@end
