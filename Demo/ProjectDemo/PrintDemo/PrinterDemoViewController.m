//
//  PrinterDemoViewController.m
//  Demo
//
//  Created by chenxiaojie on 2020/11/17.
//  Copyright © 2020 ChenJie. All rights reserved.
//

#import "PrinterDemoViewController.h"

@interface PrinterDemoViewController ()<UIPrintInteractionControllerDelegate>

@end

@implementation PrinterDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

// 打印PDF
- (IBAction)printerPdfAction:(UIButton *)sender {
    NSData *pdfData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"123456" ofType:@"pdf"]];
    [self printerMethodWithData:pdfData];
}

- (IBAction)printerImageAction:(UIButton *)sender {
    NSData *imgData = UIImagePNGRepresentation([UIImage imageNamed:@"ic_test"]);
    [self printerMethodWithData:imgData];
}

- (void)printerMethodWithData:(NSData *)data {
    UIPrintInteractionController *print = [UIPrintInteractionController sharedPrintController];
    NSMutableArray *tempMarr = [NSMutableArray new];
    [tempMarr addObject:data];

    if (print) {
        UIPrintInfo *printInfo = [UIPrintInfo printInfo];
        // 打印输出类型
        printInfo.outputType = UIPrintInfoOutputPhoto;
        // 默认应用程序名称
        printInfo.jobName = @"jobName";
        // 双面打印信息，NONE为禁止双面
        printInfo.duplex = UIPrintInfoDuplexLongEdge;
        // 打印纵向还是横向
        printInfo.orientation = UIPrintInfoOrientationPortrait;
        print.printInfo = printInfo;

        print.delegate = self;
        print.showsPageRange = YES;
        print.printingItems = tempMarr;
        
        void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) =
        ^(UIPrintInteractionController *pic, BOOL completed, NSError *error) {
            if (!completed && error) {
                // failed
            }
        };
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [print presentFromRect:self.view.frame inView:self.view animated:YES completionHandler:completionHandler];
        } else {
            [print presentAnimated:YES completionHandler:completionHandler];
        }
    }
}


#pragma mark - UIPrintInteractionControllerDelegate
- (void)printInteractionControllerWillPresentPrinterOptions:(UIPrintInteractionController *)printInteractionController {
    NSLog(@"打印机选择页面即将弹出");
}

- (void)printInteractionControllerDidPresentPrinterOptions:(UIPrintInteractionController *)printInteractionController {
    NSLog(@"打印机选择页面已经弹出");
}

- (void)printInteractionControllerWillDismissPrinterOptions:(UIPrintInteractionController *)printInteractionController {
    NSLog(@"打印机选择页面即将消失");
}

- (void)printInteractionControllerDidDismissPrinterOptions:(UIPrintInteractionController *)printInteractionController {
    NSLog(@"打印机选择页面已经消失");
}

- (void)printInteractionControllerWillStartJob:(UIPrintInteractionController *)printInteractionController {
    NSLog(@"打印机即将开始工作");
}

- (void)printInteractionControllerDidFinishJob:(UIPrintInteractionController *)printInteractionController {
    NSLog(@"打印机已经完成工作");
}

//- (UIPrinterCutterBehavior) printInteractionController:(UIPrintInteractionController *)printInteractionController chooseCutterBehavior:(NSArray *)availableBehaviors API_AVAILABLE(ios(9.0)) {
//
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
