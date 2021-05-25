//
//  TXPageViewController.m
//  Demo
//
//  Created by chenxiaojie on 2021/1/8.
//  Copyright © 2021 ChenJie. All rights reserved.
//

#import "TXPageViewController.h"
#import "UIImage+ImgSize.h"
#import <AuthenticationServices/AuthenticationServices.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@interface TXPageViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UIPageViewController *pageViewController;

@end

@implementation TXPageViewController

- (UIPageViewController *)pageViewController {
    if (_pageViewController == nil) {
        NSDictionary *option = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:10] forKey:UIPageViewControllerOptionInterPageSpacingKey];
        _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:option];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        
        [self addChildViewController:_pageViewController];
        [self.view addSubview:_pageViewController.view];
    }
    
    return _pageViewController;
}

#pragma mark - 获取设备当前网络IP地址
- (NSString *)getNetworkIPAddress {
    //方式二：新浪api
    NSError *error;
    NSURL *ipURL = [NSURL URLWithString:@"http://pv.sohu.com/cityjson?ie=utf-8"];
    //NSURL *ipURL = [NSURL URLWithString:@"http://pv.sohu.com/cityjson?ie=utf-8"];
    
    NSMutableString *ip = [NSMutableString stringWithContentsOfURL:ipURL encoding:NSUTF8StringEncoding error:&error];
    //判断返回字符串是否为所需数据
    if ([ip hasPrefix:@"var returnCitySN = "]) {
        //对字符串进行处理，然后进行json解析
        //删除字符串多余字符串
        NSRange range = NSMakeRange(0, 19);
        [ip deleteCharactersInRange:range];
        NSString * nowIp =[ip substringToIndex:ip.length-1];
        //将字符串转换成二进制进行Json解析
        NSData * data = [nowIp dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dict);
        return dict[@"cip"] ? dict[@"cip"] : @"0.0.0.0";
    }
    return @"0.0.0.0";
}

- (UIImage *)kt_drawRectWithRoundedCorner:(CGFloat)radius borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor {
    CGSize sizeToFit = CGSizeMake(100, 100);
    UIGraphicsBeginImageContextWithOptions(sizeToFit, NO, UIScreen.mainScreen.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 100, 100);
    //CGContextMoveToPoint(context, 开始位置);  // 开始坐标右边开始
    //CGContextAddArcToPoint(context, x1, y1, x2, y2, radius);  // 这种类型的代码重复四次
//    CGContextAddArcToPoint(context, 100, 100, 200, 200, 20);
    //CGContextAddArcToPoint(context, 300, 300, 200, 200, 20);
    CGContextAddArc(context, 0, 0, 50, M_PI_4, M_PI_2 , 1);
    //CGContextDrawPath(UIGraphicsGetCurrentContext(), .FillStroke)
    CGContextDrawPath(context, kCGPathFillStroke);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    NSString *ipAddress = [self getNetworkIPAddress];
    //    NSLog(@"ipAddress = %@", ipAddress);
    
    if (@available(iOS 13.0, *)) {
            // Sign In With Apple Button
            ASAuthorizationAppleIDButton *appleIDBtn = [ASAuthorizationAppleIDButton buttonWithType:ASAuthorizationAppleIDButtonTypeDefault style:ASAuthorizationAppleIDButtonStyleWhite];
            appleIDBtn.frame = CGRectMake(30, self.view.bounds.size.height - 180, self.view.bounds.size.width - 60, 100);
            //    appleBtn.cornerRadius = 22.f;
            [appleIDBtn addTarget:self action:@selector(didAppleIDBtnClicked) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:appleIDBtn];
        }
        
    return;
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
//
//        imageView.image = [UIImage imageNamed:@"ic_test"];
//
//        //开始对imageView进行画图
//        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, NO, 1.0);
//
//        // 获得图形上下文
//        CGContextRef ctx = UIGraphicsGetCurrentContext();
//
//        // 设置一个范围
//        CGRect rect = CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height);
//
//        // 根据一个rect创建一个椭圆
//        CGContextAddEllipseInRect(ctx, rect);
//
//        // 裁剪
//        CGContextClip(ctx);
//
//        // 将原照片画到图形上下文
//        [imageView.image drawInRect:rect];
//
//        // 从上下文上获取剪裁后的照片
//        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//
//        // 关闭上下文
//        UIGraphicsEndImageContext();
//
//        imageView.image = newImage;
//
//        [self.view addSubview:imageView];

    
//    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 100, 200, 300) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft cornerRadii:CGSizeMake(20, 40)];
//
//     UIGraphicsBeginImageContextWithOptions(sizeToFit, false, UIScreen.mainScreen().scale)
//     let context = UIGraphicsGetCurrentContext()
//
//     CGContextMoveToPoint(context, 开始位置);  // 开始坐标右边开始
//     CGContextAddArcToPoint(context, x1, y1, x2, y2, radius);  // 这种类型的代码重复四次
//
//     CGContextDrawPath(UIGraphicsGetCurrentContext(), .FillStroke)
//     let output = UIGraphicsGetImageFromCurrentImageContext();
//     UIGraphicsEndImageContext();
//     return output
    
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(200, 300);
    UICollectionView *aView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, naviHeight, SCREEN_WIDTH, 300) collectionViewLayout:layout];
    [aView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    aView.dataSource = self;
    aView.delegate = self;
    aView.backgroundColor = [UIColor redColor];
//    aView.layer.cornerRadius = 100;
//    aView.layer.masksToBounds = YES;
    [self.view addSubview:aView];
    
    
    CGRect rect = aView.bounds;
    CGSize radio = CGSizeMake(30, 30);//圆角尺寸
    UIRectCorner corner = UIRectCornerTopLeft|UIRectCornerTopRight;//这只圆角位置
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corner cornerRadii:radio];
    CAShapeLayer *masklayer = [[CAShapeLayer alloc]init];//创建shapelayer
    masklayer.frame = aView.bounds;
    masklayer.path = path.CGPath;//设置路径
    aView.layer.mask = masklayer;
//
//
//    UILabel *testL = [[UILabel alloc] initWithFrame:CGRectMake(0, aView.bottom, SCREEN_WIDTH, 100)];
//    testL.text = @"测试陪十爱克发";
//    testL.backgroundColor = [UIColor purpleColor];
//    [self.view addSubview:testL];
//    testL.layer.cornerRadius = 20;
//    testL.layer.masksToBounds = YES;
//    //设置所需的圆角位置以及大小
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:aView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(100, 100)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = aView.bounds;
//    maskLayer.path = maskPath.CGPath;
//    aView.layer.mask = maskLayer;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
//    NSAssert(self.dataSource.count > 0, @"Must have one childViewCpntroller at least");
//    NSAssert(self.segmentTitles.count == self.dataSource.count, @"The childViewController's count doesn't equal to the count of segmentTitles");
//    
//    UIViewController *vc = [self.dataSource objectAtIndex:self.selectedIndex];
//    [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
//    
//    self.segmentView.frame = CGRectMake(0, 0, self.view.frame.size.width, 30);
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
