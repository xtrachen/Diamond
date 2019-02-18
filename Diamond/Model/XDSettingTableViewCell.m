//
//  XDSettingTableViewCell.m
//  Diamond
//
//  Created by Xtra on 2019/2/18.
//  Copyright © 2019年 XtraSoft. All rights reserved.
//

#import "XDSettingTableViewCell.h"

@interface XDSettingTableViewCell ()
@property (nonatomic, weak) IBOutlet UILabel *label;


@end

@implementation XDSettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTitleText:(NSString *)text
{
    [self.label setText:text];
}


@end
