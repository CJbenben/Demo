//
//  AtzucheHomeCityCollectionView.m
//  Demo
//
//  Created by ChenJie on 2018/1/29.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "AtzucheHomeCityCollectionView.h"
#import "AtzucheHomeCityCollectionCell.h"

@interface AtzucheHomeCityCollectionView()<UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation AtzucheHomeCityCollectionView

static NSString *reuseID = @"AtzucheHomeCityCollectionCell";

- (void)setHomeCityAry:(NSArray *)homeCityAry {
    _homeCityAry = homeCityAry;
    [self reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        [self registerClass:[AtzucheHomeCityCollectionCell class] forCellWithReuseIdentifier:reuseID];
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
    return self.homeCityAry.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AtzucheHomeCityCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    if (_homeCityAry.count) {
        [cell.cityImageV sd_setImageWithURL:[NSURL URLWithString:[self.homeCityAry objectAtIndex:indexPath.row]]];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
