//
//  XDSizeSetView.h
//  Diamond
//
//  Created by 陈国贤 on 2018/12/9.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol XDSizeSetViewDelegate <NSObject>
- (void)XDSizeSetViewSetFinish:(int)length width:(int)width height:(int)height;

@end

@interface XDSizeSetView : UIView
@property (nonatomic, assign) int length;
@property (nonatomic, assign) int width;
@property (nonatomic, assign) int height;
@property (nonatomic, weak) id<XDSizeSetViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
