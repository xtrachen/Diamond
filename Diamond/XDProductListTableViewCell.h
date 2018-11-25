//
//  XDProductListTableViewCell.h
//  Diamond
//
//  Created by Xtra on 2018/11/15.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class XDProductDetailInfo;

@interface XDProductListTableViewCell : UITableViewCell

- (void)setupWith:(XDProductDetailInfo *)info;

@end

NS_ASSUME_NONNULL_END
