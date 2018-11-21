//
//  XDUploadViewController.m
//  Diamond
//
//  Created by Xtra on 2018/11/20.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import "XDUploadViewController.h"
#import "XDImageUploadCollectionView.h"
#import <HXWeiboPhotoPicker/HXPhotoPicker.h>


@interface XDUploadViewController () <UITextViewDelegate,HXAlbumListViewControllerDelegate,XDImageUploadCollectionViewDelegate>
@property (nonatomic, strong) IBOutlet UILabel *textViewNoticeLabel;
@property (nonatomic, strong) IBOutlet UIView *imgSelectWrapView;
@property (nonatomic, strong) XDImageUploadCollectionView *imgSelectView;
@property (nonatomic, weak) IBOutlet UIButton *pubButton;
@property (nonatomic, strong) HXPhotoManager *manager;


@end

@implementation XDUploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.imgSelectView = [[XDImageUploadCollectionView alloc] initWithFrame:self.imgSelectWrapView.bounds];
    self.imgSelectView.delegate = self;
    [self.imgSelectWrapView addSubview:self.imgSelectView];
    self.pubButton.layer.cornerRadius = 3;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView.text.length+text.length > 0) {
        self.textViewNoticeLabel.hidden = YES;
    } else {
        self.textViewNoticeLabel.hidden = NO;
    }
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)cancelButtonClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)pubButtonClicked:(id)sender
{
    
}

- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
    }
    return _manager;
}

- (void)addImage
{
    // 照片选择控制器
    HXAlbumListViewController *vc = [[HXAlbumListViewController alloc] init];
    vc.delegate = self;
    vc.manager = self.manager;
    [self presentViewController:[[HXCustomNavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
}

- (void)XDImageUploadCollectionViewAddImage
{
    [self addImage];
}

- (void)albumListViewController:(HXAlbumListViewController *)albumListViewController didDoneAllList:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photoList videos:(NSArray<HXPhotoModel *> *)videoList original:(BOOL)original
{
    NSMutableArray *array = [NSMutableArray array];
    for (HXPhotoModel *model in allList) {
        [array addObject:model.thumbPhoto];
    }
    
    [self.imgSelectView addImages:array];
}


@end
