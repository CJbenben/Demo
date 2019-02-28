//
//  UITabbarViewController.m
//  Demo
//
//  Created by chenxiaojie on 2019/2/28.
//  Copyright © 2019年 ChenJie. All rights reserved.
//

#import "UITabbarViewController.h"
#import "SecondViewController.h"
#import "PersonViewController.h"

@interface UITabbarViewController ()

@end

@implementation UITabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    UINavigationController *secondNaviVC = [[UINavigationController alloc] initWithRootViewController:secondVC];
    
    UITabBarItem *secondTab = [[UITabBarItem alloc] initWithTitle:@"首页"
                                                          image:[[UIImage imageNamed:@"icon-home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                  selectedImage:[[UIImage imageNamed:@"tabHomeSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    secondNaviVC.tabBarItem = secondTab;
    
    PersonViewController *personVC = [[PersonViewController alloc] init];
    UINavigationController *personNaviVC = [[UINavigationController alloc] initWithRootViewController:personVC];
    
    UITabBarItem *personTab = [[UITabBarItem alloc] initWithTitle:@"个人中心"
                                                          image:[[UIImage imageNamed:@"icon-home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                  selectedImage:[[UIImage imageNamed:@"tabHomeSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    personNaviVC.tabBarItem = personTab;
    
    self.viewControllers = @[secondNaviVC, personNaviVC];
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
