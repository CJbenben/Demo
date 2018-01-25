//
//  SecondViewController.m
//  Demo
//
//  Created by ChenJie on 2017/12/12.
//  Copyright © 2017年 ChenJie. All rights reserved.
//

#import "SecondViewController.h"
#import "AFNetworking.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
