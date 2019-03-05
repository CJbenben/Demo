//
//  PersonViewController.m
//  Demo
//
//  Created by chenxiaojie on 2019/2/28.
//  Copyright © 2019年 ChenJie. All rights reserved.
//

#import "PersonViewController.h"
#import "UICountingLabel.h"

#define paddingY            320
#define headerViewH         200
#define headerViewPadding   headerViewH + paddingY
#define cardViewH           200
#define cardViewY           headerViewPadding - 40

static CGFloat downMaxPadding = 100;// 可向下展示最大距离


@interface PersonViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableview;
@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UIView *headerContentView;
@property (strong, nonatomic) UIView *cardView;
@property (strong, nonatomic) UIView *topView;

@property (assign, nonatomic) BOOL needAnimation;
/** scrollView是否拖动中 */
@property (nonatomic, assign) BOOL isDraggingScrollView;
@property (assign, nonatomic) BOOL downDrop;
/** 下拉到最底部 */
@property (assign, nonatomic) BOOL downBottomDrop;


@property (strong, nonatomic) UICountingLabel *countingLabel;

@end

@implementation PersonViewController

- (UITableView *)tableview {
    if (_tableview == nil) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, -paddingY, SCREEN_WIDTH, SCREEN_HEIGHT + paddingY) style:UITableViewStylePlain];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.tableHeaderView = self.headerView;
        if (@available(iOS 11.0, *)) {
            _tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
    }
    return _tableview;
}

- (UIView *)headerView {
    if (_headerView == nil) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headerViewPadding)];
        _headerView.backgroundColor = [UIColor redColor];
        [_headerView addSubview:self.headerContentView];
        _headerView.clipsToBounds = YES;
    }
    return _headerView;
}

- (UIView *)headerContentView {
    if (_headerContentView == nil) {
        _headerContentView = [[UIView alloc] initWithFrame:_headerView.bounds];
        _headerContentView.backgroundColor = [UIColor redColor];
        [_headerContentView addSubview:self.topView];
        [_headerContentView addSubview:self.cardView];
    }
    return _headerContentView;
}

- (UIView *)topView {
    if (_topView == nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(50, paddingY, SCREEN_WIDTH - 100, 100)];
        _topView.backgroundColor = [UIColor yellowColor];
    }
    return _topView;
}

- (UIView *)cardView {
    if (_cardView == nil) {
        _cardView = [[UIView alloc] initWithFrame:CGRectMake(20, cardViewY, SCREEN_WIDTH - 40, cardViewH)];
        _cardView.backgroundColor = [UIColor blackColor];
        _cardView.layer.cornerRadius = 10.0;
        _cardView.layer.masksToBounds = YES;
        [_cardView addSubview:self.countingLabel];
    }
    return _cardView;
}

- (UICountingLabel *)countingLabel {
    if (_countingLabel == nil) {
        _countingLabel = [[UICountingLabel alloc] initWithFrame:CGRectMake(0, 40, self.cardView.width, 50)];
        _countingLabel.textAlignment = NSTextAlignmentCenter;
        _countingLabel.format = @"%.2f";
        _countingLabel.backgroundColor = [UIColor cyanColor];
    }
    return _countingLabel;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    //self.navigationController.navigationBar.translucent = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.view addSubview:self.tableview];
    self.downDrop = YES;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self handleScrollView:scrollView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.isDraggingScrollView = YES;
    [self.countingLabel countFromZeroTo:647.23 withDuration:0.4];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.contentOffset.y < -20) {
        self.needAnimation = YES;
    }
    self.isDraggingScrollView = NO;
    [self handleScrollView:scrollView];
}


