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
#import "HMCustomPageView.h"
//#import "UIImageView+SDCategory.h"
#import "TXCommonUtils.h"
#import "TXCommonKit.h"

@interface HMCycleScrollView ()<UIScrollViewDelegate>

@property(nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic, strong) HMCustomPageView *customPageView;

/**
 *  滚动图片总数
 */
@property (assign, nonatomic) NSInteger imageCount;

/**
 *  当前页
 */
@property (assign, nonatomic) CGFloat currentIndex;

@property (assign, nonatomic) CGFloat x;

/**
 *  动画时间
 */
@property (nonatomic , assign) NSTimeInterval animationDuration;

@end

@implementation HMCycleScrollView

+ (instancetype)atzucheCycleScrollViewFrame:(CGRect)scrollViewF imagePaths:(NSArray<NSString *> *)imagePaths {
    return [self atzucheCycleScrollViewFrame:scrollViewF imagePaths:imagePaths animationDuration:0.0];
}

+ (instancetype)atzucheCycleScrollViewFrame:(CGRect)scrollViewF imagePaths:(NSArray<NSString *> *)imagePaths animationDuration:(NSTimeInterval)animationDuration {
    CGRect imageViewF = CGRectMake(0, 0, scrollViewF.size.width, scrollViewF.size.height);
    return [self atzucheCycleScrollViewFrame:scrollViewF imageViewFrame:imageViewF radius:0.0 imagePaths:imagePaths animationDuration:animationDuration];
}

+ (instancetype)atzucheCycleScrollViewFrame:(CGRect)scrollViewF imageViewFrame:(CGRect)imageViewF radius:(CGFloat)radius imagePaths:(NSArray *)imagePaths animationDuration:(NSTimeInterval)animationDuration {
    return [[self alloc] initWithFrame:scrollViewF imageViewFrame:imageViewF radius:radius imagePaths:imagePaths animationDuration:animationDuration];
}

- (instancetype)initWithFrame:(CGRect)frame imageViewFrame:(CGRect)imageViewF radius:(CGFloat)radius imagePaths:(NSArray *)imagePaths animationDuration:(NSTimeInterval)animationDuration {
    if (self = [super initWithFrame:frame]) {
        if (imagePaths.count == 0) {
            return self;
        }
        self.imageCount = imagePaths.count;
        self.x = SCREEN_WIDTH;
        CGRect scrollFrame = CGRectMake(0, 0, SCREEN_WIDTH, frame.size.height);
        
        NSMutableArray *imageAry = [imagePaths mutableCopy];
        if (imagePaths.count > 1) {
            // 修改数据源、完成循环轮播
            NSString *firstObj = [imageAry firstObject];
            NSString *lastObj = [imageAry lastObject];
            [imageAry insertObject:lastObj atIndex:0];
            [imageAry insertObject:firstObj atIndex:imageAry.count];
        }
        self.scrollView = [self createScrollViewWithPath:imageAry scrollViewFrame:scrollFrame imageViewFrame:imageViewF radius:radius];
        // 只有一张图片情况 不可滚动，也无 pageControl
        if (imagePaths.count > 1) {
            // 设置自动滚动
            if (animationDuration) {
                self.timer = [NSTimer scheduledTimerWithTimeInterval:(self.animationDuration = animationDuration) target:self selector:@selector(updateCycleScrollImagesLocation) userInfo:nil repeats:YES];
            }
            self.scrollView.scrollEnabled = YES;
            self.scrollView.delegate = self;
            
            CGRect frame = scrollFrame;
            frame.origin.x = frame.size.width;
            [self addSubview:self.scrollView];
            
            // 添加自定义 pageControl view
            CGFloat customPageViewY = (frame.size.height - (frame.size.height - imageViewF.size.height)/2.0) - 10;
            self.customPageView = [[HMCustomPageView alloc] initWithFrame:CGRectMake(0, customPageViewY, SCREEN_WIDTH, 3) pageCount:self.imageCount pageControlType:PageControlTypeCustom];
            self.customPageView.pageControllPostion = PageControlPostionBottom;
            [self addSubview:self.customPageView];
            
            [self.scrollView scrollRectToVisible:frame animated:NO];
        } else {
            self.scrollView.scrollEnabled = NO;
            [self addSubview:self.scrollView];
        }
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
        [self.scrollView addGestureRecognizer:tapGesture];
    }
    return self;
}

