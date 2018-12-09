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
#import "XDTextSetTableViewCell.h"
#import "XDTagSelectView.h"
#import "XDInputTextView.h"
#import "XDSizeSetView.h"

#import <HXWeiboPhotoPicker/HXPhotoPicker.h>
#import <Qiniu/QiniuSDK.h>



@interface XDUploadViewController () <UITextViewDelegate,
HXAlbumListViewControllerDelegate,
XDImageUploadCollectionViewDelegate,
XDTagSelectViewDelegate,
XDTextSetTableViewCellDelegate,
XDInputTextViewDelegate>
@property (nonatomic, strong) IBOutlet UILabel *textViewNoticeLabel;
@property (nonatomic, strong) IBOutlet UIView *imgSelectWrapView;
@property (nonatomic, strong) IBOutlet UIView *priceWrapView;
@property (nonatomic, strong) IBOutlet UIView *tagWrapView;
@property (nonatomic, strong) XDImageUploadCollectionView *imgSelectView;
@property (nonatomic, weak) IBOutlet UIButton *pubButton;
@property (nonatomic, strong) HXPhotoManager *manager;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSMutableArray *uploadImageArray;
@property (nonatomic, weak) IBOutlet UITextField *titleField;
@property (nonatomic, weak) IBOutlet UITextView *textView;


@property (nonatomic, strong) XDTextSetTableViewCell *priceCell;
@property (nonatomic, strong) XDTextSetTableViewCell *tagCell;

@property (nonatomic, weak) IBOutlet UILabel *categoryLabel;
@property (nonatomic, weak) IBOutlet UILabel *typeLabel;
@property (nonatomic, weak) IBOutlet UILabel *colorLabel;
@property (nonatomic, weak) IBOutlet UILabel *weightLabel;
@property (nonatomic, weak) IBOutlet UILabel *sizeLabel;
@property (nonatomic, weak) IBOutlet UILabel *storageLabel;

@property (nonatomic, assign) int length;
@property (nonatomic, assign) int width;
@property (nonatomic, assign) int height;

@property (nonatomic, strong) XDSizeSetView *sizeSetView;

@property (nonatomic, strong) XDTagSelectView *tagSelectView;
@property (nonatomic, strong) XDInputTextView *inputTextView;

@end

@implementation XDUploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.imgSelectView = [[XDImageUploadCollectionView alloc] initWithFrame:self.imgSelectWrapView.bounds];
    self.imgSelectView.delegate = self;
    [self.imgSelectWrapView addSubview:self.imgSelectView];
    self.pubButton.layer.cornerRadius = 3;
    self.uploadImageArray = [NSMutableArray array];
    
    // price
    self.priceCell = [[[NSBundle mainBundle] loadNibNamed:@"XDTextSetTableViewCell" owner:self options:nil] lastObject];
    self.priceCell.label.text = @"价格";
    [self.priceCell setFrame:self.priceWrapView.bounds];
    [self.priceCell setDelegate:self];
    [self.priceWrapView addSubview:self.priceCell];
    
    
    // tag
    self.tagCell = [[[NSBundle mainBundle] loadNibNamed:@"XDTextSetTableViewCell" owner:self options:nil] lastObject];
    self.tagCell.label.text = @"标签";
    [self.tagCell setDelegate:self];
    self.tagCell.frame = self.tagWrapView.bounds;
    [self.tagWrapView addSubview:self.tagCell];
    
    // keyboard
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.priceCell setFrame:self.priceWrapView.bounds];
    [self.tagCell setFrame:self.tagWrapView.bounds];
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

// factory of tag select view
- (XDTagSelectView *)createTagSelectViewWith:(NSArray *)array
{
    if (self.tagSelectView) {
        [self.tagSelectView removeFromSuperview];
    }
    
    self.tagSelectView  = [[XDTagSelectView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.width*3/4)];
    [self.tagSelectView setupWith:array];
    self.tagSelectView.backgroundColor = RGBCOLOR(245, 245, 245);

    [self.view addSubview:self.tagSelectView];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.tagSelectView.top = self.view.height-self.tagSelectView.height;
        self.tagSelectView.delegate = self;
    } completion:^(BOOL finished) {
        ;
    }];

    return self.tagSelectView;
}


