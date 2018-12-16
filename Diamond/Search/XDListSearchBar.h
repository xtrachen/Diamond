//
//  XDListSearchBar.h
//  Diamond
//
//  Created by 陈国贤 on 2018/12/16.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XDListSearchBarDelegate <NSObject>
- (void)XDListSearchBarSearchWith:(NSString *)str;

@end


@interface XDListSearchBar : UIView
@property (nonatomic, weak) id<XDListSearchBarDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
