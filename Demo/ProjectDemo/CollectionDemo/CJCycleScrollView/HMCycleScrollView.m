//
//  HMCycleScrollView.m
//  Demo
//
//  Created by ChenJie on 2018/1/26.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "HMCycleScrollView.h"
#import "UIImageView+WebCache.h"
#import "UIImage+GIF.h"
#import "TXCommonUtils.h"
#import "HMGrayImageView.h"

@interface HMCycleScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) HMCustomPageView *customPageView;
/** 展示图片总数 */
@property (assign, nonatomic) NSInteger imageCount;
/** 当前页 */
@property (assign, nonatomic) CGFloat currentIndex;
/** 图片在 scrollview 中的 frame */
@property (nonatomic, assign) CGRect imageViewF;
/** 图片圆角 */
@property (nonatomic, assign) CGFloat radius;
/** 是否循环轮播（默认：NO） */
@property (nonatomic, assign) BOOL repeats;
/** 自动轮播秒数（设置为 0 则不自动轮播） */
@property (nonatomic, assign) NSTimeInterval autoScrollDuration;

@end

@implementation HMCycleScrollView

+ (instancetype)cycleScrollViewFrame:(CGRect)frame radius:(CGFloat)radius repeats:(BOOL)repeats autoScrollDuration:(NSTimeInterval)autoScrollDuration {
    CGRect imageViewF = CGRectMake(0, 0, frame.size.width, frame.size.height);
    return [self cycleScrollViewFrame:frame imageViewFrame:imageViewF radius:radius repeats:repeats autoScrollDuration:autoScrollDuration];
}

+ (instancetype)cycleScrollViewFrame:(CGRect)frame imageViewFrame:(CGRect)imageViewF radius:(CGFloat)radius repeats:(BOOL)repeats autoScrollDuration:(NSTimeInterval)autoScrollDuration {
    return [[self alloc] initWithFrame:frame imageViewFrame:imageViewF radius:radius repeats:repeats autoScrollDuration:autoScrollDuration];
}

- (instancetype)initWithFrame:(CGRect)frame imageViewFrame:(CGRect)imageViewF radius:(CGFloat)radius repeats:(BOOL)repeats autoScrollDuration:(NSTimeInterval)autoScrollDuration {
    if (self = [super initWithFrame:frame]) {
        self.imageViewF = imageViewF;
        self.radius  = radius;
        self.repeats = repeats;
        self.autoScrollDuration = autoScrollDuration;
        
        CGRect scrollViewF = CGRectMake(frame.origin.x, 0, frame.size.width, frame.size.height);
        self.scrollView = [[UIScrollView alloc] initWithFrame:scrollViewF];
        self.scrollView.delegate = self;
        // 设置整屏滚动
        self.scrollView.pagingEnabled = YES;
        // 设置边缘无弹跳
        self.scrollView.bounces = NO;
        // 不显示水平、竖直滚动条
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:self.scrollView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
        [self.scrollView addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)setImageArray:(NSArray<NSString *> *)imageArray {
    if (imageArray.count == 0) return;
    
    self.imageCount = imageArray.count;
    
    NSMutableArray *imageArrayNew = [imageArray mutableCopy];
    // 只有一张图片情况 不可滚动
    if (self.repeats && imageArray.count != 1) {
        // 修改数据源、完成循环轮播
        NSString *firstObj = [imageArray firstObject];
        NSString *lastObj = [imageArray lastObject];
        [imageArrayNew insertObject:lastObj atIndex:0];
        [imageArrayNew insertObject:firstObj atIndex:imageArrayNew.count];
    }
    imageArray = imageArrayNew;
    _imageArray = imageArray;
    
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width * imageArray.count, self.frame.size.height);
    
    for (int i = 0; i<imageArray.count; i++) {
        CGRect imageViewF = CGRectMake(self.scrollView.frame.size.width * i + self.imageViewF.origin.x, self.imageViewF.origin.y, self.imageViewF.size.width, self.imageViewF.size.height);
        HMGrayImageView *imageView = [[HMGrayImageView alloc] initWithFrame:imageViewF];
        imageView.used = self.grayImageView;
        imageView.contentMode = UIViewContentModeScaleToFill;
        if (self.radius > 0) {
            imageView.layer.cornerRadius = self.radius;
            imageView.layer.masksToBounds = YES;
        }
        // gif
        if ([imageArray[i] containsString:@".gif?"]) {
            [TXCommonUtils downloadPic:imageArray[i] successBlock:^(NSString * _Nonnull filepath) {
                UIImage *image;
                if ([filepath containsString:@"gif"]) {
                    image = [UIImage sd_imageWithGIFData:[NSData dataWithContentsOfFile:filepath]];
                } else/* if ([suffix isEqualToString:@"jpg"] || [suffix isEqualToString:@"png"] || [suffix isEqualToString:@"jpeg"]) */{
                    image = [UIImage imageWithContentsOfFile:filepath];
                }
                if (image != nil) {
                    imageView.image = image;
                }
            }];
        } else {
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageArray[i]] placeholderImage:[UIImage imageNamed:@"pageLoading.jpg"] options:SDWebImageRefreshCached];
        }
        [self.scrollView addSubview:imageView];
    }
    if (self.repeats) {
        [self.scrollView scrollRectToVisible:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:NO];
    }
    
    if (self.autoScrollDuration > 0) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollDuration target:self selector:@selector(updateCycleScrollImagesLocation) userInfo:nil repeats:YES];
    }
}

