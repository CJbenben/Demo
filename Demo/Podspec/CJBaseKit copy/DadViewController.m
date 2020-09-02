

//
//  DadViewController.m
//  Demo
//
//  Created by ChenJie on 2018/6/1.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "DadViewController.h"
#import "CJCommonKit.h"
#import "CJCategoryKit.h"

@interface DadViewController ()<UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIImageView *naviBackIV;
@property (strong, nonatomic) UIButton *naviBackBtn;
@property (strong, nonatomic) UIButton *naviRightBtn;
@property (strong, nonatomic) UIView *naviBottomLineV;

@end

@implementation DadViewController

#pragma mark - 懒加载
- (UIView *)naviView {
    if (_naviView == nil) {
        _naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, naviHeight)];
        _naviView.backgroundColor = [UIColor whiteColor];
    }
    return _naviView;
}

- (UIImageView *)naviBackIV {
    if (_naviBackIV == nil) {
        _naviBackIV = [[UIImageView alloc] initWithFrame:CGRectMake(6, 20 + self.iphonexNaviPadding + 2, 32, 32)];
        _naviBackIV.image = [UIImage imageNamed:@"public_navi_left_back"];
    }
    return _naviBackIV;
}

- (UIButton *)naviBackBtn {
    if (_naviBackBtn == nil) {
        _naviBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _naviBackBtn.frame = CGRectMake(0, 20, 80, naviHeight - 20);
        [_naviBackBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _naviBackBtn;
}

- (UILabel *)naviTitleL {
    if (_naviTitleL == nil) {
        _naviTitleL = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 260)/2, 20.0f + self.iphonexNaviPadding, 260, naviHeight - 20 - self.iphonexNaviPadding)];
        _naviTitleL.backgroundColor = [UIColor clearColor];
        _naviTitleL.textAlignment = NSTextAlignmentCenter;
    }
    return _naviTitleL;
}

- (UIButton *)naviRightBtn {
    if (_naviRightBtn == nil) {
        _naviRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _naviRightBtn.frame = CGRectMake(self.view.frame.size.width - 100, self.naviTitleL.frame.origin.y, 80, self.naviTitleL.frame.size.height);
        _naviRightBtn.titleLabel.font = [UIFont fontWithName:FONTSTYLE_PingFangSC_Medium size:14];
        [_naviRightBtn setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:UIControlStateNormal];
        _naviRightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_naviRightBtn addTarget:self action:@selector(naviRightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _naviRightBtn;
}

- (UIView *)naviBottomLineV {
    if (_naviBottomLineV == nil) {
        _naviBottomLineV = [[UIView alloc] initWithFrame:CGRectMake(0, self.naviView.bottom - 1, SCREEN_WIDTH, 1)];
        _naviBottomLineV.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    }
    return _naviBottomLineV;
}

- (void)setBackImage:(UIImage *)backImage {
    _backImage = backImage;
    self.naviBackIV.image = backImage;
    CGFloat backIVY = self.naviTitleL.y + (self.naviTitleL.height - backImage.size.height)/2.0;
    self.naviBackIV.frame = CGRectMake(16, backIVY, backImage.size.width, backImage.size.height);
}

- (void)setIsHiddenBottomLine:(BOOL)isHiddenBottomLine {
    self.naviBottomLineV.hidden = isHiddenBottomLine;
}

- (void)setRightBtnTitle:(NSString *)rightBtnTitle {
    _rightBtnTitle = rightBtnTitle;
    [self.naviRightBtn setTitle:rightBtnTitle forState:UIControlStateNormal];
    
    self.naviRightBtn.width = [rightBtnTitle sizeWithFont:self.naviRightBtn.titleLabel.font maxSize:CGSizeMake(200, self.naviTitleL.frame.size.height)].width;
    self.naviRightBtn.x = self.naviView.frame.size.width - 18 - self.naviRightBtn.width;
}

- (void)setRightBtnTitleColor:(UIColor *)rightBtnTitleColor {
    if (rightBtnTitleColor) {
        [self.naviRightBtn setTitleColor:rightBtnTitleColor forState:UIControlStateNormal];
        [self.naviRightBtn setTitleColor:rightBtnTitleColor forState:UIControlStateHighlighted];
    }
}

- (void)setRightBtnImage:(NSString *)rightBtnImage {
    _rightBtnImage = rightBtnImage;
    UIImage *image = [UIImage imageNamed:rightBtnImage];
    [self.naviRightBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    self.naviRightBtn.size = image.size;
    self.naviRightBtn.x = self.naviView.frame.size.width - 18 - self.naviRightBtn.width;
    self.naviRightBtn.y = self.naviTitleL.frame.origin.y + (self.naviTitleL.frame.size.height - self.naviRightBtn.height)/2.0;
}

#pragma mark - ViewDidLoad
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar setShadowImage:[self imageWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    if (self.navigationController.viewControllers.count > 1) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    } else {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    self.iphonexNaviPadding = isQiLiuHai ? 24 : 0;
    self.iphonexBottomPadding = isQiLiuHai ? 34 : 0;
    
    self.navigationController.navigationBar.translucent = NO;
    [self initDadSubViews];
}

- (void)initDadSubViews {
    [self.view addSubview:self.naviView];
    
    [self.naviView addSubview:self.naviBackIV];
    [self.naviView addSubview:self.naviBackBtn];
    [self.naviView addSubview:self.naviTitleL];
    [self.naviView addSubview:self.naviRightBtn];
    [self.naviView addSubview:self.naviBottomLineV];
    
}

- (void)hkCallPhoneWithTel:(NSString *)phoneNumber {
    NSMutableString *callPhone = [[NSMutableString alloc] initWithFormat:@"tel:%@", phoneNumber];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
    } else {
        UIWebView *callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:callPhone]]];
        [self.view addSubview:callWebview];
    }
}

#pragma mark - Action
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)naviRightBtnAction {
    // 子类重写就OK了
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
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
