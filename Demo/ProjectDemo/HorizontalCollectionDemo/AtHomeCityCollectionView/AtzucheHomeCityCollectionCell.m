//
//  AtzucheHomeCityCollectionCell.m
//  Demo
//
//  Created by ChenJie on 2018/1/29.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "AtzucheHomeCityCollectionCell.h"

#define itemW       SCREEN_WIDTH * 100/375.0

@implementation AtzucheHomeCityCollectionCell

- (UIImageView *)cityImageV {
    if (_cityImageV == nil) {
        _cityImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, itemW, itemW)];
        _cityImageV.userInteractionEnabled = YES;
    }
    return _cityImageV;
}

- (UILabel *)cityNameL {
    if (_cityNameL == nil) {
        _cityNameL = [[UILabel alloc] initWithFrame:CGRectMake(self.cityImageV.x, self.cityImageV.bottom, self.cityImageV.width, 35)];
        _cityNameL.backgroundColor = [UIColor purpleColor];
        _cityNameL.text = @"上海";
    }
    return _cityNameL;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.cityImageV];
        [self addSubview:self.cityNameL];
    }
    return self;
}

@end
