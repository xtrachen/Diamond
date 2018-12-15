//
//  XDDetailDoubleTableViewCell.h
//  Diamond
//
//  Created by 陈国贤 on 2018/12/15.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XDDetailDoubleTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *leftNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *leftAttributeLabel;
@property (nonatomic, weak) IBOutlet UILabel *rightNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *rightAttributeLabel;


@end

NS_ASSUME_NONNULL_END
