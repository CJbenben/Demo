//
//  HorizontalCollectionViewController.m
//  Demo
//
//  Created by ChenJie on 2018/1/29.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "HorizontalCollectionViewController.h"
#import "AtzucheHomeCityCollectionView.h"
#import "AtzucheHomeCityFlowLayout.h"

#import "AtItemTableViewCell.h"

#define cityItemW       SCREEN_WIDTH * 100/375.0
#define itemW           SCREEN_WIDTH / 3.0


@interface HorizontalCollectionViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *imageAry;
@property (nonatomic, strong) NSMutableArray *itemAry;
@property (nonatomic, strong) AtzucheHomeCityCollectionView *homeCityCollectionView;
@property (nonatomic, strong) UITableView *tableview;

@end

@implementation HorizontalCollectionViewController

static NSString *identifier = @"AtItemTableViewCell";

- (NSMutableArray *)imageAry {
    if (_imageAry == nil) {
        _imageAry = [@[@"http://down.tutu001.com/d/file/20110312/ae15ebaebfa15428826432e50e_560.jpg",
                       @"http://down.tutu001.com/d/file/20120315/29e47a7c992f6f1d978bfc6d8d_560.jpg",
                       @"http://pic23.nipic.com/20120919/10785657_204032524191_2.jpg",
                       @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1517824334&di=a6b1fb22560e3bf02b2a98aa3afd0b28&imgtype=jpg&er=1&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F08f790529822720ee889863371cb0a46f31fabb0.jpg",
                       @"http://pic41.nipic.com/20140524/18658664_170018225386_2.jpg",
                       @"http://pic1.16pic.com/00/17/71/16pic_1771338_b.jpg"] mutableCopy];
    }
    return _imageAry;
}

- (NSMutableArray *)itemAry {
    if (_itemAry == nil) {
        _itemAry = [@[
                     @[@"1"],
                     @[@"1", @"2"],
                     @[@"1", @"2", @"3"],
                     @[@"1", @"2", @"3", @"4"],
                     @[@"1", @"2", @"3", @"4", @"5"],
                     
                     @[@"1", @"2", @"3", @"4", @"5", @"6"],
                     @[@"1", @"2", @"3", @"4", @"5"],
                     @[@"1", @"2", @"3", @"4"],
                     @[@"1", @"2", @"3"],
                     @[@"1", @"2"]
                     ] mutableCopy];
    }
    return _itemAry;
}

- (AtzucheHomeCityCollectionView *)homeCityCollectionView {
    if (_homeCityCollectionView == nil) {
        AtzucheHomeCityFlowLayout *layout = [[AtzucheHomeCityFlowLayout alloc] initAndSize:CGSizeMake(cityItemW, cityItemW + 35)];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _homeCityCollectionView = [[AtzucheHomeCityCollectionView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, cityItemW + 35) collectionViewLayout:layout];
    }
    return _homeCityCollectionView;
}

- (UITableView *)tableview {
    if (_tableview == nil) {
        CGFloat y = 64;//self.homeCityCollectionView.bottom + 20;
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, y, SCREEN_WIDTH, SCREEN_HEIGHT - y) style:UITableViewStylePlain];
        _tableview.dataSource = self;
        _tableview.delegate = self;
    }
    return _tableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.title = @"HorizontalCollectionViewController";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    self.homeCityCollectionView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.homeCityCollectionView];
    self.homeCityCollectionView.homeCityAry = self.imageAry;
    
    
    [self.view addSubview:self.tableview];
    
    
    
    
    
    
    
    
    
    /*
    NSMutableArray *itemFlag = [NSMutableArray array];
    for (NSInteger i = 0; i<6; i++) {
        [itemFlag addObject:[NSString stringWithFormat:@"第%d行", i]];
    }
    
    NSString *itemFlagStr = [itemFlag componentsJoinedByString:@" "];
    NSLog(@"itemFlagStr = %@", itemFlagStr);
    
    
    NSArray *ary = [itemFlagStr componentsSeparatedByString:@" "];
    NSLog(@"ary = %@", ary);
     */
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"AtItemTableViewCell";
    //AtItemTableViewCell *cell = [[AtItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    AtItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[AtItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.homeCityAry = [self.itemAry objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 160;
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