- (void)setPageControlType:(PageControlType)pageControlType {
    _pageControlType = pageControlType;
}

- (void)setPageControlPosition:(PageControlPosition)pageControlPosition {
    _pageControlPosition = pageControlPosition;
    // 只有一张图片情况, 无 pageControl
    if (self.imageCount == 1) return;
    
    CGFloat customPageViewY = (self.frame.size.height - (self.frame.size.height - self.imageViewF.size.height)/2.0) - 10;
    HMCustomPageStyle *pageStyle = [[HMCustomPageStyle alloc] init];
    if (self.grayImageView) {
        pageStyle.normalColor = [UIColor whiteColor];
        pageStyle.selectedColor = [UIColor grayColor];
    }
    self.customPageView = [[HMCustomPageView alloc] initWithFrame:CGRectMake(0, customPageViewY, self.frame.size.width, 3) pageCount:self.imageCount pageControlType:self.pageControlType pageStyle:pageStyle];
    self.customPageView.pageControlPosition = pageControlPosition;
    [self addSubview:self.customPageView];
}

#pragma mark - Action
- (void)updateCycleScrollImagesLocation {
    self.currentIndex += 1;
    NSLog(@"定时器开始工作 = %.2f", self.currentIndex);
    if (self.currentIndex == self.imageCount + 1) {
        CGRect frame = CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
        [self.scrollView scrollRectToVisible:frame animated:NO];
    } else {
        CGFloat width = (self.currentIndex + (self.repeats ? 1 : 0)) * self.frame.size.width;
        [self.scrollView setContentOffset:CGPointMake(width, 0) animated:YES];
    }
    // 如果不需要重复，轮播到最后一个自动结束
    if (!self.repeats && self.currentIndex == self.imageCount - 1) {
        [self.timer invalidate];
    }
}

- (void)contentViewTapAction:(UITapGestureRecognizer *)gr {
    NSLog(@"当前点击的index = %.2f", self.currentIndex);
    if (self.tapActionBlock) {
        self.tapActionBlock(self.currentIndex);
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.currentIndex = scrollView.contentOffset.x / self.frame.size.width - (self.repeats ? 1 : 0);
    // 更新当前需要显示 pageControl 位置
    self.customPageView.progressIndex = self.currentIndex;
    //NSLog(@"self.currentIndex:%.2f",self.currentIndex);
    
    CGPoint point = CGPointMake(scrollView.frame.size.width, 0);
    // 判断整数
    if ((NSInteger)self.currentIndex == self.currentIndex) {
        if (self.currentIndex == self.imageCount) {
            point.x = self.frame.size.width;
            [self.scrollView setContentOffset:point animated:NO];
        } else if (self.currentIndex == -1) {
            point.x = self.frame.size.width * self.imageCount;
            [self.scrollView setContentOffset:point animated:NO];
        } else {
            
        }
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.timer resumeTimerAfterTimeInterval:self.autoScrollDuration];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger currentIndex = scrollView.contentOffset.x / self.frame.size.width - (self.repeats ? 1 : 0);
    
    if (currentIndex == self.imageCount) {
        currentIndex = 0;
    } else if (currentIndex == -1) {
        currentIndex = self.imageCount - 1;
    }
    //NSLog(@"手动滚动 = %.2f", currentIndex);
    if (self.scrollDidEndBlock) {
        self.scrollDidEndBlock(currentIndex);
    }
}

//- (void)dealloc {
//    NSLog(@"%s", __func__);
//    [self.timer invalidate];
//}

@end
