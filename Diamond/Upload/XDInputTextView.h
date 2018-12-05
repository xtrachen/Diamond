//
//  XDInputTextView.h
//  Diamond
//
//  Created by Xtra on 2018/12/5.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef enum {
    XDInputTextViewType_Price,
    XDInputTextViewType_Tag
}XDInputTextViewType;

@protocol XDInputTextViewDelegate <NSObject>
- (void)XDInputTextViewDidFinish:(XDInputTextViewType)type str:(NSString *)str;

@end


@interface XDInputTextView : UIView
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, weak) id<XDInputTextViewDelegate> delegate;
@property (nonatomic, assign) XDInputTextViewType type;

@end

NS_ASSUME_NONNULL_END
