//
//  PhoneFontViewController.m
//  Demo
//
//  Created by ChenJie on 2018/4/24.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "PhoneFontViewController.h"

@interface PhoneFontViewController ()

@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *label3;

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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.label1];
    [self.view addSubview:self.label2];
    [self.view addSubview:self.label3];
    
    
    UIFont *font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    NSLog(@"当前字体。。。 %@", font);
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
