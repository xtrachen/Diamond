//
//  XDTagSelectView.h
//  Diamond
//
//  Created by 陈国贤 on 2018/12/5.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    TagSelectViewSource_Category,
    TagSelectViewSource_Type,
    TagSelectViewSource_Color
}TagSelectViewSource;


@protocol XDTagSelectViewDelegate <NSObject>
- (void)XDTagSelectViewFinishSelected:(TagSelectViewSource)type str:(NSString *)str;

@end


@interface XDTagSelectView : UIView
@property (nonatomic, weak) id<XDTagSelectViewDelegate> delegate;
@property (nonatomic, assign) TagSelectViewSource type;

- (void)setupWith:(NSArray *)array;


@end

NS_ASSUME_NONNULL_END
