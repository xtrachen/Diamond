//
//  XDSizeSetView.m
//  Diamond
//
//  Created by 陈国贤 on 2018/12/9.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import "XDSizeSetView.h"



@interface XDSizeSetViewItem : UIView
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextField *textField;

@end


@implementation XDSizeSetViewItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 24, 44)];
        [self.label setFont:[UIFont systemFontOfSize:17]];
        [self.label setTextColor:RGBCOLOR(10, 10, 10)];
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(34, 0, self.width-10-10-24, 44)];
        [self.textField setKeyboardType:UIKeyboardTypeNumberPad];
        [self addSubview:self.label];
        [self addSubview:self.textField];
    }
    return self;
}


@end

@interface XDSizeSetView ()
@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) XDSizeSetViewItem *item1;
@property (nonatomic, strong) XDSizeSetViewItem *item2;
@property (nonatomic, strong) XDSizeSetViewItem *item3;

@end


@implementation XDSizeSetView

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
        self.backgroundColor = RGBCOLOR(245, 245, 245);
        
        self.button = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-10-60, 7, 60, 30)];
        [self.button setTitle:@"确认" forState:UIControlStateNormal];
        self.button.layer.cornerRadius = 6;
        self.button.backgroundColor = RGBCOLOR(161, 199, 166);
        [self.button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.button];
        
        CGFloat itemWidth = (self.frame.size.width-70)/3;
        
        self.item1 = [[XDSizeSetViewItem alloc] initWithFrame:CGRectMake(0, 0, itemWidth, 44)];
        self.item2 = [[XDSizeSetViewItem alloc] initWithFrame:CGRectMake(itemWidth, 0, itemWidth, 44)];
        self.item3 = [[XDSizeSetViewItem alloc] initWithFrame:CGRectMake(itemWidth*2, 0, itemWidth, 44)];
        
        [self.item1.label setText:@"长:"];
        [self.item2.label setText:@"宽:"];
        [self.item3.label setText:@"高:"];

        
        [self addSubview:self.item1];
        [self addSubview:self.item2];
        [self addSubview:self.item3];
        
        [self.item1.textField becomeFirstResponder];

        
    }
    return self;
}

- (void)buttonClicked
{
    
}

@end