#pragma mark - Action
- (void)updateCycleScrollImagesLocation{
    
    self.x +=  SCREEN_WIDTH;
    
    int count = (int)self.x % (int)SCREEN_WIDTH;
    
    NSInteger scrollAbnormalCount = self.x/SCREEN_WIDTH;
    
    if (count == 0) {
        [self.scrollView setContentOffset:CGPointMake(self.x, 0) animated:YES];
    }else{
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * (scrollAbnormalCount + 1), 0) animated:YES];
    }
    
    if (self.x == SCREEN_WIDTH * (self.imageCount + 1)) {
        self.x = SCREEN_WIDTH;
    }
}

- (void)contentViewTapAction:(UITapGestureRecognizer *)gr{
    if (self.TapActionBlock) {
        self.TapActionBlock(self.currentIndex);
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.currentIndex = scrollView.contentOffset.x / SCREEN_WIDTH - 1;
    // 更新当前需要显示 pageControl 位置
    self.customPageView.progressIndex = self.currentIndex;
    //NSLog(@"self.currentIndex:%.2f",self.currentIndex);
    
    CGRect frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, scrollView.frame.size.height);
    
    if (scrollView == self.scrollView) {
        
        if ((NSInteger)self.currentIndex == self.currentIndex) {//判断整数
            if (self.currentIndex == self.imageCount) {
                frame.origin.x = SCREEN_WIDTH;
                self.x = frame.origin.x;
                [self.scrollView scrollRectToVisible:frame animated:NO];
            }else if (self.currentIndex == -1){
                frame.origin.x = SCREEN_WIDTH * self.imageCount;
                self.x = frame.origin.x;
                [self.scrollView scrollRectToVisible:frame animated:NO];
            }else{
                self.x = self.currentIndex * SCREEN_WIDTH;
            }
            
        }
    }else if (scrollView == self.scrollView){//预留
        
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.timer resumeTimerAfterTimeInterval:self.animationDuration];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger currIndex = scrollView.contentOffset.x/SCREEN_WIDTH;
    
    if (currIndex == self.imageCount + 1) {
        currIndex = 1;
    } else if (currIndex == 0) {
        currIndex = self.imageCount;
    }
    if (self.ScrollActionBlock) {
        self.ScrollActionBlock(currIndex);
    }
}

- (UIScrollView *)createScrollViewWithPath:(NSMutableArray *)imagesPathAry scrollViewFrame:(CGRect)scrollViewF imageViewFrame:(CGRect)imageViewF radius:(CGFloat)radius{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:scrollViewF];
    scrollView.contentSize = CGSizeMake(scrollViewF.size.width * imagesPathAry.count, scrollViewF.size.height);
    CGFloat imageViewX = imageViewF.origin.x;
    CGFloat imageViewY = imageViewF.origin.y;
    for (int i = 0; i<imagesPathAry.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        if ([safeObjectTxAtIndex(imagesPathAry, i) containsString:@".gif?"]) {
            [TXCommonUtils downloadPic:safeObjectTxAtIndex(imagesPathAry, i) successBlock:^(NSString * _Nonnull filepath) {
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
            [imageView sd_setImageWithURL:[NSURL URLWithString:imagesPathAry[i]] placeholderImage:[UIImage imageNamed:@"pageLoading.jpg"] options:SDWebImageRefreshCached];
        }
        imageView.contentMode = UIViewContentModeScaleToFill;
        
        if (radius != 0) {
            imageView.layer.borderColor = [UIColor clearColor].CGColor;
            imageView.layer.borderWidth = 1.0;
            imageView.layer.cornerRadius = radius;
            imageView.layer.masksToBounds = YES;
        }
        
        imageViewF.origin = CGPointMake(scrollView.frame.size.width * i + imageViewX, imageViewY);
        imageViewF.size = imageViewF.size;
        imageView.frame = imageViewF;
        [scrollView addSubview:imageView];
    }
    scrollView.pagingEnabled = YES;//设置整屏滚动
    scrollView.bounces = NO;//设置边缘无弹跳
    scrollView.showsHorizontalScrollIndicator = NO;//水平滚动条
    scrollView.showsVerticalScrollIndicator = NO;//竖直滚动条
    return scrollView;
}

@end
