//
//  XDTextSetTableViewCell.m
//  Diamond
//
//  Created by Xtra on 2018/12/3.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import "XDTextSetTableViewCell.h"

@implementation XDTextSetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDelegate:(id<XDTextSetTableViewCellDelegate>)delegate
{
    _delegate = delegate;
    self.textField.userInteractionEnabled = NO;

    UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    tapRecognize.numberOfTapsRequired = 1;
    tapRecognize.delegate = self;
    [tapRecognize setEnabled :YES];
    [tapRecognize delaysTouchesBegan];
    [tapRecognize cancelsTouchesInView];
    [self addGestureRecognizer:tapRecognize];
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer
{
    [self.delegate XDTextSetTableViewCellClicked:self];
}


@end
