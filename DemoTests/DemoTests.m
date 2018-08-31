//
//  DemoTests.m
//  DemoTests
//
//  Created by ChenJie on 2017/11/2.
//  Copyright © 2017年 ChenJie. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AFNetworking.h"
#import "Masonry.h"
#import "MJRefresh.h"

@interface DemoTests : XCTestCase

@end

@implementation DemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    int a = 3;
    XCTAssertFalse(a == 0,"a 不能 等于 0");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        for (int i =0; i<10000; i++) {
            NSLog(@"this is a example");
        }
    }];
}

- (void)testExample1 {
/** features1 */
//    XCTFail(@"this is a fail test"); // 生成一个失败的测试
    
/** features2 */
    NSString *a1 = nil;//@"";//@"not a nil string";
    XCTAssertNil(a1,@"string must be nil"); // XCTAssertNil(a1, format...) 为空判断， a1 为空时通过，反之不通过；
    
/** features3 */
    NSString *a2 = @"";
    XCTAssertNotNil(a2, @"string can not be nil");

/** features4 */
//    XCTAssert(expression, format...) 当expression求值为TRUE时通过； expression 为一个表达式
//    XCTAssertTrue(expression, format...) 当expression求值为TRUE时通过；>0 的都视为 true
    XCTAssert((3>2), @"expression is true");
    XCTAssertTrue([a2 isEqualToString:@""], @"a2 = @""");
    
    NSInteger a3 = 66;
    XCTAssertFalse(a3 == 0, @"a3 = 0");

/** features5 */
// XCTAssertEqualObjects(a1, a2, format...) 判断相等， [a1 isEqual:a2] 值为TRUE时通过，其中一个不为空时，不通过；
// XCTAssertEqual(a1, a2, format...) 判断相等（当a1和a2是 C语言标量、结构体或联合体时使用,实际测试发现NSString也可以）；
    XCTAssertEqualObjects(@"", a2, @"a1 != a2");
    XCTAssertNotEqualObjects(a1, a2, @"a1 ==  a2");

/** features6 */
    NSArray *array1 = @[@1];
    NSArray *array2 = @[@1];
    NSArray *array3 = array1;
//    XCTAssertEqual(array1, array2, @"a1 and a2 should point to the same object"); // 无法通过测试
    XCTAssertEqual(array1, array3, @"a1 and a2 should point to the same object");
    
/** features7 */
//     XCTAssertEqualWithAccuracy(a1, a2, accuracy, format...) 判断相等，（double或float类型）提供一个误差范围，当在误差范围（+/- accuracy ）以内相等时通过测试；

    XCTAssertEqualWithAccuracy(1.0f, 1.2f, 0.25f, @"a1 = a2 in accuracy should return NO"); // 测试没法通过

/** features8 */
// XCTAssertThrows(expression, format...) 异常测试，当expression发生异常时通过；反之不通过；（很变态）
    
}

- (void)testAsyncFunction {
    XCTestExpectation * expectation = [self expectationWithDescription:@"Just a demo expectation,should pass"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(3);
        NSLog(@"Async test");
        XCTAssert(YES,"should pass");
        [expectation fulfill];
    });
    [self waitForExpectationsWithTimeout:5 handler:^(NSError *error) {
        //Do something when time out
    }];
}

@end
