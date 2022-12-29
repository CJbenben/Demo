//
//  TXCollectionController.m
//  Demo
//
//  Created by ChenJie on 2018/1/25.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "TXCollectionController.h"
#import "TXCycleScrollView.h"
#import "HMCycleScrollView.h"

@interface TXCollectionController ()

//@property (strong, nonatomic) CJCycleScrollView *scrollView;
@property (nonatomic, strong) TXCycleScrollView *atScrollView;
@property (nonatomic, strong) HMCycleScrollView *hmScrollView;

@property (nonatomic, strong) NSMutableArray *imageAry;

@end

@implementation TXCollectionController

- (NSMutableArray *)imageAry {
    if (_imageAry == nil) {
        _imageAry = [@[@"https://t7.baidu.com/it/u=1956604245,3662848045&fm=193&f=GIF",
                       @"https://t7.baidu.com/it/u=2529476510,3041785782&fm=193&f=GIF",
                       @"https://t7.baidu.com/it/u=3569419905,626536365&fm=193&f=GIF"] mutableCopy];
    }
    return _imageAry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect scrollviewF = CGRectMake(0, naviHeight, SCREEN_WIDTH, 160);
    CGRect frame = CGRectMake(20, 0, SCREEN_WIDTH - 40, 160);
    
    self.atScrollView = [TXCycleScrollView atzucheCycleScrollViewFrame:scrollviewF imageViewFrame:frame radius:10.0 imagePaths:self.imageAry animationDuration:2.0];
    [self.view addSubview:self.atScrollView];
    
    self.atScrollView.TapActionBlock = ^(NSInteger pageIndex) {
        NSLog(@"index = %ld", pageIndex);
    };
    
    
    scrollviewF = CGRectMake(0, naviHeight+200, SCREEN_WIDTH, 160);
    self.hmScrollView = [HMCycleScrollView atzucheCycleScrollViewFrame:scrollviewF imageViewFrame:frame radius:10.0 imagePaths:self.imageAry animationDuration:2.0];
    [self.view addSubview:self.hmScrollView];
    
    
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
