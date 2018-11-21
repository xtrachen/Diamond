//
//  XDImageUploadCollectionViewCell.h
//  Diamond
//
//  Created by Xtra on 2018/11/20.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XDImageUploadCollectionViewCell : UICollectionViewCell
@property (nonatomic, assign) NSInteger index;

- (void)setupWithImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END