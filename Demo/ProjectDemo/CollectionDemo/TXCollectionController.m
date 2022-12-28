//
//  TXCollectionController.m
//  Demo
//
//  Created by ChenJie on 2018/1/25.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "TXCollectionController.h"
#import "TXCycleScrollView.h"

@interface TXCollectionController ()

//@property (strong, nonatomic) CJCycleScrollView *scrollView;
@property (nonatomic, strong) TXCycleScrollView *atScrollView;

@property (nonatomic, strong) NSMutableArray *imageAry;

@end

@implementation TXCollectionController

- (NSMutableArray *)imageAry {
    if (_imageAry == nil) {
        _imageAry = [@[@"http://down.tutu001.com/d/file/20110312/ae15ebaebfa15428826432e50e_560.jpg",
                       @"http://down.tutu001.com/d/file/20120315/29e47a7c992f6f1d978bfc6d8d_560.jpg",
                       @"http://pic23.nipic.com/20120919/10785657_204032524191_2.jpg",
                       @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1517824334&di=a6b1fb22560e3bf02b2a98aa3afd0b28&imgtype=jpg&er=1&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F08f790529822720ee889863371cb0a46f31fabb0.jpg"] mutableCopy];
    }
    return _imageAry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //[self addCJScrollViewDemo];
    
    [self addAtzucheScrollViewDemo];
}


-(void)changeBackViewCornerWithCornerType:(UIView *)iv
{
    
    UIBezierPath *maskPath;

    maskPath = [UIBezierPath bezierPathWithRoundedRect:iv.bounds

                                          cornerRadius:20];

    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];

    maskLayer.frame = iv.bounds;

    maskLayer.path = maskPath.CGPath;

    iv.layer.mask = maskLayer;
//    CAShapeLayer *maskLayer = [CAShapeLayer layer];
//       maskLayer.frame = CGRectMake(0, 0, cellWidth, cellHeight);
//
//       CAShapeLayer *borderLayer = [CAShapeLayer layer];
//       borderLayer.frame = CGRectMake(0, 0, cellWidth, cellHeight);
//       borderLayer.lineWidth = 1.f;
//       borderLayer.strokeColor = lineColor.CGColor;
//       borderLayer.fillColor = [UIColor clearColor].CGColor;
//
//       UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, cellWidth, cellHeight) cornerRadius:cornerRadius];
//       maskLayer.path = bezierPath.CGPath;
//       borderLayer.path = bezierPath.CGPath;
//
//       [cell.contentView.layer insertSublayer:borderLayer atIndex:0];
//       [cell.contentView.layer setMask:maskLayer];
}

- (void)addAtzucheScrollViewDemo {
    CGRect scrollviewF = CGRectMake(0, 64 + 20, SCREEN_WIDTH, 160);
    CGRect frame = CGRectMake(20, 0, SCREEN_WIDTH - 40, 160);
    
    self.atScrollView = [TXCycleScrollView atzucheCycleScrollViewFrame:scrollviewF imageViewFrame:frame radius:10.0 imagePaths:self.imageAry animationDuration:0.0];
    [self.view addSubview:self.atScrollView];
    
    self.atScrollView.TapActionBlock = ^(NSInteger pageIndex) {
        NSLog(@"index = %ld", pageIndex);
    };
    
}

//- (void)addCJScrollViewDemo {
//    CGRect scrollviewF = CGRectMake(0, 64 + 20, SCREEN_WIDTH, 220);
//    CGRect frame = CGRectMake(20, 64 + 20, SCREEN_WIDTH - 40, 220);
//    self.scrollView = [CJCycleScrollView cjCycleScrollViewFrame:scrollviewF imageViewFrame:frame radius:5.0 imagePaths:self.imageAry animationDuration:2.0];
//    [self.view addSubview:self.scrollView];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
