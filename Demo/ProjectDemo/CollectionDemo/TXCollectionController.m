//
//  TXCollectionController.m
//  Demo
//
//  Created by ChenJie on 2018/1/25.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "TXCollectionController.h"
#import "HMCycleScrollView.h"

@interface TXCollectionController ()

@property (nonatomic, strong) HMCycleScrollView *atScrollView;
@property (nonatomic, strong) HMCycleScrollView *hmScrollView;

@property (nonatomic, strong) NSMutableArray *imageAry;

@end

@implementation TXCollectionController

- (NSMutableArray *)imageAry {
    if (_imageAry == nil) {
        _imageAry = [@[@"https://www.zaoxu.com/uploadfile/imgall/020b46f21fbe096b632bf2308902338744eaf8ac04.jpg",
                       @"https://img95.699pic.com/element/40116/4903.png_860.png",
                       @"https://img1.baidu.com/it/u=1154565158,60995416&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=600"] mutableCopy];
    }
    return _imageAry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect frame = CGRectMake(0, naviHeight, SCREEN_WIDTH, 160);
    CGRect imageViewF = CGRectMake(20, 0, SCREEN_WIDTH - 40, 160);
    
    frame = CGRectMake(0, naviHeight+200, SCREEN_WIDTH, 160);
    self.hmScrollView = [HMCycleScrollView cycleScrollViewFrame:frame imageViewFrame:imageViewF radius:10.0 repeats:YES autoScrollDuration:2.0];
    self.hmScrollView.imageArray = self.imageAry;
//    self.hmScrollView.pageControlType = PageControlTypeCustom;
    self.hmScrollView.pageControlPosition = PageControlPositionBottom;
    [self.view addSubview:self.hmScrollView];
    
    
    self.hmScrollView.tapActionBlock = ^(NSInteger pageIndex) {
        NSLog(@"当前点击的index = %ld", pageIndex);
    };
    
    
}

- (void)dealloc {
    [self.hmScrollView.timer invalidate];
    NSLog(@"%s", __func__);
}

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
