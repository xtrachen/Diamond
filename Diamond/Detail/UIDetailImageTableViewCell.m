//
//  UIDetailImageTableViewCell.m
//  Diamond
//
//  Created by 陈国贤 on 2018/11/29.
//  Copyright © 2018年 XtraSoft. All rights reserved.
//

#import "UIDetailImageTableViewCell.h"
#import "XDProductDetailInfo.h"
#import "UIImageGalleryViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface UIDetailImageTableViewLayout : UICollectionViewFlowLayout

@end

@implementation UIDetailImageTableViewLayout


//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
//{
//
//    CGFloat minOffset = CGFLOAT_MAX;
//    CGFloat horiCenter = proposedContentOffset.x + MLScreenWidth/2;
//    CGRect visibleRec = CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
//    NSArray *visibleAttributes = [super layoutAttributesForElementsInRect:visibleRec];
//
//    for (UICollectionViewLayoutAttributes *atts in visibleAttributes)
//    {
//        CGFloat itemCenterX = atts.center.x;
//        if (fabs(itemCenterX - horiCenter) <= fabs(minOffset)) {
//            minOffset = itemCenterX - horiCenter;
//        }
//
//    }
//    CGFloat centerOffsetX = proposedContentOffset.x + minOffset;
//    if (centerOffsetX < 0) {
//        centerOffsetX = 0;
//    }
//
//    if (centerOffsetX > self.collectionView.contentSize.width -(self.sectionInset.top + self.sectionInset.bottom + self.itemSize.height)) {
//        centerOffsetX = floor(centerOffsetX);
//    }
//
//    return CGPointMake(centerOffsetX,proposedContentOffset.y);
//
//}


@end




@interface UIDetailImageTableViewCell () <UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *imageArray;

@end

@implementation UIDetailImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UIDetailImageTableViewLayout *flow = [[UIDetailImageTableViewLayout alloc] init];
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flow.itemSize = CGSizeMake(MLScreenWidth, MLScreenWidth*3/4);

    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flow];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;

    [self.collectionView registerClass:[UIImageGalleryViewCell class] forCellWithReuseIdentifier:@"UIImageGalleryViewCell"];

    [self.contentView addSubview:self.collectionView];
    if ([self.imageArray count] > 0) {
        [self.collectionView reloadData];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

- (void)setupWith:(XDProductDetailInfo *)detail
{

    NSMutableArray *imgArray = [NSMutableArray array];
    
    for (NSString *imageId in detail.imageArray) {
        NSString *urlStr = [NSString stringWithFormat:@"http://phpdo3tsg.bkt.clouddn.com/%@.jpg",imageId];
        [imgArray addObject:urlStr];
    }
    self.imageArray = imgArray;
    [self.collectionView reloadData];
    
    
//    [self.icon sd_setImageWithURL:[NSURL URLWithString:urlStr]];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.imageArray count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIImageGalleryViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UIImageGalleryViewCell" forIndexPath:indexPath];

    NSString *url = [self.imageArray objectAtIndex:indexPath.row];
    [cell setImageUrl:url];
    
    return cell;
}


@end
