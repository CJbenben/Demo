//
//  PhoneFontViewController.m
//  Demo
//
//  Created by ChenJie on 2018/4/24.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "PhoneFontViewController.h"
#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface PhoneFontViewController ()

@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *label3;
@property (nonatomic, strong) UILabel *label4;
@property (nonatomic, strong) UISlider *volumeViewSlider;
@end

@implementation PhoneFontViewController

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 90000

//字体样式
#define FONTSTYLE_PingFangSC_Light @"PingFangSC-Light"
#define FONTSTYLE_PingFangSC_Medium @"PingFangSC-Medium"
#define FONTSTYLE_PingFangSC_Regular @"PingFangSC-Regular"

#else

#define FONTSTYLE_PingFangSC_Light @"Helvetica-Light"
#define FONTSTYLE_PingFangSC_Medium @"Helvetica-Bold"
#define FONTSTYLE_PingFangSC_Regular @"Helvetica"

#endif

- (UILabel *)label1 {
    if (_label1 == nil) {
        _label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, self.view.width-40, 50)];
        _label1.text = @"凹凸租车autoyol0123456789";
        _label1.font = [UIFont fontWithName:FONTSTYLE_PingFangSC_Light size:17];
    }
    return _label1;
}

- (UILabel *)label2 {
    if (_label2 == nil) {
        _label2 = [[UILabel alloc] initWithFrame:CGRectMake(self.label1.x, self.label1.bottom + 20, self.label1.width, self.label1.height)];
        _label2.text = @"凹凸租车autoyol0123456789";
        _label2.font = [UIFont fontWithName:FONTSTYLE_PingFangSC_Medium size:17];
    }
    return _label2;
}

- (UILabel *)label3 {
    if (_label3 == nil) {
        _label3 = [[UILabel alloc] initWithFrame:CGRectMake(self.label2.x, self.label2.bottom + 20, self.label2.width, self.label2.height)];
        _label3.text = @"凹凸租车autoyol0123456789";
        _label3.font = [UIFont fontWithName:FONTSTYLE_PingFangSC_Regular size:17];
    }
    return _label3;
}

- (UILabel *)label4 {
    if (_label4 == nil) {
        _label4 = [[UILabel alloc] initWithFrame:CGRectMake(self.label3.x, self.label3.bottom + 20, SCREEN_WIDTH - 2 * self.label3.x, 60)];
        _label4.numberOfLines = 2;
        _label4.font = [UIFont fontWithName:FONTSTYLE_PingFangSC_Regular size:17];
    }
    return _label4;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"PhoneFontViewController";
    
    [self.view addSubview:self.label1];
    [self.view addSubview:self.label2];
    [self.view addSubview:self.label3];
    [self.view addSubview:self.label4];
    
    self.label4.text = @"阿斯顿发开发发觉对方安静得分叫我而烦恼的深V框架啊额案件砥砺奋进安慰阿克苏一二三";
    CGFloat height = [self.label4.text sizeWithFont:self.label4.font maxSize:CGSizeMake(self.label4.width, CGFLOAT_MAX)].height;
    NSLog(@"height = %.2f", height);
    
    UIFont *font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    NSLog(@"当前字体。。。 %@", font);
    
    NSString *lldb = @"lldb";
    NSLog(@"lldb = %@", lldb);
    
    
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"test" style:UIBarButtonItemStyleDone target:self action:@selector(backView)];
    
    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
    self.volumeViewSlider = nil;
    for (UIView *view in [volumeView subviews]){
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
            self.volumeViewSlider = (UISlider *)view;
            break;
        }
    }
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(volumeChange:) name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.volumeViewSlider.value   = 0;// 越小幅度越小0-1之间的数值
}

- (void)volumeChange:(NSNotification *)notification {
    NSString *volume = [notification.userInfo objectForKey:@"AVSystemController_AudioVolumeNotificationParameter"];
    NSLog(@"FlyElephant-系统音量:%@", volume);
    self.volumeViewSlider.value = [volume floatValue];
}

- (void)backView {
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[ViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
        }
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
