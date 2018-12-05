//
//  XDTextSetTableViewCell.h
//  Diamond
//
//  Created by Xtra on 2018/12/3.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XDTextSetTableViewCellDelegate <NSObject>
- (void)XDTextSetTableViewCellClicked:(id)sender;

@end

@interface XDTextSetTableViewCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel *label;
@property (nonatomic, strong) IBOutlet UITextField *textField;
@property (nonatomic, weak) id<XDTextSetTableViewCellDelegate> delegate;




@end

NS_ASSUME_NONNULL_END
