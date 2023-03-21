//
//  JDViewController.m
//  Demo
//
//  Created by chenxiaojie on 2023/3/8.
//  Copyright © 2023 ChenJie. All rights reserved.
//

#import "JDViewController.h"
#import "CJHTTPRequest.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface JDViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *spcArray;

@property (nonatomic, strong) UIImageView *spImageView;
@property (nonatomic, strong) UILabel *spNameL;
@property (nonatomic, strong) UILabel *spPriceL;
@end

@implementation JDViewController

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, naviHeight, SCREEN_WIDTH, SCREEN_HEIGHT - naviHeight) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (UIImageView *)spImageView {
    if (_spImageView == nil) {
        _spImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, naviHeight, 300, 200)];
        _spImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _spImageView;
}

- (UILabel *)spNameL {
    if (_spNameL == nil) {
        _spNameL = [[UILabel alloc] initWithFrame:CGRectMake(0, self.spImageView.bottom, SCREEN_WIDTH, 100)];
        _spNameL.textAlignment = NSTextAlignmentCenter;
        _spNameL.numberOfLines = 0;
    }
    return _spNameL;
}

- (UILabel *)spPriceL {
    if (_spPriceL == nil) {
        _spPriceL = [[UILabel alloc] initWithFrame:CGRectMake(0, self.spNameL.bottom, SCREEN_WIDTH, 50)];
        _spPriceL.textAlignment = NSTextAlignmentCenter;
    }
    return _spPriceL;
}

- (NSArray *)spcArray {
    if (_spcArray == nil) {
        _spcArray = [NSArray array];
    }
    return _spcArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (self.pageNum.length) {
        self.naviTitleL.text = [NSString stringWithFormat:@"商品池%@的商品", self.pageNum];
        [self.view addSubview:self.tableView];
        [self spcspRequest];
    } else if (self.skuId.length) {
        self.naviTitleL.text = [NSString stringWithFormat:@"sku = %@", self.skuId];
        [self.view addSubview:self.spImageView];
        [self.view addSubview:self.spNameL];
        [self.view addSubview:self.spPriceL];
        [self spcspxqRequest];
        [self spcspjgRequest];
    } else {
        self.naviTitleL.text = @"京东商品池";
        [self.view addSubview:self.tableView];
        [self spcRequest];
    }
}

/* 商品池接口 */
- (void)spcRequest {
    NSString *url = @"https://bizapi.jd.com/api/product/getPageNum";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    EncodeUnEmptyObjctToDic(params, @"UM98pEfQ720VLPTkc1z19DCMT", @"token");
    
    WS(weakSelf);
    [CJHTTPRequest httpRequestWithPOSTWithUrl:url params:params success:^(id result) {
        
        NSLog(@"responseObject = %@", result);
        weakSelf.spcArray = [result objectForKey:@"result"];
        [weakSelf.tableView reloadData];
        
    } failure:^(NSError *error) {
        
        NSLog(@"error = %@", error);
        
    }];
}

/* 商品池商品接口 */
- (void)spcspRequest {
    NSString *url = @"https://bizapi.jd.com/api/product/querySkuByPage";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    EncodeUnEmptyObjctToDic(params, @"UM98pEfQ720VLPTkc1z19DCMT", @"token");
    EncodeUnEmptyObjctToDic(params, self.pageNum, @"pageNum");
    EncodeUnEmptyObjctToDic(params, @"0", @"offset");
    
    WS(weakSelf);
    [CJHTTPRequest httpRequestWithPOSTWithUrl:url params:params success:^(id result) {
        
        NSLog(@"responseObject = %@", result);
        NSDictionary *resultDict = [result objectForKey:@"result"];
        weakSelf.spcArray = [resultDict objectForKey:@"skus"];
        [weakSelf.tableView reloadData];
        
    } failure:^(NSError *error) {
        
        NSLog(@"error = %@", error);
        
    }];
}

/* 商品详情接口 */
- (void)spcspxqRequest {
    NSString *url = @"https://bizapi.jd.com/api/product/getDetail";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    EncodeUnEmptyObjctToDic(params, @"UM98pEfQ720VLPTkc1z19DCMT", @"token");
    EncodeUnEmptyObjctToDic(params, self.skuId, @"sku");
    
    WS(weakSelf);
    [CJHTTPRequest httpRequestWithPOSTWithUrl:url params:params success:^(id result) {
        
        NSLog(@"responseObject = %@", result);
        NSDictionary *resultDict = [result objectForKey:@"result"];
        weakSelf.spNameL.text = EncodeStringFromDic(resultDict, @"name");
        NSString *imgUrl = [NSString stringWithFormat:@"https://img12.360buyimg.com/n1/%@", EncodeStringFromDic(resultDict, @"imagePath")];
        [weakSelf.spImageView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
        
    } failure:^(NSError *error) {
        
        NSLog(@"error = %@", error);
        
    }];
}

/* 商品价格接口 */
- (void)spcspjgRequest {
    NSString *url = @"https://bizapi.jd.com/api/price/getSellPrice";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    EncodeUnEmptyObjctToDic(params, @"UM98pEfQ720VLPTkc1z19DCMT", @"token");
    EncodeUnEmptyObjctToDic(params, self.skuId, @"sku");
    
    WS(weakSelf);
    [CJHTTPRequest httpRequestWithPOSTWithUrl:url params:params success:^(id result) {
        
        NSLog(@"responseObject = %@", result);
        NSDictionary *priceDict = safeObjectTxAtIndex([result objectForKey:@"result"], 0);
        weakSelf.spPriceL.text = [NSString stringWithFormat:@"价格：%@， 京东价：%@", EncodeStringFromDic(priceDict, @"price"), EncodeStringFromDic(priceDict, @"jdPrice")];
        
    } failure:^(NSError *error) {
        
        NSLog(@"error = %@", error);
        
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.spcArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (self.pageNum.length) {
        cell.textLabel.text = [NSString stringWithFormat:@"sku = %@", safeObjectTxAtIndex(self.spcArray, indexPath.row)];
    } else {
        NSDictionary *spcDict = safeObjectTxAtIndex(self.spcArray, indexPath.row);
        cell.textLabel.text = EncodeStringFromDic(spcDict, @"name");
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.skuId.length) {
        
    } else if (self.pageNum.length) {
        JDViewController *vc = [[JDViewController alloc] init];
        vc.skuId = [NSString stringWithFormat:@"%@", safeObjectTxAtIndex(self.spcArray, indexPath.row)];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        JDViewController *vc = [[JDViewController alloc] init];
        NSDictionary *spcDict = safeObjectTxAtIndex(self.spcArray, indexPath.row);
        vc.pageNum = EncodeStringFromDic(spcDict, @"page_num");
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
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
