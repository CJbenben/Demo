//
//  AtzucheHomeTitleViewController.m
//  Demo
//
//  Created by ChenJie on 2018/1/30.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "AtzucheHomeTitleViewController.h"
#import "AtzucheHomeTitleCollectionView.h"
#import "AtzucheHomeTitleFlowLayout.h"

@interface AtzucheHomeTitleViewController ()

@property (nonatomic, strong) AtzucheHomeTitleCollectionView *homeTitleCollectionView;

@property (nonatomic, strong) UIStepper *stepper;

@end

@implementation AtzucheHomeTitleViewController

//- (AtzucheHomeTitleCollectionView *)homeTitleCollectionView {
//    if (_homeTitleCollectionView == nil) {
//
//        //_homeTitleCollectionView = [[AtzucheHomeTitleCollectionView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 45 + 20) collectionViewLayout:layout];
//    }
//    return _homeTitleCollectionView;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"AtzucheHomeTitleViewController";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    AtzucheHomeTitleFlowLayout *layout = [[AtzucheHomeTitleFlowLayout alloc] initAndSize:CGSizeMake(45, 45 + 20) count:1];
    self.homeTitleCollectionView = [[AtzucheHomeTitleCollectionView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 45 + 20) collectionViewLayout:layout];
    [self.view addSubview:self.homeTitleCollectionView];
    self.homeTitleCollectionView.homeTitleAry = @[@"快捷租车"];
    
    
    self.stepper = [[UIStepper alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100)/2.0, 220, 100, 35)];
    self.stepper.value = 1;
    [self.stepper addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.stepper];
}

- (void)changeValue:(UIStepper *)stepper {
    
    [self.homeTitleCollectionView removeFromSuperview];
    
    AtzucheHomeTitleFlowLayout *layout = [[AtzucheHomeTitleFlowLayout alloc] initAndSize:CGSizeMake(45, 45 + 20) count:self.stepper.value];
    self.homeTitleCollectionView = [[AtzucheHomeTitleCollectionView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 45 + 20) collectionViewLayout:layout];
    [self.view addSubview:self.homeTitleCollectionView];
    
    if (stepper.value == 0) {
        self.stepper.value = 1;
        self.homeTitleCollectionView.homeTitleAry = @[@"快捷租车"];
    } else if (stepper.value == 1) {
        self.homeTitleCollectionView.homeTitleAry = @[@"快捷租车"];
    }else if (stepper.value == 2) {
        self.homeTitleCollectionView.homeTitleAry = @[@"快捷租车", @"自助找车"];
    } else if (stepper.value == 3) {
        self.homeTitleCollectionView.homeTitleAry = @[@"快捷租车", @"自助找车", @"超值长租"];
    } else if (stepper.value == 4) {
        self.homeTitleCollectionView.homeTitleAry = @[@"快捷租车", @"自助找车", @"超值长租", @"坦克时租"];
    } else if (stepper.value == 5) {
        self.homeTitleCollectionView.homeTitleAry = @[@"快捷租车", @"自助找车", @"超值长租", @"坦克时租", @"海外租车"];
    } else if (stepper.value == 6) {
        self.homeTitleCollectionView.homeTitleAry = @[@"快捷租车", @"自助找车", @"超值长租", @"坦克时租", @"海外租车", @"凹凸租车"];
    } else if (stepper.value == 7) {
        self.stepper.value = 7;
        self.homeTitleCollectionView.homeTitleAry = @[@"快捷租车", @"自助找车", @"超值长租", @"坦克时租", @"海外租车", @"凹凸租车", @"凹凸坦克"];
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
