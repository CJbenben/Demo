//
//  RACViewController.m
//  Demo
//
//  Created by ChenJie on 2018/9/21.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "RACViewController.h"

@interface RACViewController ()

@end

@implementation RACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}



- (void)RACCommand_Demo1 {
    
    //    RACCommand 命令。
    
    //创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSLog(@"input = %@",input);
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            //发送数据
            [subscriber sendNext:@"执行完命令后产生的数据"];
            return nil;
        }];
        
    }];
    
    //执行命令
    RACSignal *signal =  [command execute:@"输入命令！"] ;
    [signal subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"x = %@",x);
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
