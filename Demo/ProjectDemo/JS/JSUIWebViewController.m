//
//  JSUIWebViewController.m
//  Demo
//
//  Created by chenxiaojie on 2019/3/21.
//  Copyright © 2019年 ChenJie. All rights reserved.
//

#import "JSUIWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface JSUIWebViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webview;

@end

@implementation JSUIWebViewController

- (UIWebView *)webview {
    if (_webview == nil) {
        _webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _webview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.webview];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    self.webview.delegate = self;
    [self.webview loadRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.title = [context evaluateScript:@"document.title"].toString;
    
    [self addActionsWithContext:context];
}

//! 使用context监听JS的方法
- (void)addActionsWithContext:(JSContext *)context {
    
    [context setExceptionHandler:^(JSContext *context, JSValue *exception) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"JS Exception: %@", exception.toString);
        });
    }];
    
    context[@"jsToOc"] = ^(NSString *action, NSString *params) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [JSUIWebViewController showAlertWithTitle:action message:params cancelHandler:nil];
        });
    };
}

#pragma mark - Util functions

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelHandler:(void(^)(void))handler {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (handler) {
            handler();
        }
    }];
    [alertController addAction:cancelAction];
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
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
