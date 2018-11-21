//
//  XDImageUploadCollectionViewCell.m
//  Diamond
//
//  Created by Xtra on 2018/11/20.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import "XDImageUploadCollectionViewCell.h"

@interface XDImageUploadCollectionViewCell ()
@property (nonatomic, weak) IBOutlet UIImageView *image;


@end

@implementation XDImageUploadCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor blackColor];
}

- (void)setupWithImage:(UIImage *)image
{
    [self.image setImage:image];
}


@end
