//
//  ChartViewController.m
//  Demo
//
//  Created by chenxiaojie on 2019/2/28.
//  Copyright © 2019年 ChenJie. All rights reserved.
//  参考文章：
//      1.charts第三方库：https://github.com/danielgindi/Charts
//      2.https://www.jianshu.com/p/da0f70a21ab4、
//      3.https://www.jianshu.com/p/524036c43534、
//      4.https://blog.csdn.net/qq_33726122/article/details/80255627

#import "ChartViewController.h"
#import "Demo-Bridging-Header.h"

#define xVals_count 20

@interface ChartViewController ()<ChartViewDelegate>

@property (nonatomic,strong) LineChartView *lineChartView;//折线图
@property (nonatomic, strong) LineChartDataSet *set1;//折线

@end

@implementation ChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];//[UIColor colorWithRed:230/255.0f green:253/255.0f blue:253/255.0f alpha:1];
    self.title = @"折线图";
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    
    self.lineChartView = [[LineChartView alloc] init];
    self.lineChartView.delegate = self;
    //设置代理
    [self.view addSubview:self.lineChartView];
    self.lineChartView.frame = CGRectMake(0, 88, SCREEN_WIDTH, SCREEN_HEIGHT - 88);
    //self.lineChartView.backgroundColor = [UIColor colorWithRed:230/255.0f green:253/255.0f blue:253/255.0f alpha:1];
    self.lineChartView.noDataText = @"暂无数据";
    
    self.lineChartView.chartDescription.text = @"折线图开发测试中";
    //self.lineChartView.drawGridBackgroundEnabled = YES;// 是否要画网格线
    //self.lineChartView.pinchZoomEnabled = YES;//是否支持X轴、Y轴同时缩放，如果是YES ，则代表支持同时缩放。
    self.lineChartView.scaleXEnabled = YES;//取消X轴缩放
    self.lineChartView.scaleYEnabled = NO;//取消Y轴缩放
    self.lineChartView.legend.enabled = YES;
    
    
    ChartXAxis *xAxis = self.lineChartView.xAxis;//[[ChartXAxis alloc] init];
    xAxis.axisLineWidth = 1.0/[UIScreen mainScreen].scale;//设置X轴线宽
    xAxis.labelPosition = XAxisLabelPositionBottom;//X轴的显示位置，默认是显示在上面的
    xAxis.drawGridLinesEnabled = NO;//不绘制网格线
    xAxis.axisLineColor = [UIColor blackColor];
    xAxis.labelTextColor = [UIColor blackColor];//label文字颜色
    //xAxis.axisMaximum = 10;//最多显示个数
    
    
    ChartYAxis *leftAxis = self.lineChartView.leftAxis;
    leftAxis.labelCount = 10;//Y轴label数量，数值不一定，如果forceLabelsEnabled等于YES, 则强制绘制制定数量的label, 但是可能不平均
    leftAxis.forceLabelsEnabled = NO;//不强制绘制指定数量的
    leftAxis.axisMinimum = 0;//设置Y轴的最小值
    //leftAxis.axisMaximum = 105;//设置Y轴的最大值
    leftAxis.drawZeroLineEnabled = YES;//从0开始绘制
    leftAxis.drawGridLinesEnabled = NO;//不绘制网格线
    //leftAxis.drawZeroLineEnabled = YES;//从0开始绘制
    leftAxis.inverted = NO;//是否将Y轴进行上下翻转
    leftAxis.axisLineWidth = 1.0/[UIScreen mainScreen].scale;//Y轴线宽
    leftAxis.axisLineColor = [UIColor blackColor];//Y轴颜色
    
    self.lineChartView.rightAxis.enabled = NO;
    
    self.lineChartView.doubleTapToZoomEnabled = NO;//取消双击缩放
    
    
    NSMutableArray *xVals1 = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < xVals_count; i++) {
        double y = arc4random() % 1234;
        if (y < 400) {
            i--;
        } else {
            ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:y];
            [xVals1 addObject:entry];
        }
    }
    LineChartDataSet *set1 = [[LineChartDataSet alloc] initWithValues:xVals1 label:@"eventId 7-2"];
    set1.mode = LineChartModeHorizontalBezier;// 模式为曲线模式
    set1.drawValuesEnabled = YES;//是否在拐点处显示数据
    set1.highlightEnabled = YES;//选中拐点,是否开启高亮效果(显示十字线)
    set1.highlightColor = [UIColor clearColor];
    set1.circleHoleRadius = 3.4;//空心的半径
    [set1 setCircleColor:[UIColor blackColor]];//空心的圈的颜色
    
    set1.circleHoleColor = [UIColor whiteColor];;//空心的颜色
    set1.circleRadius = 4.0;//拐点半径
    set1.cubicIntensity = 0.2;// 曲线弧度
    set1.drawFilledEnabled = YES;//是否填充颜色
    //set1.fillColor = [UIColor redColor];
    
    // 设置渐变效果
    [set1 setColor:[UIColor purpleColor]];//折线颜色
    NSArray *gradientColors1 = @[(id)[ChartColorTemplates colorFromString:@"#FFFFFFFF"].CGColor,
                                (id)[ChartColorTemplates colorFromString:@"#C4F3FF"].CGColor];
    CGGradientRef gradientRef1 = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors1, nil);
    set1.fillAlpha = 1.0f;//透明度
    set1.fill = [ChartFill fillWithLinearGradient:gradientRef1 angle:90.0f];//赋值填充颜色对象
    CGGradientRelease(gradientRef1);//释放gradientRef
    [dataSets addObject:set1];
    

    LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
    self.lineChartView.data = data;
    
    [self.lineChartView animateWithYAxisDuration:1.2f easingOption:ChartEasingOptionEaseOutQuart];
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
