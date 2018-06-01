//
//  AtItemCollectionViewCell.m
//  Demo
//
//  Created by ChenJie on 2018/6/1.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "AtItemCollectionViewCell.h"

#define itemW       SCREEN_WIDTH / 3.0
#define itemH       60

@interface AtItemCollectionViewCell()

@property (nonatomic, strong) UIView *rightV;
@property (nonatomic, strong) UIView *bottomV;

@end

@implementation AtItemCollectionViewCell

- (UIImageView *)itemIV {
    if (_itemIV == nil) {
        _itemIV = [[UIImageView alloc] initWithFrame:CGRectMake((itemW - 10)/2.0, 10, 10, 10)];
        _itemIV.backgroundColor = [UIColor cyanColor];
    }
    return _itemIV;
}

- (UILabel *)itemL {
    if (_itemL == nil) {
        _itemL = [[UILabel alloc] initWithFrame:CGRectMake(30, self.itemIV.bottom, itemW - 60, 30)];
        _itemL.textAlignment = NSTextAlignmentCenter;
        _itemL.text = @"itemL";
    }
    return _itemL;
}

- (UIButton *)itemBtn {
    if (_itemBtn == nil) {
        _itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _itemBtn.frame = CGRectMake(itemW - 30, self.itemL.y, 30, 30);
        _itemBtn.backgroundColor = [UIColor yellowColor];
    }
    return _itemBtn;
}

- (UIView *)rightV {
    if (_rightV == nil) {
        _rightV = [[UIView alloc] initWithFrame:CGRectMake(itemW - 0.5, 0, 0.5, itemH)];
        _rightV.backgroundColor = RGBCOLOR(215, 215, 215);
    }
    return _rightV;
}

- (UIView *)bottomV {
    if (_bottomV == nil) {
        _bottomV = [[UIView alloc] initWithFrame:CGRectMake(0, itemH - 0.5, itemW, 0.5)];
        _bottomV.backgroundColor = RGBCOLOR(215, 215, 215);
    }
    return _bottomV;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.itemIV];
        [self addSubview:self.itemL];
        [self addSubview:self.itemBtn];
        
        [self addSubview:self.rightV];
        [self addSubview:self.bottomV];
    }
    return self;
}

@end
