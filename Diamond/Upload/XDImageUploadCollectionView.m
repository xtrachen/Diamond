//
//  XDImageUploadCollectionView.m
//  Diamond
//
//  Created by Xtra on 2018/11/20.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import "XDImageUploadCollectionView.h"
#import "XDImageUploadCollectionViewCell.h"


@interface XDImageUploadCollectionView () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation XDImageUploadCollectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(50, 50);

        self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        
        [self.collectionView registerClass:[XDImageUploadCollectionViewCell class] forCellWithReuseIdentifier:@"XDImageUploadCollectionViewCell"];
        [self.collectionView registerNib:[UINib nibWithNibName:@"XDImageUploadCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"XDImageUploadCollectionViewCell"];
//        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"XDImageUploadCollectionViewCell"];
//        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
        
        
        [self addSubview:self.collectionView];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.array = [NSMutableArray array];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([self.array count] < 4) {
        return [self.array count]+1;
    } else {
        return 4;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    XDImageUploadCollectionViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"XDImageUploadCollectionViewCell" owner:self options:nil] lastObject];
    XDImageUploadCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"XDImageUploadCollectionViewCell" forIndexPath:indexPath];
    
    if (indexPath.row < [self.array count]) {
        UIImage *image = [self.array objectAtIndex:indexPath.row];
        [cell setupWithImage:image];
    }

    
    cell.index = indexPath.row;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row == [self.array count]) {
        [self.delegate XDImageUploadCollectionViewAddImage];
    } else {
        
    }
}

- (void)addImages:(NSArray *)array
{
    if ([self.array count] > 0) {
        [self.array removeAllObjects];
    }
    
    [self.array addObjectsFromArray:array];
    [self.collectionView reloadData];
}



@end
