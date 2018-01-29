//
//  AtzucheHomeTitleCollectionCell.m
//  Demo
//
//  Created by ChenJie on 2018/1/29.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "AtzucheHomeTitleCollectionCell.h"

@implementation AtzucheHomeTitleCollectionCell

- (UILabel *)titleL {
    if (_titleL == nil) {
        _titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _titleL.textAlignment = NSTextAlignmentCenter;
    }
    return _titleL;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.titleL];
    }
    return self;
}

@end
