//
//  AtzucheHomeNaviView.m
//  Demo
//
//  Created by ChenJie on 2018/1/29.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "AtzucheHomeNaviView.h"

@interface AtzucheHomeNaviView()

@end

@implementation AtzucheHomeNaviView

- (NJTitleButton *)cityBtn
{
    if (!_cityBtn) {
        _cityBtn = [[NJTitleButton alloc]initWithFrame:CGRectMake(20, 20 + 15, 100, 44)];
        [_cityBtn setupWithFont:[UIFont systemFontOfSize:13]];
        [_cityBtn setImage:[UIImage imageNamed:@"chooseCar_downArrow"] forState:UIControlStateNormal];
//        if (![AtzucheUserDefaultConfig currentConfig].cityName) {
//            [AtzucheUserDefaultConfig currentConfig].cityName = @"上海";
//        }
//        [_cityBtn setTitle:[AtzucheUserDefaultConfig currentConfig].cityName forState:UIControlStateNormal];
        [_cityBtn setTitleAndImageViewGap:3];
        [_cityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cityBtn addTarget:self action:@selector(cityBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_cityBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [self.cityBtn sizeToFit];
    }
    
    return _cityBtn;
}

- (UIView *)bgSearchV {
    if (_bgSearchV == nil) {
        _bgSearchV = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 200)/2.0, self.cityBtn.y, 200, self.cityBtn.height)];
        _bgSearchV.layer.cornerRadius = self.cityBtn.height/2.0;
        _bgSearchV.layer.masksToBounds = YES;
        _bgSearchV.backgroundColor = [UIColor lightGrayColor];
    }
    return _bgSearchV;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.cityBtn];
        [self addSubview:self.bgSearchV];
    }
    return self;
}

- (void)cityBtnAction {
    
}
@end
