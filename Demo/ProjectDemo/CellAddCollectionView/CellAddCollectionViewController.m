
//
//  CellAddCollectionViewController.m
//  Demo
//
//  Created by ChenJie on 2018/6/1.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "CellAddCollectionViewController.h"
#import "testTableViewCell.h"

@interface CellAddCollectionViewController ()<UITableViewDataSource,UITableViewDelegate,testTableViewCellDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)testTableViewCell *toolCell;
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)NSMutableDictionary *dicH;


@property(nonatomic,strong)UILabel *numLabel;
@property(nonatomic,strong)CADisplayLink *displayLink;
@property(nonatomic,assign)NSTimeInterval lastTime;
@property(nonatomic,assign)NSInteger   count;
@end
@implementation CellAddCollectionViewController

-(NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = @[
                     @[@"g"],
                     @[@"g",@"b"],
                     @[@"g",@"b",@"a"],
                     @[@"g",@"b",@"c",@"e"],
                     @[@"g",@"b",@"c",@"e",@"a"],
                     @[@"g",@"b",@"c",@"e",@"b",@"c"],
                     @[@"g",@"b",@"c",@"e",@"b",@"c",@"a"],
                     @[@"g",@"b",@"c",@"e",@"b",@"c",@"b",@"c"],
                     @[@"g",@"b",@"c",@"e",@"b",@"c",@"e",@"d",@"g"],
                     @[@"g",@"b",@"c",@"e",@"b",@"c",@"e",@"d",@"a",@"c"],
                     @[@"g",@"b",@"c",@"e",@"b",@"c",@"e",@"d",@"a",@"c",@"e"],
                     @[@"g",@"b",@"c",@"e",@"b",@"c",@"e",@"d",@"a",@"c",@"a",@"b"],
                     @[@"g",@"b",@"c",@"e",@"b",@"c",@"e",@"d",@"a",@"c",@"a",@"b",@"a"],
                     @[@"g",@"b",@"c",@"e",@"b",@"c",@"e",@"d",@"a",@"c",@"a",@"b",@"a",@"14"],
                     @[@"g",@"b",@"c",@"e",@"b",@"c",@"e",@"d",@"a",@"c",@"a",@"b",@"a",@"14",@"15"],
                     @[@"g",@"b",@"c",@"e",@"b",@"c",@"e",@"d",@"a",@"c",@"a",@"b",@"a",@"14",@"15",@"16"],
                     @[@"g",@"b",@"c",@"e",@"b",@"c",@"e",@"d",@"a",@"c",@"a",@"b",@"a",@"14",@"15",@"16",@"17"],
                     @[@"g",@"b",@"c",@"e",@"b",@"c",@"e",@"d",@"a",@"c",@"a",@"b",@"a",@"14",@"15",@"16",@"17",@"18"],
                     @[@"g",@"b",@"c",@"e",@"b",@"c",@"e",@"d",@"a",@"c",@"a",@"b",@"a",@"14",@"15",@"16",@"17",@"18",@"19"],
                     @[@"g",@"b",@"c",@"e",@"b",@"c",@"e",@"d",@"a",@"c",@"a",@"b",@"a",@"14",@"15",@"16",@"17",@"18",@"19",@"20"],
                     @[@"g",@"b",@"c",@"e",@"b",@"c",@"e",@"d",@"a",@"c",@"a",@"b",@"a",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21"],
                     @[@"g",@"b",@"c",@"e",@"b",@"c",@"e",@"d",@"a",@"c",@"a",@"b",@"a",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22"],
                     @[@"g",@"b",@"c",@"e",@"b",@"c",@"e",@"d",@"a",@"c",@"a",@"b",@"a",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23"],
                     @[@"g",@"b",@"c",@"e",@"b",@"c",@"e",@"d",@"a",@"c",@"a",@"b",@"a",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24"]
                     
                     ];
        
    }
    return _dataArr;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[testTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    testTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.lable.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    cell.deleget = self;
    cell.indexPath = indexPath;
    cell.dataArr = self.dataArr[indexPath.row];
    return cell;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dicH[indexPath]) {
        NSNumber *num = self.dicH[indexPath];
        return [num floatValue];
    }else{
        return 80;
    }
}

-(void)uodataTableViewCellHight:(testTableViewCell *)cell andHight:(CGFloat)hight andIndexPath:(NSIndexPath *)indexPath{
    
    if (![self.dicH[indexPath] isEqualToNumber: @(hight)]) {
        self.dicH[indexPath] = @(hight);
        NSLog(@"indexPath.row = %ld",indexPath.row);
        NSLog(@"高度 = %lf",[@(hight) floatValue]);
        [self.tableView reloadData];
    }
}

#pragma mark 下面是检测流畅度
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CellAddCollectionViewController";
    
    [self.view addSubview:self.tableView];
    [self setupUI];
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayAction:)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
}

-(void)dealloc
{
    [_displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    _displayLink = nil;
}

-(void)setupUI
{
    _numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    _numLabel.text = @"60";
    _numLabel.textColor = [UIColor greenColor];
    _numLabel.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_numLabel];
}

-(void)displayAction:(id)sender
{
    if (_lastTime == 0) {
        _lastTime = _displayLink.timestamp;
        return;
    }
    
    _count++;
    NSTimeInterval delta = _displayLink.timestamp - _lastTime;
    if (delta < 1) return;
    _lastTime = _displayLink.timestamp;
    float fps = _count / delta;
    _count = 0;
    
    NSString *text = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%d FPS", (int)round(fps)]];
    _numLabel.text = text;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 保存cell高度
- (NSMutableDictionary *)dicH {
    if(_dicH == nil) {
        _dicH = [[NSMutableDictionary alloc] init];
    }
    return _dicH;
}
@end

