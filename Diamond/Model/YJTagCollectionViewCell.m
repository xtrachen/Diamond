//
//  YJTagCollectionViewCell.m
//  tagsView
//
//  Created by Jake on 2017/6/22.
//  Copyright © 2017年 Jakey. All rights reserved.
//

#import "YJTagCollectionViewCell.h"

@interface YJTagCollectionViewCell () <UIGestureRecognizerDelegate>


@end

@implementation YJTagCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    tapRecognize.numberOfTapsRequired = 1;
    tapRecognize.delegate = self;
    [tapRecognize setEnabled :YES];
    [tapRecognize delaysTouchesBegan];
    [tapRecognize cancelsTouchesInView];
    [self addGestureRecognizer:tapRecognize];
    
    self.layer.borderWidth = 1;
    self.layer.borderColor = ([UIColor lightGrayColor]).CGColor;
    
}

- (void)setContent:(NSString *)content
{
    _content = content;
    [_tagLabel setText:content];
}

+ (CGSize) getSizeWithContent:(NSString *) content maxWidth:(CGFloat)maxWidth customHeight:(CGFloat)cellHeight
{
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize size = [content boundingRectWithSize:CGSizeMake(maxWidth-20, 24) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12],NSParagraphStyleAttributeName:style} context:nil].size;
    return CGSizeMake(size.width+20, cellHeight);
}

-(void) handleTap:(UITapGestureRecognizer *)recognizer
{
    self.isSelected = !self.isSelected;
    
    if (self.isSelected) {
        self.tagLabel.textColor = RGBCOLOR(161, 199, 166);
        self.layer.borderColor = (RGBCOLOR(161, 199, 166)).CGColor;
    } else {
        self.tagLabel.textColor = [UIColor lightGrayColor];
        self.layer.borderColor = ([UIColor lightGrayColor]).CGColor;
    }
}


@end
