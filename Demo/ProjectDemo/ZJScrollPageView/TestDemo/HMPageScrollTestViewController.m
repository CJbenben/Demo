//
//  HMPageScrollTestViewController.m
//  Demo
//
//  Created by chenxiaojie on 2020/12/17.
//  Copyright © 2020 ChenJie. All rights reserved.
//

#import "HMPageScrollTestViewController.h"
#import "ZJScrollPageView.h"

@interface HMPageScrollTestViewController ()

@property (nonatomic, strong) ZJScrollPageView *segmentView;
/** 横向标题 title 数组 */
@property (strong, nonatomic) NSMutableArray<NSString *> *titles;
/** 横向副标题 detail 数组 */
@property (strong, nonatomic) NSMutableArray<NSString *> *details;

@end

@implementation HMPageScrollTestViewController

- (ZJScrollSegmentView *)segmentView {
    if (_segmentView == nil) {
        ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
        style.showCover = YES;
        // 遮盖背景颜色
        style.coverBackgroundColor = [UIColor redColor];
        style.coverHeight = 20;
        style.coverCornerRadius = 10;
        // 渐变
        style.gradualChangeTitleColor = YES;
        //标题一般状态颜色 --- 注意一定要使用RGB空间的颜色值
//        style.normalTitleColor = CJRGBCOLOR(0, 0, 0);//CJRGBCOLOR(rValue, gValue, bValue);
        //标题选中状态颜色 --- 注意一定要使用RGB空间的颜色值
//        style.selectedTitleColor = CJRGBCOLOR(0, 0, 0);
        style.scrollTitle = YES;
        style.titleBigScale = 1.0;
        
        CGFloat height = 80;
//        __weak typeof(self) weakSelf = self;
        _segmentView = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0, naviHeight, SCREEN_WIDTH, height) bgViewFrame:CGRectMake(0, 0, SCREEN_WIDTH, height) segmentStyle:style delegate:nil titles:self.titles details:self.details titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
            
        }];
    }
    return _segmentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.titles = [NSMutableArray array];
    self.details = [NSMutableArray array];
    for (NSInteger i = 0; i<5; i++) {
        [self.titles addObject:[NSString stringWithFormat:@"商品推荐%ld", i]];
        [self.details addObject:[NSString stringWithFormat:@"显示%ld", i]];
    }
    [self.view addSubview:self.segmentView];
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
