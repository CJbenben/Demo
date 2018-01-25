//
//  SecondViewController.m
//  Demo
//
//  Created by ChenJie on 2017/12/12.
//  Copyright © 2017年 ChenJie. All rights reserved.
//

#import "SecondViewController.h"
#import "AFNetworking.h"
#import "DemoTableViewCell.h"

@interface SecondViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray *dataAry;
@end

@implementation SecondViewController

- (NSArray *)dataAry {
    if (_dataAry == nil) {
        _dataAry = @[@"网络请求", @"CollectionView"];
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
    
    [self.view addSubview:self.tableview];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

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
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)httpRequestWithGET {
    NSString *url = @"https://kyfw.12306.cn/otn/leftTicket/init";
    NSDictionary *params = @{@"leftTicketDTO.train_date":@"2018-02-06",
                             @"leftTicketDTO.from_station":@"SHH",
                             @"leftTicketDTO.to_station":@"UAH"
                             };
    AFHTTPSessionManager *manager = [self getManager];
    
    //NSLog(@"<-- newRequest -- %@ url --> %@  params --> %@", requestName, url, mutaDict.mj_JSONString);
    
    /** 没有做缓存处理，需要添加缓存处理 */
    [manager GET:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"responseObject = %@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = %@", error);
    }];
}

- (AFHTTPSessionManager *)getManager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json", nil];
    
    AFSecurityPolicy * securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    manager.securityPolicy = securityPolicy;
    
    [manager setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession * _Nonnull session, NSURLAuthenticationChallenge * _Nonnull challenge, NSURLCredential *__autoreleasing  _Nullable * _Nullable credential)
     {
         return NSURLSessionAuthChallengePerformDefaultHandling;
     }];
    
    return manager;
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
