//
//  SecondViewController.m
//  Demo
//
//  Created by ChenJie on 2017/12/12.
//  Copyright © 2017年 ChenJie. All rights reserved.
//

#import "SecondViewController.h"

#import "DemoTableViewCell.h"

#import "ATCollectionViewDemoVC.h"
#import "HorizontalCollectionViewController.h"
#import "AtzucheHomeTitleViewController.h"
#import "CellAddCollectionViewController.h"
#import "MJIphoneXViewController.h"
#import "PhoneFontViewController.h"
#import "WKWebViewController.h"
#import "TableViewDeleteViewController.h"

@interface SecondViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray *dataAry;
@end

@implementation SecondViewController

#pragma mark - 懒加载
- (NSArray *)dataAry {
    if (_dataAry == nil) {
        _dataAry = @[@"网络请求",
                     @"CollectionView",
                     @"横向 CollectionView",
                     @"自动居中 CollectionView",
                     @"cell add collectionview",
                     @"MJ 下拉刷新兼容 iPhone X",
                     @"iPhone 字体",
                     @"wkwebview",
                     @"自定义左侧滑二次确认删除"];
    }
    return _dataAry;
}

- (UITableView *)tableview {
    if (_tableview == nil) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableview.dataSource = self;
        _tableview.delegate = self;
    }
    return _tableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"笨笨编程";
    
    [self.view addSubview:self.tableview];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"DemoTableViewCell";
    DemoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[DemoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [_dataAry objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self httpRequestWithGET];
    } else if (indexPath.row == 1) {
        ATCollectionViewDemoVC *collectionVC = [[ATCollectionViewDemoVC alloc] init];
        [self.navigationController pushViewController:collectionVC animated:YES];
    } else if (indexPath.row == 2) {
        HorizontalCollectionViewController *horizontalVC = [[HorizontalCollectionViewController alloc] init];
        [self.navigationController pushViewController:horizontalVC animated:YES];
    } else if (indexPath.row == 3) {
        AtzucheHomeTitleViewController *titleVC = [[AtzucheHomeTitleViewController alloc] init];
        [self.navigationController pushViewController:titleVC animated:YES];
    } else if (indexPath.row == 4) {
        CellAddCollectionViewController *cellVC = [[CellAddCollectionViewController alloc] init];
        [self.navigationController pushViewController:cellVC animated:YES];
    } else if (indexPath.row == 5) {
        MJIphoneXViewController *mjIphoneXvc = [[MJIphoneXViewController alloc] init];
        [self.navigationController pushViewController:mjIphoneXvc animated:YES];
    } else if (indexPath.row == 6) {
        PhoneFontViewController *fontVC = [[PhoneFontViewController alloc] init];
        [self.navigationController pushViewController:fontVC animated:YES];
    } else if (indexPath.row == 7) {
        WKWebViewController *webview = [[WKWebViewController alloc] init];
        [self.navigationController pushViewController:webview animated:YES];
    } else if (indexPath.row == 8) {
        TableViewDeleteViewController *deleteVC = [[TableViewDeleteViewController alloc] init];
        [self.navigationController pushViewController:deleteVC animated:YES];
    } else if (indexPath.row == 9) {
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

#pragma mark - indexpath.row == 0
- (void)httpRequestWithGET {
    NSString *url = @"http://v.juhe.cn/toutiao/index";
    NSDictionary *params = @{@"type":@"top",//类型,,top(头条，默认),shehui(社会),guonei(国内),guoji(国际),yule(娱乐),tiyu(体育)junshi(军事),keji(科技),caijing(财经),shishang(时尚)
                             @"key":@"ad2908cae6020addf38ffdb5e2255c06"//应用APPKEY
                             };
    
    [CJHTTPRequest httpRequestWithGETWithUrl:url params:params success:^(id result) {
        
        NSLog(@"responseObject = %@", result);

    } failure:^(NSError *error) {
        
        NSLog(@"error = %@", error);

    }];
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
