//
//  AppDelegate.m
//  Demo
//
//  Created by ChenJie on 2017/11/2.
//  Copyright © 2017年 ChenJie. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "MGFaceLicenseHandle.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)testGit {
    NSLog(@"test_cherry-pick");
}

- (void)testGit2 {
    NSLog(@"正在开发其他功能ing");
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [AMapServices sharedServices].apiKey = @"75508709c3afc527ae436eea41f29b2f";
    
//    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    [self.window makeKeyAndVisible];
//    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
//    self.window.rootViewController = navi;
    
    [MGFaceLicenseHandle licenseForNetwokrFinish:^(bool License, NSDate *sdkDate) {
        if (!License) {
            NSLog(@"联⽹网授权失败 !!!");
        } else {
            NSLog(@"联⽹网授权成功");
        }
    }];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end