//
//  AtzucheHomeTitleCollectionView.m
//  Demo
//
//  Created by ChenJie on 2018/1/29.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "AtzucheHomeTitleCollectionView.h"
#import "AtzucheHomeTitleCollectionCell.h"

@interface AtzucheHomeTitleCollectionView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation AtzucheHomeTitleCollectionView

static NSString *reuseID = @"AtzucheHomeTitleCollectionCell";

- (void)setHomeTitleAry:(NSArray *)homeTitleAry {
    _homeTitleAry = homeTitleAry;
    [self reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        [self registerClass:[AtzucheHomeTitleCollectionCell class] forCellWithReuseIdentifier:reuseID];
        //[self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:UICollectionElementKindSectionHeader];
        
        self.dataSource = self;
        self.delegate = self;
        
        self.showsVerticalScrollIndicator = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.userInteractionEnabled = YES;
        self.scrollEnabled = YES;
        
        self.backgroundColor = [UIColor whiteColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.showsHorizontalScrollIndicator = NO;
        self.decelerationRate = UIScrollViewDecelerationRateNormal;
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.homeTitleAry.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AtzucheHomeTitleCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    if (_homeTitleAry.count) {
        cell.backgroundColor = [UIColor purpleColor];
        cell.titleL.text = [self.homeTitleAry objectAtIndex:indexPath.row];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
