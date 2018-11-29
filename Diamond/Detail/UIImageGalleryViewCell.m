//
//  UIImageGalleryViewCell.m
//  Diamond
//
//  Created by 陈国贤 on 2018/11/29.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import "UIImageGalleryViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface UIImageGalleryViewCell ()
@property (nonatomic, strong) UIImageView *image;

@end

@implementation UIImageGalleryViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.image = [[UIImageView alloc] initWithFrame:self.bounds];
    [self.contentView addSubview:self.image];
    
}

- (void)setImageUrl:(NSString *)imageUrl
{
    [self.image sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self.image setFrame:self.bounds];
}


@end