- (IBAction)cateButtonClicked:(id)sender
{
    NSArray *array = [NSArray arrayWithObjects:@"蓝宝石",@"钻石",@"翡翠",@"红宝石",@"水晶",@"珍珠",@"珊瑚", nil];

    [self createTagSelectViewWith:array];

    [self.tagSelectView setType:TagSelectViewSource_Category];

}

- (IBAction)typeButtonClicked:(id)sender
{
    if (self.tagSelectView) {
        [self.tagSelectView removeFromSuperview];
    }
    
    NSArray *array = [NSArray arrayWithObjects:@"项链",@"手链",@"戒指",@"手镯",@"胸针",@"袖口",@"套装", nil];
    
    self.tagSelectView  = [[XDTagSelectView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.width*3/4)];
    [self.tagSelectView setupWith:array];
    self.tagSelectView.backgroundColor = RGBCOLOR(245, 245, 245);
    [self.view addSubview:self.tagSelectView];
    [UIView animateWithDuration:0.3 animations:^{
        
        self.tagSelectView.top = self.view.height-self.tagSelectView.height;
        [self.tagSelectView setType:TagSelectViewSource_Type];
        self.tagSelectView.delegate = self;
    } completion:^(BOOL finished) {
        ;
    }];
}

- (IBAction)colorButtonClicked:(id)sender
{
    NSArray *array =[self colorArrayWithCategory:self.categoryLabel.text];
    if (array && [array count] > 0) {
        [self createTagSelectViewWith:array];
        [self.tagSelectView setType:TagSelectViewSource_Color];
    }
}

- (NSArray *)colorArrayWithCategory:(NSString *)category
{
    NSArray *array = nil;
    
    if ([category isEqualToString:@"蓝宝石"]) {
        array = [NSArray arrayWithObjects:@"皇家蓝",@"矢车菊蓝",@"孔雀蓝",@"蓝色",@"粉色",@"黄色",@"白色", nil];
    } else if ([category isEqualToString:@"钻石"]) {
        array = [NSArray arrayWithObjects:@"D",@"E",@"F",@"G",@"H",@"I-J",@"K-L", nil];
    } else if ([category isEqualToString:@"翡翠"]) {
        array = [NSArray arrayWithObjects:@"正阳绿",@"辣绿",@"祖母绿",@"晴水",@"蓝水",@"白色",@"飘花", nil];
    } else if ([category isEqualToString:@"红宝石"]) {
        array = [NSArray arrayWithObjects:@"鸽血红",@"正红",@"粉红", nil];
    } else if ([category isEqualToString:@"水晶"]) {
        array = [NSArray arrayWithObjects:@"紫色",@"黄色",@"白色",@"粉晶",@"幽灵水晶",@"茶晶",@"兔毛晶", nil];
    } else if ([category isEqualToString:@"珍珠"]) {
        array = [NSArray arrayWithObjects:@"白色",@"粉色",@"绿色",@"黑色",@"金色",@"灰色",@"银色", nil];
    } else if ([category isEqualToString:@"珊瑚"]) {
        array = [NSArray arrayWithObjects:@"牛血红",@"粉色",@"红色",@"白色", nil];
    }
    return array;
    
}

- (IBAction)weigthButtonClicked:(id)sender
{

    if (self.inputTextView) {
        [self.inputTextView removeFromSuperview];
        self.inputTextView = nil;
    }
    
    self.inputTextView = [[XDInputTextView alloc] initWithFrame:CGRectMake(0, self.view.bottom-44, self.view.width, 44)];
    [self.view addSubview:self.inputTextView];
    
    [self.inputTextView.textField setKeyboardType:UIKeyboardTypeNumberPad];
    [self.inputTextView setType:XDInputTextViewType_Weight];
    
    [self.inputTextView.textField becomeFirstResponder];
    [self.inputTextView setDelegate:self];
}

