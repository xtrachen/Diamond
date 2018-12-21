//
//  XDTimeupButtonView.m
//  Diamond
//
//  Created by Xtra on 2018/12/21.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import "XDTimeupButtonView.h"

@interface XDTimeupButtonView ()
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int countMark;

@end

@implementation XDTimeupButtonView

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
        self.button = [[UIButton alloc] initWithFrame:self.bounds];
        [self addSubview:self.button];
        [self.button setTitle:@"发送" forState:UIControlStateNormal];
        [self.button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)start
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.countMark = 60;
    [self.button setEnabled:NO];
    __weak XDTimeupButtonView *weakself = self;
    
    self.timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self.button setTitle:[NSString stringWithFormat:@"%d",weakself.countMark] forState:UIControlStateNormal];
        weakself.countMark--;
        if (weakself.countMark==0) {
            [weakself handleTimeup];
        }
    }];
}

- (void)handleTimeup
{
    [self.timer invalidate];
    self.timer = nil;
    [self.button setTitle:@"发送" forState:UIControlStateNormal];
    [self.button setEnabled:YES];
}

- (void)stop
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)buttonClicked
{
    [self start];
}

@end
