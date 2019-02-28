//
//  PersonViewController.m
//  Demo
//
//  Created by chenxiaojie on 2019/2/28.
//  Copyright © 2019年 ChenJie. All rights reserved.
//

#import "PersonViewController.h"

#define paddingY            320
#define headerViewH         200
#define headerViewPadding   headerViewH + paddingY
#define cardViewH           200


@interface PersonViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableview;
@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UIView *headerContentView;
@property (strong, nonatomic) UIView *cardView;
@property (assign, nonatomic) BOOL needAnimation;

@end

@implementation PersonViewController

- (UITableView *)tableview {
    if (_tableview == nil) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, -paddingY, SCREEN_WIDTH, SCREEN_HEIGHT + paddingY) style:UITableViewStylePlain];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.tableHeaderView = self.headerView;
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
        [_headerContentView addSubview:self.cardView];
    }
    return _headerContentView;
}

- (UIView *)cardView {
    if (_cardView == nil) {
        _cardView = [[UIView alloc] initWithFrame:CGRectMake(20, headerViewPadding - 30, SCREEN_WIDTH - 40, cardViewH)];
        _cardView.backgroundColor = [UIColor blackColor];
        _cardView.layer.cornerRadius = 10.0;
        _cardView.layer.masksToBounds = YES;
    }
    return _cardView;
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
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"########## ==== %.2f", scrollView.contentOffset.y);
    
    CGFloat contentOffSetY = -scrollView.contentOffset.y;//下拉的距离
    CGRect frame = _headerContentView.frame;
    if (contentOffSetY < 0) {
        frame.size.height = headerViewPadding;
        _headerContentView.frame = frame;
        _cardView.frame = CGRectMake(20, headerViewPadding - 30, SCREEN_WIDTH - 40, cardViewH);
    }else if (contentOffSetY < 100) {
        frame.size.height = headerViewPadding + contentOffSetY;
        _headerContentView.frame = frame;
        _cardView.frame = CGRectMake(20, headerViewPadding - 30 - contentOffSetY, SCREEN_WIDTH - 40, cardViewH);
    }else {
        frame.size.height = headerViewPadding + 100;
        _headerContentView.frame = frame;
        _cardView.frame = CGRectMake(20, headerViewPadding - 30 - 100, SCREEN_WIDTH - 40, cardViewH);
        
        _tableview.contentOffset = CGPointMake(0, -100);//最多往下拉动的距离，防止漏出白边
    }
    
    if (scrollView.contentOffset.y < -20 && self.needAnimation) {
        [self runAnimation];//抖动动画
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.contentOffset.y < -20) {
        self.needAnimation = YES;
    }
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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
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
