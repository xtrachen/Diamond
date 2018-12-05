//
//  XDInputTextView.m
//  Diamond
//
//  Created by Xtra on 2018/12/5.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import "XDInputTextView.h"


@interface XDInputTextView ()
@property (nonatomic, strong) UIButton *button;

@end


@implementation XDInputTextView

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
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 7, self.width-10-10-60, 30)];
        self.button = [[UIButton alloc] initWithFrame:CGRectMake(self.width-10-60, 7, 60, 30)];
        [self addSubview:self.textField];
        [self addSubview:self.button];
        self.button.backgroundColor = RGBCOLOR(161, 199, 166);
        self.button.layer.cornerRadius = 6;
        [self.button setTitle:@"确定" forState:UIControlStateNormal];
        
    }
    return self;
}

@end
