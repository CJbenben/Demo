//
//  ATCollectionViewDemoVC.m
//  Demo
//
//  Created by ChenJie on 2018/1/25.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "ATCollectionViewDemoVC.h"
//#import "CJCycleScrollView.h"
#import "AtzucheCycleScrollView.h"

@interface ATCollectionViewDemoVC ()

//@property (strong, nonatomic) CJCycleScrollView *scrollView;
@property (nonatomic, strong) AtzucheCycleScrollView *atScrollView;

@property (nonatomic, strong) NSMutableArray *imageAry;

@end

@implementation ATCollectionViewDemoVC

- (NSMutableArray *)imageAry {
    if (_imageAry == nil) {
        _imageAry = [@[@"http://down.tutu001.com/d/file/20110312/ae15ebaebfa15428826432e50e_560.jpg",
                       @"http://down.tutu001.com/d/file/20120315/29e47a7c992f6f1d978bfc6d8d_560.jpg",
                       @"http://pic23.nipic.com/20120919/10785657_204032524191_2.jpg",
                       @"http://pic39.nipic.com/20140310/18084329_102707924000_2.jpg"] mutableCopy];
    }
    return _imageAry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"ATCollectionViewDemoVC";
    
    //[self addCJScrollViewDemo];
    
    [self addAtzucheScrollViewDemo];
}

- (void)addAtzucheScrollViewDemo {
    CGRect scrollviewF = CGRectMake(0, 64 + 20, SCREEN_WIDTH, 220);
    CGRect frame = CGRectMake(20, 0, SCREEN_WIDTH - 40, 220);
    
    self.atScrollView = [AtzucheCycleScrollView atzucheCycleScrollViewFrame:scrollviewF imageViewFrame:frame radius:10.0 imagePaths:self.imageAry animationDuration:2.0];
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
