//
//  RACTestView.m
//  Demo
//
//  Created by ChenJie on 2018/9/26.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "RACTestView.h"

@interface RACTestView ()

@property (nonatomic, strong) UIButton *testBtn;

@end

@implementation RACTestView

- (UIButton *)testBtn {
    if (_testBtn == nil) {
        _testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _testBtn.backgroundColor = [UIColor cyanColor];
        _testBtn.frame = CGRectMake(100, 100, 200, 200);
        [_testBtn setTitle:@"test" forState:UIControlStateNormal];
        [_testBtn addTarget:self action:@selector(testBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _testBtn;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.testBtn];
        
    }
    return self;
}

- (void)testBtnAction {
    //RACSignal *signal =  [command execute:@"输入命令！"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
