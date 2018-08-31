//
//  CellAddCollectionViewControllerTests.m
//  DemoTests
//
//  Created by ChenJie on 2018/8/31.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "CellAddCollectionViewControllerTests.h"
#import "KIFUITestActor+EXAdditions.h"

@implementation CellAddCollectionViewControllerTests

- (void)beforeEach
{
    [tester navigateToLoginPage];
}

- (void)afterEach
{
    [tester returnToLoggedOutHomeScreen];
}

- (void)testSuccessfulLogin
{
    //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:4 inSection:0];
    
    //[tester tapItemAtIndexPath:indexPath inCollectionViewWithAccessibilityIdentifier:@"DemoTableViewCell"];
    
//    [tester enterText:@"user@example.com" intoViewWithAccessibilityLabel:@"Login User Name"];
//    [tester enterText:@"thisismypassword" intoViewWithAccessibilityLabel:@"Login Password"];
//    [tester tapViewWithAccessibilityLabel:@"Log In"];
//
//    // Verify that the login succeeded
//    [tester waitForTappableViewWithAccessibilityLabel:@"Welcome"];
}


@end
