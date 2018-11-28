//
//  UIDetailImageTableViewCell.m
//  Diamond
//
//  Created by 陈国贤 on 2018/11/29.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import "UIDetailImageTableViewCell.h"
#import "XDProductDetailInfo.h"

#import <SDWebImage/UIImageView+WebCache.h>


@interface UIDetailImageTableViewCell ()
@property (nonatomic, weak) IBOutlet UIImageView *icon;


@end

@implementation UIDetailImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

- (void)setupWith:(XDProductDetailInfo *)detail
{
    NSString *urlStr = [NSString stringWithFormat:@"http://phpdo3tsg.bkt.clouddn.com/%@.jpg",[detail.imageArray firstObject]];

    [self.icon sd_setImageWithURL:[NSURL URLWithString:urlStr]];
}


@end
