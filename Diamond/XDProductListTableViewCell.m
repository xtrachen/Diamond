//
//  XDProductListTableViewCell.m
//  Diamond
//
//  Created by Xtra on 2018/11/15.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import "XDProductListTableViewCell.h"
#import "XDProductDetailInfo.h"
#import "UIImageView+WebCache.h"


@interface XDProductListTableViewCell ()
@property (nonatomic, weak) IBOutlet UIImageView *icon;
@property (nonatomic, weak) IBOutlet UILabel *label1;
@property (nonatomic,weak) IBOutlet UILabel *label2;

@end


@implementation XDProductListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWith:(XDProductDetailInfo *)info
{
    
    if (info.imageArray && [info.imageArray count] > 0) {
        NSString *urlStr = [NSString stringWithFormat:@"http://img.ndmcj.com/%@.jpg",[info.imageArray firstObject]];
        [self.icon sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    }
    [self.label1 setText:info.title];
    [self.label2 setText:info.markdown];
}

@end
