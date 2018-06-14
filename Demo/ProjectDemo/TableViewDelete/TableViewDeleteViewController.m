//
//  TableViewDeleteViewController.m
//  Demo
//
//  Created by ChenJie on 2018/5/29.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "TableViewDeleteViewController.h"
#import "TableViewDeleteCell.h"

@interface TableViewDeleteViewController ()<UITableViewDataSource, UITableViewDelegate, ZJSwipeTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) NSIndexPath *editingIndexPath;  //当前左滑cell的index，在代理方法中设置
@property (nonatomic, strong) NSMutableArray *dataAry;

@property (nonatomic, assign) BOOL isSureDel;

@end

@implementation TableViewDeleteViewController

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.allowsMultipleSelection = NO;
        _tableView.allowsSelectionDuringEditing = NO;
        _tableView.allowsMultipleSelectionDuringEditing = NO;
    }
    return _tableView;
}

- (NSMutableArray *)dataAry {
    if (_dataAry == nil) {
        _dataAry = [@[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8"] mutableCopy];
    }
    return _dataAry;
}

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"TableViewDeleteViewController";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"TableViewDeleteCell";
    TableViewDeleteCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[TableViewDeleteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.delegate = self;
    cell.swipeViewAnimatedStyle = ZJSwipeViewAnimatedStyleNone;
    //cell.textLabel.text = [NSString stringWithFormat:@"第 %@ 行 -- showingDeleteConfirmation = %d", [self.dataAry objectAtIndex:indexPath.row], cell.showingDeleteConfirmation];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (NSArray<ZJSwipeButton *> *)tableView:(UITableView *)tableView leftSwipeButtonsAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (NSArray<ZJSwipeButton *> *)tableView:(UITableView *)tableView rightSwipeButtonsAtIndexPath:(NSIndexPath *)indexPath {
    
    ZJSwipeButton *leftBtn = [[ZJSwipeButton alloc] initWithTitle:@"删除" image:nil onClickHandler:^(UIButton *swipeButton) {
        NSLog(@"点击了检查1: --- %ld", indexPath.row);
        //[ZJProgressHUD showStatus:[NSString stringWithFormat:@"点击了检查1: --- %ld", indexPath.row] andAutoHideAfterTime:1];
        [self.tableView reloadData];
    }];
    return @[leftBtn];
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
