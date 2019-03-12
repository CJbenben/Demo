//
//  FingerprintViewController.m
//  Demo
//
//  Created by chenxiaojie on 2019/3/7.
//  Copyright © 2019年 ChenJie. All rights reserved.
//

#import "FingerprintViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface FingerprintViewController ()

@end

@implementation FingerprintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(50, 100, SCREEN_WIDTH - 100, 60);
    loginBtn.backgroundColor = [UIColor cyanColor];
    [loginBtn setTintColor:[UIColor whiteColor]];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:loginBtn];
    
    [loginBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loginBtnAction {
    //首先判断版本
    if (NSFoundationVersionNumber < NSFoundationVersionNumber_iOS_8_0) {
        NSLog(@"系统版本不支持TouchID");
        [self.view makeToast:@"系统版本不支持TouchID"];
        return;
    }
    
    LAContext *context = [[LAContext alloc] init];
    context.localizedFallbackTitle = @"输入密码";
    if (@available(iOS 10.0, *)) {
        //        context.localizedCancelTitle = @"22222";
    } else {
        // Fallback on earlier versions
    }
    NSError *error = nil;
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"通过Home键验证已有手机指纹" reply:^(BOOL success, NSError * _Nullable error) {
            
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"TouchID 验证成功");
                    [self.view makeToast:@"TouchID 验证成功"];
                });
            }else if(error){
                
                switch (error.code) {
                    case LAErrorAuthenticationFailed:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"TouchID 验证失败");
                            [self.view makeToast:@"TouchID 验证失败"];
                        });
                        break;
                    }
                    case LAErrorUserCancel:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"TouchID 被用户手动取消");
                            [self.view makeToast:@"TouchID 被用户手动取消"];
                        });
                    }
                        break;
                    case LAErrorUserFallback:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"用户不使用TouchID,选择手动输入密码");
                            [self.view makeToast:@"用户不使用TouchID,选择手动输入密码"];
                        });
                    }
                        break;
                    case LAErrorSystemCancel:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"TouchID 被系统取消 (如遇到来电,锁屏,按了Home键等)");
                            [self.view makeToast:@"TouchID 被系统取消 (如遇到来电,锁屏,按了Home键等"];
                        });
                    }
                        break;
                    case LAErrorPasscodeNotSet:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"TouchID 无法启动,因为用户没有设置密码");
                            [self.view makeToast:@"TouchID 无法启动,因为用户没有设置密码"];
                        });
                    }
                        break;
                    case LAErrorTouchIDNotEnrolled:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"TouchID 无法启动,因为用户没有设置TouchID");
                            [self.view makeToast:@"TouchID 无法启动,因为用户没有设置TouchID"];
                        });
                    }
                        break;
                    case LAErrorTouchIDNotAvailable:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"TouchID 无效");
                            [self.view makeToast:@"TouchID 无效"];
                        });
                    }
                        break;
                    case LAErrorTouchIDLockout:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"TouchID 被锁定(连续多次验证TouchID失败,系统需要用户手动输入密码)");
                            [self.view makeToast:@"TouchID 被锁定(连续多次验证TouchID失败,系统需要用户手动输入密码)"];
                        });
                    }
                        break;
                    case LAErrorAppCancel:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"当前软件被挂起并取消了授权 (如App进入了后台等)");
                            [self.view makeToast:@"当前软件被挂起并取消了授权 (如App进入了后台等)"];
                        });
                    }
                        break;
                    case LAErrorInvalidContext:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"当前软件被挂起并取消了授权 (LAContext对象无效)");
                            [self.view makeToast:@"当前软件被挂起并取消了授权 (LAContext对象无效)"];
                        });
                    }
                        break;
                    default:
                        break;
                }
            }
        }];
        
    }else{
        NSLog(@"当前设备不支持TouchID，请在设置中检查本设备是否开启了 TouchID");
        [self.view makeToast:@"当前设备不支持TouchID，请在设置中检查本设备是否开启了TouchID"];
    }
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
