//
//  ScrollViewXibViewController.m
//  Demo
//
//  Created by chenxiaojie on 2019/11/12.
//  Copyright © 2019 ChenJie. All rights reserved.
//

#import "ScrollViewXibViewController.h"
#import "ScrollViewTest.h"

@interface ScrollViewXibViewController ()

@property (nonatomic, strong) ScrollViewTest *scrollBgView;
@property (nonatomic, strong) UIPasteControl *control;
@property (nonatomic, strong) UITextField *targetTextField;

@end

@implementation ScrollViewXibViewController

- (ScrollViewTest *)scrollBgView {
    if (_scrollBgView == nil) {
        _scrollBgView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ScrollViewTest class]) owner:nil options:nil] firstObject];
    }
    return _scrollBgView;
}

- (void)viewDidLoad {
   [super viewDidLoad];
   // Do any additional setup after loading the view.
   if (@available(iOS 16.0, *)) {
       
//       self.control = [[UIPasteControl alloc] init];
//       self.control.target = self;
       
       [self.view addSubview:self.targetTextField];

       UIPasteControlConfiguration *config = [[UIPasteControlConfiguration alloc]init];
       config.baseBackgroundColor = [UIColor orangeColor];
       config.baseForegroundColor = [UIColor greenColor];
       config.cornerStyle = UIButtonConfigurationCornerStyleCapsule;
       config.displayMode = UIPasteControlDisplayModeIconAndLabel;
       
       self.control = [[UIPasteControl alloc] initWithConfiguration:config];
//       _control.target = self.tar getTextField;
       self.control.frame = CGRectMake(self.view.frame.size.width - 100, 0, 100, 40);
//       self.control.center = self.view.center;
//       NSLog(@"粘贴板%@",self.control.target);
       [self.targetTextField addSubview:self.control];
       
       self.control.target = self.targetTextField;
       
   } else {
       NSString *copy = [[UIPasteboard generalPasteboard] string];
       NSLog(@"粘贴板%@",copy);
   }
   
   
}
- (UITextField *)targetTextField {
   
   if (!_targetTextField) {
       
       _targetTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width - 20, 40)];
       
       _targetTextField.borderStyle = UITextBorderStyleRoundedRect;
       
       [_targetTextField addTarget:self
                            action:@selector(targetTextFieldAction:)
                  forControlEvents:UIControlEventEditingChanged];
//       [_targetTextField becomeFirstResponder];
   }
   
   return _targetTextField;
}
//
- (void)targetTextFieldAction:(UITextField *)textField {
   
   NSLog(@"粘贴值%@", textField.text);
   NSLog(@"粘贴板%@,控制器%@",_control.target, _control.configuration);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSString *str = [UIPasteboard generalPasteboard].string;
    NSLog(@"%@", str);
}

//- (void)pasteItemProviders:(NSArray<NSItemProvider *> *)itemProviders {
//    for (NSItemProvider *provider in itemProviders) {
//        [provider loadObjectOfClass:NSString.class
//              completionHandler:^(id<NSItemProviderReading>  _Nullable object, NSError * _Nullable error) {
//            if (object) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    NSString *result = [NSString stringWithFormat:@"复制的内容: %@", object];
//                    NSLog(@"%@",result);
//                });
//            }
//        }];
//    }
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
