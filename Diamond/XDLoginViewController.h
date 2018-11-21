//
//  XDLoginViewController.h
//  Diamond
//
//  Created by Xtra on 2018/11/15.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XDLoginViewControllerDelegate <NSObject>
- (void)XDLoginViewControllerLoginFinish;

@end

@interface XDLoginViewController : UIViewController
@property (nonatomic, weak) id<XDLoginViewControllerDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
