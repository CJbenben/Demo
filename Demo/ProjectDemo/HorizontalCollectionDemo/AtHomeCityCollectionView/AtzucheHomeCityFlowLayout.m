//
//  AtzucheHomeCityFlowLayout.m
//  Demo
//
//  Created by ChenJie on 2018/1/29.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "AtzucheHomeCityFlowLayout.h"

@implementation AtzucheHomeCityFlowLayout

- (instancetype)initAndSize:(CGSize)size {
    if (self = [super init]) {
        self.headerReferenceSize = CGSizeZero;
        self.footerReferenceSize = CGSizeZero;
        
        self.itemSize = size;
        self.minimumLineSpacing = 10;
        self.minimumInteritemSpacing = 0;
        self.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
    }
    return self;
}

@end
