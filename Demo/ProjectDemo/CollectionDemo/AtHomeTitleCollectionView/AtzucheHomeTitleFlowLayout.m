//
//  AtzucheFlowLayout.m
//  Demo
//
//  Created by ChenJie on 2018/1/29.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "AtzucheHomeTitleFlowLayout.h"

@implementation AtzucheHomeTitleFlowLayout

- (instancetype)initAndSize:(CGSize)size count:(NSInteger)count {
    if (self = [super init]) {
        self.headerReferenceSize = CGSizeZero;
        self.footerReferenceSize = CGSizeZero;
        
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.itemSize = size;
        if (count == 2) {
            // 边距和间距相等处理
            CGFloat spacing = (SCREEN_WIDTH - count * 45)/(count + 1);
            self.minimumLineSpacing = spacing;
            self.minimumInteritemSpacing = spacing;
        } else if (count == 3) {
            // 固定边距 40pt
            CGFloat spacing = (SCREEN_WIDTH - count * 45 - 2 * 40)/(count - 1);
            self.minimumLineSpacing = spacing;
            self.minimumInteritemSpacing = spacing;
            if (IS_IPHONE_6_PLUS) {
                self.minimumLineSpacing = 80;
                self.minimumInteritemSpacing = 80;
            }
//            if (IS_IPHONE_5) {
//                self.minimumLineSpacing = 52.5;
//                self.minimumInteritemSpacing = 52.5;
//            } else {
//                self.minimumLineSpacing = 80;
//                self.minimumInteritemSpacing = 80;
//            }
        } else if (count == 4) {
            // 固定边距 22.5pt
            CGFloat spacing = (SCREEN_WIDTH - count * 45 - 2 * 22.5)/(count - 1);
            self.minimumLineSpacing = spacing;
            self.minimumInteritemSpacing = spacing;
//            if (IS_IPHONE_5) {
//                self.minimumLineSpacing = 31.5;
//                self.minimumInteritemSpacing = 31.5;
//            } else if (IS_IPHONE_6) {
//                self.minimumLineSpacing = 50;
//                self.minimumInteritemSpacing = 50;
//            } else if (IS_IPHONE_6_PLUS) {
//                self.minimumLineSpacing = 63;
//                self.minimumInteritemSpacing = 63;
//            } else {
//                self.minimumLineSpacing = 50;
//                self.minimumInteritemSpacing = 50;
//            }
        } else {
            self.minimumLineSpacing = 35.5;
            self.minimumInteritemSpacing = 35.5;
        }
        
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
