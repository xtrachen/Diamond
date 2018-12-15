//
//  XDDetailSingleTableViewCell.h
//  Diamond
//
//  Created by 陈国贤 on 2018/12/15.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XDDetailSingleTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *attributeLabel;
@property (nonatomic, weak) IBOutlet UIView *line;

@end

NS_ASSUME_NONNULL_END
