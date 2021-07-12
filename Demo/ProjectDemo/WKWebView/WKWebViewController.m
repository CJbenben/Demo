//
//  WKWebViewController.m
//  Demo
//
//  Created by ChenJie on 2018/5/7.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
#import "TXCommonUtils.h"

@interface WKWebViewController ()<WKNavigationDelegate, WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *detailWebView;

@end

@implementation WKWebViewController

- (WKWebView *)detailWebView {
    if (_detailWebView == nil) {
        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        [userContentController addScriptMessageHandler:self name:@"hmJsCallNative"];
        // 自适应屏幕宽度js
        NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta); var imgs = document.getElementsByTagName('img');for (var i in imgs){imgs[i].style.maxWidth='100%';imgs[i].style.height='auto';}";
        WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        // 添加自适应屏幕宽度js调用的方法
        [userContentController addUserScript:wkUserScript];
        wkWebConfig.userContentController = userContentController;
        
        _detailWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, naviHeight, SCREEN_WIDTH, SCREEN_HEIGHT - naviHeight) configuration:wkWebConfig];
        _detailWebView.navigationDelegate = self;
        _detailWebView.backgroundColor = [UIColor whiteColor];
    }
    return _detailWebView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backImage = [UIImage imageNamed:@"public_navi_left_back"];
    [self.view addSubview:self.detailWebView];
    
    NSString *str = @"<div class=\"media-wrap image-wrap\"><img style=\"width: 100%; display: block;\" class=\"media-wrap image-wrap\" src=\"http://lv-img.szgreenleaf.com/brandImg/%E9%95%BF%E5%9B%BE_01-36431569243383551.png?Expires=1884603388&OSSAccessKeyId=LTAIfEz63bW0rbAT&Signature=E9vmSGPxaVAyxVWq%2FMDxU9urvBc%3D\" width=\"100%\" style=\"width:100%\"/></div><div class=\"media-wrap image-wrap\"><img style=\"width: 100%; display: block;\" class=\"media-wrap image-wrap\" src=\"http://lv-img.szgreenleaf.com/brandImg/%E9%95%BF%E5%9B%BE_02-94371569243397219.png?Expires=1884603399&OSSAccessKeyId=LTAIfEz63bW0rbAT&Signature=g4ID%2FGd%2B5PrPEZDx7Bj6m01yk0Q%3D\" width=\"100%\" style=\"width:100%\"/></div><div class=\"media-wrap image-wrap\"><img style=\"width: 100%; display: block;\" class=\"media-wrap image-wrap\" src=\"http://lv-img.szgreenleaf.com/brandImg/%E9%95%BF%E5%9B%BE_03-52801569243404482.png?Expires=1884603411&OSSAccessKeyId=LTAIfEz63bW0rbAT&Signature=4K5xSsC9hUCeut6DOEaZE%2B%2FCf0U%3D\" width=\"100%\" style=\"width:100%\"/></div><div class=\"media-wrap image-wrap\"><img style=\"width: 100%; display: block;\" class=\"media-wrap image-wrap\" src=\"http://lv-img.szgreenleaf.com/brandImg/%E9%95%BF%E5%9B%BE_04-89651569243416263.png?Expires=1884603421&OSSAccessKeyId=LTAIfEz63bW0rbAT&Signature=JWyd%2F5qxGpDYinsxkc5zhotwa2Q%3D\" width=\"100%\" style=\"width:100%\"/></div><div class=\"media-wrap image-wrap\"><img style=\"width: 100%; display: block;\" class=\"media-wrap image-wrap\" src=\"https://lv-img.szgreenleaf.com/brandImg/%E5%BE%AE%E4%BF%A1%E5%9B%BE%E7%89%87_20210617140336-17401625031668361.jpg?Expires=1940391668&OSSAccessKeyId=LTAIfEz63bW0rbAT&Signature=fov3o2eLQVR06BNacdKTIlnMZ3g%3D\" width=\"100%\" style=\"width:100%\"/></div>";
    [self.detailWebView loadHTMLString:[TXCommonUtils htmlEntityDecode:str] baseURL:nil];
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    
    NSString *js = @"function addImgClickEvent() { \
    var imgs = document.getElementsByTagName('img'); \
    var json = []; \
    for (var i = 0; i < imgs.length; ++i) { \
    var img = imgs[i]; \
    json.push(img.src); \
    img.onclick = function () { \
    window.webkit.messageHandlers.hmJsCallNative.postMessage({images: JSON.stringify(json), img: this.src}); \
    }; \
    } \
    }";
    // 注入JS代码
    [webView evaluateJavaScript:js completionHandler:nil];
    [webView evaluateJavaScript:@"addImgClickEvent();"  completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"%@",result);
    }];
}

#pragma mark - WKScriptMessageHandler
// 拦截执行网页中的JS方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSDictionary *dict = message.body;
    NSLog(@"jsCallNative = %@", dict);
    
    if ([message.name isEqualToString:@"hmJsCallNative"]) {
        NSString *imagesStr = EncodeStringFromDic(dict, @"images");
        NSArray *images = [NSJSONSerialization JSONObjectWithData:[imagesStr dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        NSLog(@"images = %@", images);
    }
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
