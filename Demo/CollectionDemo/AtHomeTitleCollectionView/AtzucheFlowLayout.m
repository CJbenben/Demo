//
//  AtzucheFlowLayout.m
//  Demo
//
//  Created by ChenJie on 2018/1/29.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "AtzucheFlowLayout.h"

@implementation AtzucheFlowLayout

- (instancetype)initAndSize:(CGSize)size {
    if (self = [super init]) {
        self.headerReferenceSize = CGSizeZero;
        self.footerReferenceSize = CGSizeZero;
        
        self.itemSize = size;
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}

//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
//    //计算最终显示的矩形框
//    CGRect rect;
//    rect.origin.x = proposedContentOffset.x;
//    rect.origin.y = 0;
//    rect.size = self.collectionView.frame.size;
//
//    //获取最终显示在矩形框中的元素的布局属性
//    NSArray *array = [super layoutAttributesForElementsInRect:rect];
//
//    //获取UICollectionView的中点，以contentView的左上角为原点
//    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.25;
//
//    //获取所有元素到中点的最短距离
//    CGFloat minDelta = MAXFLOAT;
//    for (UICollectionViewLayoutAttributes *attribute in array)
//    {
//        CGFloat delta = attribute.center.x - centerX;
//        if (ABS(minDelta) > ABS(delta))
//        {
//            minDelta = delta;
//        }
//    }
//
//    //改变UICollectionView的偏移量
//    proposedContentOffset.x += minDelta;
//    //proposedContentOffset.x += self.coll
//    return proposedContentOffset;
//}

@end
