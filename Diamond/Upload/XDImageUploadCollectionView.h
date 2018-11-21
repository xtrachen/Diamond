//
//  XDImageUploadCollectionView.h
//  Diamond
//
//  Created by Xtra on 2018/11/20.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol XDImageUploadCollectionViewDelegate <NSObject>
- (void)XDImageUploadCollectionViewAddImage;


@end


@class HXPhotoManager;
@interface XDImageUploadCollectionView : UIView
@property (nonatomic, weak) id<XDImageUploadCollectionViewDelegate> delegate;

- (void)addImages:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END