- (void)XDTagSelectViewFinishSelected:(TagSelectViewSource)type str:(NSString *)str
{
    
    if (self.tagSelectView) {
        [UIView animateWithDuration:0.3 animations:^{
            self.tagSelectView.top = self.view.bottom;
        } completion:^(BOOL finished) {
            [self.tagSelectView removeFromSuperview];
            self.tagSelectView = nil;
        }];
    }
    
    switch (type) {
        case TagSelectViewSource_Category: {
            [self.categoryLabel setText:str];
        }
            break;
        case TagSelectViewSource_Type: {
            [self.typeLabel setText:str];
        }
            break;
        case TagSelectViewSource_Color: {
            [self.colorLabel setText:str];
        }
            break;
        default:
            break;
    }
}

- (void)XDTextSetTableViewCellClicked:(id)sender
{
    if (self.inputTextView) {
        [self.inputTextView removeFromSuperview];
        self.inputTextView = nil;
    }
    
    self.inputTextView = [[XDInputTextView alloc] initWithFrame:CGRectMake(0, self.view.bottom-44, self.view.width, 44)];
    [self.view addSubview:self.inputTextView];

    
    if ([sender isEqual:self.priceCell]) {
        [self.inputTextView.textField setKeyboardType:UIKeyboardTypeNumberPad];
        [self.inputTextView setType:XDInputTextViewType_Price];
    } else if ([sender isEqual:self.tagCell]) {
        [self.inputTextView setType:XDInputTextViewType_Tag];
    }
    
    [self.inputTextView.textField becomeFirstResponder];
    [self.inputTextView setDelegate:self];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    //获取处于焦点中的view
    CGRect kbY = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:duration animations:^{
        if (self.inputTextView) {
            self.inputTextView.top = self.view.height-kbY.size.height-44;
        }
        if (self.sizeSetView) {
            self.sizeSetView.top = self.view.height-kbY.size.height-44;
        }
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    //获取键盘弹出的时间
    double duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //还原
    [UIView animateWithDuration:duration animations:^{
        if (self.inputTextView) {
            self.inputTextView.top = self.view.bottom;
        }
        
        if (self.sizeSetView) {
            self.sizeSetView.top = self.view.bottom;
        }
    } completion:^(BOOL finished) {
        if (self.inputTextView) {
            [self.inputTextView removeFromSuperview];
            self.inputTextView = nil;
        }
        if (self.sizeSetView) {
            [self.sizeSetView removeFromSuperview];
            self.sizeSetView = nil;
        }
    }];
}

// XDInputTextViewDelegate
- (void)XDInputTextViewDidFinish:(XDInputTextViewType)type str:(NSString *)str;
{
    switch (type) {
        case XDInputTextViewType_Price: {
            [self.priceCell.textField setText:str];
        }
            break;
        case XDInputTextViewType_Tag: {
            [self.tagCell.textField setText:str];
        }
            break;
        case XDInputTextViewType_Weight: {
            [self.weightLabel setText:str];
        }
            break;
        case XDInputTextViewType_Storage: {
            [self.storageLabel setText:str];
        }
            break;
        default:
            break;
    }
    [self.inputTextView.textField endEditing:YES];
}

- (IBAction)sizeButtonClicked:(id)sender
{
    if (self.sizeSetView) {
        [self.sizeSetView removeFromSuperview];
        self.sizeSetView = nil;
    }
    
    self.sizeSetView = [[XDSizeSetView alloc] initWithFrame:CGRectMake(0, self.view.height-44, self.view.width, 44)];
    [self.view addSubview:self.sizeSetView];
}

- (IBAction)storageButtonClicked:(id)sender
{
    
    if (self.inputTextView) {
        [self.inputTextView removeFromSuperview];
        self.inputTextView = nil;
    }
    
    self.inputTextView = [[XDInputTextView alloc] initWithFrame:CGRectMake(0, self.view.bottom-44, self.view.width, 44)];
    [self.view addSubview:self.inputTextView];
    
    [self.inputTextView.textField setKeyboardType:UIKeyboardTypeNumberPad];
    [self.inputTextView setType:XDInputTextViewType_Storage];
    
    [self.inputTextView.textField becomeFirstResponder];
    [self.inputTextView setDelegate:self];
    
}

@end
