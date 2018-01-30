//
//  AtzucheHomeTitleCollectionCell.m
//  Demo
//
//  Created by ChenJie on 2018/1/29.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "AtzucheHomeTitleCollectionCell.h"

@implementation AtzucheHomeTitleCollectionCell

- (UIImageView *)titleImageV {
    if (_titleImageV == nil) {
        _titleImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.width)];
        _titleImageV.userInteractionEnabled = YES;
        _titleImageV.backgroundColor = [UIColor yellowColor];
    }
    return _titleImageV;
}

- (UILabel *)titleL {
    if (_titleL == nil) {
        _titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, self.titleImageV.bottom, self.titleImageV.width, 20)];
        _titleL.textAlignment = NSTextAlignmentCenter;
        _titleL.font = [UIFont systemFontOfSize:11];
    }
    return _titleL;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.titleImageV];
        [self addSubview:self.titleL];
    }
    return self;
}

@end
