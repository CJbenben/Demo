//
//  TableViewDeleteViewController.m
//  Demo
//
//  Created by ChenJie on 2018/5/29.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "TableViewDeleteViewController.h"

@interface TableViewDeleteViewController ()<UITableViewDataSource, UITableViewDelegate>

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

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (self.editingIndexPath) {
        [self configSwipeButtons];
    }
}

- (void)configSwipeButtons {
    if (@available(iOS 11.0, *)) {
        for (UIView *subview in self.tableView.subviews) {
            if ([subview isKindOfClass:NSClassFromString(@"UISwipeActionPullView")]) {
                UIButton *readButton = subview.subviews[0];

                [self configDeleteButton:readButton];
                
//                [readButton setTitle:@"确认删除" forState:UIControlStateNormal];
//                [readButton addTarget:self action:@selector(sureDelete:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
    } else {
        
        UITableViewCell *deleteCell = [self.tableView cellForRowAtIndexPath:self.editingIndexPath];
        for (UIView *subview in deleteCell.subviews) {
            if ([subview isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")]) {
                UIButton *actionBtn = subview.subviews[0];
                [self configDeleteButton:actionBtn];
            }
        }
        
//        for (UIView *subview in self.tableView.subviews) {
//            if ([subview isKindOfClass:NSClassFromString(@"UITableViewWrapperView")]) {
//                for (UIView *subsubview in subview.subviews) {
//                    if ([subsubview isKindOfClass:NSClassFromString(@"UITableViewCell")]) {
//                        for (UIView *subsubsubview in subsubview.subviews) {
//                            if ([subsubsubview isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")]) {
//                                UIButton *actionBtn = subsubsubview.subviews[0];
//                                [self configDeleteButton:actionBtn];
//                            }
//                        }
//                    }
//                }
//            }
//        }
    }
    
}

- (void)configDeleteButton:(UIButton *)sender {
    
    if (self.isSureDel) {
        CGRect frame = sender.frame;
        frame.size.width += 50;
        sender.frame = frame;
        
        CGRect superFrame = sender.superview.frame;
        superFrame.size.width += 50;
        superFrame.origin.x -= 50;
        
        [UIView animateWithDuration:0.3 animations:^{
            [sender setTitle:@"确认删除" forState:UIControlStateNormal];
            sender.superview.frame = superFrame;
        } completion:^(BOOL finished) {
            
        }];
        
        [sender addTarget:self action:@selector(sureDelete:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        CGRect frame = sender.frame;
        CGFloat padding = sender.frame.size.width - 50;
        
        frame.origin.x += padding;
        frame.origin.y = 10;
        frame.size.width -= padding;
        frame.size.height -= 10;
        sender.frame = frame;
        
        CGRect superFrame = sender.superview.frame;
        superFrame.size.width += padding;
        superFrame.origin.x -= padding;
        sender.superview.frame = superFrame;
        
        sender.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    sender.backgroundColor = RGBCOLOR(220, 63, 16);
}

#pragma mark - Action
- (void)sureDelete:(UIButton *)sender {
    if ([sender.currentTitle isEqualToString:@"确认删除"]) {
        [self.dataAry removeObjectAtIndex:self.editingIndexPath.row];
        [self.tableView reloadData];
        
        CGFloat height = self.tableView.contentSize.height;
        NSLog(@"height1 = %.2f", height);
        
        [self.tableView layoutIfNeeded];
        CGFloat height2 = self.tableView.contentSize.height;
        NSLog(@"height2 = %.2f", height2);
        
        CGRect frame = self.tableView.frame;
        frame.size.height = height2;
        self.tableView.frame = frame;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第 %@ 行 -- showingDeleteConfirmation = %d", [self.dataAry objectAtIndex:indexPath.row], cell.showingDeleteConfirmation];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < 3) {
        return NO;
    }return YES;
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.editingIndexPath = indexPath;
    //[self.view setNeedsLayout];   // 触发-(void)viewDidLayoutSubviews
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.editingIndexPath = nil;
}

/**
 *  iOS11 自定义左侧滑方法
 */
- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath  API_AVAILABLE(ios(11.0)){
    if (@available(iOS 11.0, *)) {
        UIContextualAction *action = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
            [self.view setNeedsLayout];
            //completionHandler(true);
        }];
        action.backgroundColor = RGBCOLOR(220, 63, 16);
        UISwipeActionsConfiguration *actionConfig = [UISwipeActionsConfiguration configurationWithActions:@[action]];
        actionConfig.performsFirstActionWithFullSwipe = NO;
        
        return actionConfig;
    } else {
        return nil;
    }
}

/**
 *  iOS8 -- iOS11 自定义左侧滑方法
 */
- (NSArray<UITableViewRowAction*>*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.isSureDel = NO;
    [self.view setNeedsLayout];
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        self.isSureDel = YES;
        [self.view setNeedsLayout];
    }];
    //deleteAction.backgroundColor = RGBCOLOR(220, 63, 16);
    deleteAction.backgroundColor = [UIColor clearColor];
    
    return @[deleteAction];
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
