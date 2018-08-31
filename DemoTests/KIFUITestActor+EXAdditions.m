//
//  KIFUITestActor+EXAdditions.m
//  DemoTests
//
//  Created by ChenJie on 2018/8/31.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "KIFUITestActor+EXAdditions.h"

@implementation KIFUITestActor (EXAdditions)
- (void)navigateToLoginPage
{
    [self tapViewWithAccessibilityLabel:@"Login/Sign Up"];
    [self tapViewWithAccessibilityLabel:@"Skip this ad"];
}

- (void)returnToLoggedOutHomeScreen
{
    [self tapViewWithAccessibilityLabel:@"Logout"];
    [self tapViewWithAccessibilityLabel:@"Logout"]; // Dismiss alert.
}

@end
