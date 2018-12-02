//
//  XDUploadViewController.m
//  Diamond
//
//  Created by Xtra on 2018/11/20.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import "XDUploadViewController.h"
#import "XDImageUploadCollectionView.h"
#import "XDNetworkManager.h"

#import <HXWeiboPhotoPicker/HXPhotoPicker.h>
#import <Qiniu/QiniuSDK.h>



@interface XDUploadViewController () <UITextViewDelegate,HXAlbumListViewControllerDelegate,XDImageUploadCollectionViewDelegate>
@property (nonatomic, strong) IBOutlet UILabel *textViewNoticeLabel;
@property (nonatomic, strong) IBOutlet UIView *imgSelectWrapView;
@property (nonatomic, strong) XDImageUploadCollectionView *imgSelectView;
@property (nonatomic, weak) IBOutlet UIButton *pubButton;
@property (nonatomic, strong) HXPhotoManager *manager;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSMutableArray *uploadImageArray;
@property (nonatomic, weak) IBOutlet UITextField *titleField;
@property (nonatomic, weak) IBOutlet UITextView *textView;


@end

@implementation XDUploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.imgSelectView = [[XDImageUploadCollectionView alloc] initWithFrame:self.imgSelectWrapView.bounds];
    self.imgSelectView.delegate = self;
    [self.imgSelectWrapView addSubview:self.imgSelectView];
    self.pubButton.layer.cornerRadius = 3;
    self.uploadImageArray = [NSMutableArray array];
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
    
    if ([self.titleField.text length] == 0) {
        
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"缺失内容" message:@"请填写标题" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击了取消");
        }];
        [actionSheet addAction:action1];

        [self presentViewController:actionSheet animated:YES completion:nil];
        
        return;
    }
    
    if ([self.textView.text length] == 0) {
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"缺失内容" message:@"请填写描述内容" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击了取消");
        }];
        [actionSheet addAction:action1];
        
        [self presentViewController:actionSheet animated:YES completion:nil];
        return;
    }
    
    if ([self.imageArray count] == 0) {
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"缺失内容" message:@"请至少选择一张图片" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击了取消");
        }];
        [actionSheet addAction:action1];
        
        [self presentViewController:actionSheet animated:YES completion:nil];
        return;
    }
    
    [self uploadImages];
    
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
    self.imageArray = allList;
}

- (UIImage *)image:(UIImage *)originalImage ByCropToRect:(CGRect)rect {
    rect.origin.x *= originalImage.scale;
    rect.origin.y *= originalImage.scale;
    rect.size.width *= originalImage.scale;
    rect.size.height *= originalImage.scale; // pt -> px (point -> pixel)
    if (rect.size.width <= 0 || rect.size.height <= 0) return nil;
    CGImageRef imageRef = CGImageCreateWithImageInRect(originalImage.CGImage, rect);
    UIImage *image = [UIImage imageWithCGImage:imageRef scale:originalImage.scale orientation:originalImage.imageOrientation];
    CGImageRelease(imageRef);
    return image;
}

- (void)uploadImages
{
    
    [self.uploadImageArray removeAllObjects];
    
    
    for (int i = 0; i< [self.imageArray count] ; i++) {
        HXPhotoModel *model = [self.imageArray objectAtIndex:i];
        UIImage *oriImg = model.thumbPhoto;
        CGFloat sw = oriImg.size.width;
        CGFloat sh = oriImg.size.height;
        
        CGRect centerRect = CGRectZero;
        
        if (sw>sh) {
            centerRect = CGRectMake((sw-sh)/2, 0, sh, sh);
        } else {
            centerRect = CGRectMake(0, (sh-sw)/2, sw, sw);
        }
        
        // 剪裁中间区域，大小为原图片尺寸的一半
        UIImage *result = [self image:oriImg ByCropToRect:centerRect];
        
        __weak XDUploadViewController *weakself = self;
        
        [[XDNetworkManager defaultManager] sendRequestMethod:HTTPMethodGET serverUrl:@"http://www.xtra.ltd:8888" apiPath:@"/ios/qiniuauth" parameters:nil progress:^(NSProgress * _Nullable progress) {
            ;
        } success:^(BOOL isSuccess, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            
            NSString *token = [responseObject objectForKey:@"token"];
            NSString *uuid = [responseObject objectForKey:@"uuid"];
            
            if (token && uuid) {
                
                
                QNConfiguration *config = [QNConfiguration build:^(QNConfigurationBuilder *builder) {
                    builder.zone = [QNFixedZone zone2];
                }];
                
                QNUploadManager *upManager = [[QNUploadManager alloc] initWithConfiguration:config];
                NSData *data = UIImageJPEGRepresentation(result, 0.8);
                [upManager putData:data key:[NSString stringWithFormat:@"%@.jpg",uuid] token:token
                          complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                              NSLog(@"%@", info);
                              NSLog(@"%@", resp);
                              [self.uploadImageArray addObject:uuid];
                              if (i == [weakself.imageArray count]-1) {
                                  [self handleImageUploaded];
                              }
                              
                          } option:nil];
            }
            
        } failure:^(NSString * _Nullable errorMessage) {
            NSLog(@"%@",errorMessage);
        }];
    }
}

- (void)handleImageUploaded
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:self.titleField.text forKey:@"title"];
    [dict setObject:self.textView.text forKey:@"markdown"];
    [dict setObject:@" " forKey:@"category"];
    [dict setObject:@" " forKey:@"ptype"];
    [dict setObject:[NSNumber numberWithInt:0] forKey:@"price"];
    [dict setObject:@" " forKey:@"color"];
    
    [dict setObject:[NSNumber numberWithInt:0] forKey:@"length"];
    [dict setObject:[NSNumber numberWithInt:0] forKey:@"width"];
    [dict setObject:[NSNumber numberWithInt:0] forKey:@"height"];
    [dict setObject:@" " forKey:@"weight"];

    [dict setObject:[NSNumber numberWithDouble:0] forKey:@"lat"];
    [dict setObject:[NSNumber numberWithDouble:0] forKey:@"lng"];
    
    [dict setObject:@" " forKey:@"city"];
    [dict setObject:@" " forKey:@"region"];
    [dict setObject:@" " forKey:@"tag"];
    [dict setObject:@" " forKey:@"sidestone"];
    [dict setObject:@" " forKey:@"gold"];
    [dict setObject:@" " forKey:@"designby"];
    [dict setObject:[NSNumber numberWithInt:0] forKey:@"storage"];
    [dict setObject:@" " forKey:@"store"];
    [dict setObject:@" " forKey:@"remarks"];

    NSString *imgStr =[self.uploadImageArray componentsJoinedByString:@","];
    [dict setObject:imgStr forKey:@"imgstr"];
    
    [[XDNetworkManager defaultManager] sendRequestMethod:HTTPMethodGET serverUrl:@"http://www.xtra.ltd:8888" apiPath:@"/ios/addproduct" parameters:dict progress:^(NSProgress * _Nullable progress) {
        ;
    } success:^(BOOL isSuccess, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    } failure:^(NSString * _Nullable errorMessage) {
        NSLog(@"%@",errorMessage);
    }];
}






@end
