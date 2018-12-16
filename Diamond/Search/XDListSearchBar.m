//
//  XDListSearchBar.m
//  Diamond
//
//  Created by 陈国贤 on 2018/12/16.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import "XDListSearchBar.h"

@interface XDListSearchBar ()
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *button;

@end

@implementation XDListSearchBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.button = [[UIButton alloc] initWithFrame:CGRectMake(self.width-15-60, 7, 60, 30)];
        [self.button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.button];
        self.button.backgroundColor = RGBCOLOR(161, 199, 166);
        self.button.layer.cornerRadius = 6;
        [self.button setTitle:@"查找" forState:UIControlStateNormal];
        [self.button.titleLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:self.button];
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 7, self.width-30-60, 30)];
        self.textField.placeholder = @"输入查找内容";
        self.textField.textColor = RGBCOLOR(161, 199, 166);
        [self addSubview:self.textField];
        
    }
    return self;
}

- (void)buttonClicked
{
    if ([self.textField.text length] > 0) {
        [self.delegate XDListSearchBarSearchWith:self.textField.text];
    }
}

@end