- (void)handleScrollView:(UIScrollView *)scrollView {
    NSLog(@"########## ==== %.2f", -scrollView.contentOffset.y);
    // 偏移量
    CGFloat contentOffSetY = -scrollView.contentOffset.y;
    
    if (contentOffSetY == 0 && self.downBottomDrop) {
        self.downDrop = NO;
        return;
    }
    CGRect headerContentFrame = self.headerContentView.frame;
    CGRect topViewFrame = self.topView.frame;
    CGRect cardFrame = self.cardView.frame;
    // 向上滚动
    if (contentOffSetY <= 0) {
        // 下拉到最底部之后向上滚动
        if (!self.downDrop) {
            // 改变 cardview 的 frame 相当于向上滚动了
            cardFrame.origin.y = cardViewY - contentOffSetY;
            self.cardView.frame = cardFrame;
            topViewFrame.origin.y = paddingY - contentOffSetY;
            self.topView.frame = topViewFrame;
            // 手指没有离开屏幕
            if (self.isDraggingScrollView) {
                if (contentOffSetY < -downMaxPadding) {
                    self.downDrop = YES;// 设置正常向上滚动（全部向上移动）
                    self.downBottomDrop = NO;
                    [self settingHeaderViewBeginState];// 设置 headerview 回到初始状态
                    [scrollView setContentOffset:CGPointZero];
                }
            }
            // 手指离开屏幕
            else {
                // 滚动超过卡片的一半时
                if (contentOffSetY < -40) {
                    self.downDrop = YES;// 设置正常向上滚动（全部向上移动）
                    self.downBottomDrop = NO;
                    [self settingHeaderViewBeginState];// 设置 headerview 回到初始状态
                    [scrollView setContentOffset:CGPointZero];
                }
                // 向上滚动没有超过卡片一半时，需要回到（滚动到最底部状态）
                else {
                    self.downDrop = NO;// 设置卡片可以继续向上滚动
                    [self settingHeaderViewBottomState];
                    [scrollView setContentOffset:CGPointZero];
                }
            }
        }
        // 正常向上滚动（全部向上移动）
        else {
            
        }
        
    }
    // 向下滚动
    else {
        // 向下移动不超过最大距离时
        if (contentOffSetY < downMaxPadding) {
            // 手指离开屏幕时，超过卡片一半时，自动滚动到最底部
            if (contentOffSetY > 40 && !self.isDraggingScrollView && self.downDrop) {
                self.downDrop = NO;// 设置卡片可以继续向上滚动
                [self settingHeaderViewBottomState];
                self.downBottomDrop = YES;
            } else if (!self.downDrop) {
                headerContentFrame.size.height = headerViewPadding;
                self.headerContentView.frame = headerContentFrame;
                self.topView.frame = CGRectMake(self.topView.x, paddingY, self.topView.width, self.topView.height);
                self.cardView.frame = CGRectMake(self.cardView.x, cardViewY, self.cardView.width, cardViewH);
                [scrollView setContentOffset:CGPointZero];//最多往下拉动的距离，防止漏出白边
            } else {
                headerContentFrame.size.height = headerViewPadding + contentOffSetY;
                self.headerContentView.frame = headerContentFrame;
                self.topView.frame = CGRectMake(self.topView.x, paddingY - contentOffSetY, self.topView.width, self.topView.height);
                self.cardView.frame = CGRectMake(self.cardView.x, cardViewY - contentOffSetY, self.cardView.width, cardViewH);
            }
        }
        // 向下移动超过最大距离时，不允许滚动了
        else {
            headerContentFrame.size.height = headerViewPadding + downMaxPadding;
            self.headerContentView.frame = headerContentFrame;
            self.topView.frame = CGRectMake(self.topView.x, paddingY - downMaxPadding, self.topView.width, self.topView.height);
            self.cardView.frame = CGRectMake(self.cardView.x, cardViewY - downMaxPadding, self.cardView.width, cardViewH);
            [scrollView setContentOffset:CGPointMake(0, -downMaxPadding)];//最多往下拉动的距离，防止漏出白边
        }
    }
    
    //    if (scrollView.contentOffset.y < -20 && self.needAnimation) {
    //        [self runAnimation];//抖动动画
    //    }
}

- (void)settingHeaderViewBeginState {
    self.topView.frame = CGRectMake(self.topView.x, paddingY, self.topView.width, self.topView.height);
    self.cardView.frame = CGRectMake(self.cardView.x, cardViewY, self.cardView.width, cardViewH);
    self.headerView.height = headerViewPadding;
    self.tableview.tableHeaderView = self.headerView;
}

- (void)settingHeaderViewBottomState {
    self.topView.frame = CGRectMake(self.topView.x, paddingY, self.topView.width, self.topView.height);
    self.cardView.frame = CGRectMake(self.cardView.x, cardViewY, self.cardView.width, cardViewH);
    self.headerView.height = headerViewPadding + downMaxPadding;
    self.tableview.tableHeaderView = self.headerView;
}


- (void)runAnimation {
    self.needAnimation = NO;
    
    [UIView animateWithDuration:0.4 animations:^{
        [self.tableview setContentOffset:CGPointMake(0, -20)];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:8 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.tableview setContentOffset:CGPointMake(0, -15)];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                [self.tableview setContentOffset:CGPointMake(0, -20)];
            }];
        }];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第 %ld 行", indexPath.row + 1];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
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
