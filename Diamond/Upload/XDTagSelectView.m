//
//  XDTagSelectView.m
//  Diamond
//
//  Created by 陈国贤 on 2018/12/5.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import "XDTagSelectView.h"
#import "YJTagView.h"


@interface XDTagSelectView () <YJTagViewDelegate,YJTagViewDataSource>
@property (nonatomic, strong) YJTagView *tagView;
@property (nonatomic, strong) NSArray *tagArray;
@property (nonatomic, strong) UIButton *button;

@end

@implementation XDTagSelectView

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
        
        self.button = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-16-60, 10, 60, 30)];
        [self.button setTitle:@"确定" forState:UIControlStateNormal];
        [self.button setBackgroundColor:RGBCOLOR(161, 199, 166)];
        self.button.layer.cornerRadius = 5;
        self.button.clipsToBounds = YES;
        [self.button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.button];
        
        
        self.tagView = [[YJTagView alloc] initWithFrame:CGRectMake(10, 50, self.width-20, self.height-50)];
        [self addSubview:self.tagView];
        self.tagView.delegate = self;
        self.tagView.dataSource = self;
        
    }
    return self;
}

- (NSInteger)numOfItems
{
    return [self.tagArray count];
}

- (NSString *)tagView:(YJTagView *)tagView titleForItemAtIndex:(NSInteger)index
{
    return [self.tagArray objectAtIndex:index];
}

- (void)setupWith:(NSArray *)array
{
    self.tagArray = array;
    [self.tagView reloadData];
}

- (void)buttonClicked
{
    NSString *str = [self.tagView getSelectedTagString];

    [self.delegate XDTagSelectViewFinishSelected:self.type str:str];
    
}

@end
