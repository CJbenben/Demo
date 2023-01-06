//
//  HMCustomPageView.m
//  LYHM
//
//  Created by chenxiaojie on 2019/12/23.
//  Copyright © 2019 chenxiaojie. All rights reserved.
//

#import "HMCustomPageView.h"
#import "TXCommonKit.h"
#import "TXCategoryKit.h"

// 系统 pageControl 大小
#define PAGECONTROL_WIDTH       20
#define PAGECONTROL_HEIGHT      20

/* 自定义 pageControl */
// 自定义进度条高度
#define BGPAGECONTROLVIEWHEIGHT 1.5
// 自定义 progressview 单个宽
#define PROGRESSSINGLEWIDTH     20
// 自定义 pageControl 背景颜色
//#define BGPROGRESSCOLOR         [UIColor whiteColor]
// 自定义 pageControl 高亮颜色
//#define PROGRESSCOLOR           [UIColor redColor]

@implementation HMCustomPageStyle

- (UIColor *)normalColor {
    if (_normalColor) {
        return _normalColor;
    }
    return [UIColor whiteColor];
}

- (UIColor *)selectedColor {
    if (_selectedColor) {
        return _selectedColor;
    }
    return [UIColor redColor];
}

@end

@interface HMCustomPageView ()
/** 系统 pageControl */
@property (nonatomic, strong) UIPageControl *pageControl;

/** 自定义 pageControl 当前高亮 view */
@property (nonatomic, strong) UIView *progressView;
/** 需要总进度个数 */
@property (assign, nonatomic) NSInteger imageCount;

@property (nonatomic, assign) PageControlType pageControlType;

@property (nonatomic, strong) HMCustomPageStyle *pageStyle;

@end

@implementation HMCustomPageView

- (UIView *)progressView {
    if (_progressView == nil) {
        _progressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, PROGRESSSINGLEWIDTH, self.frame.size.height)];
        _progressView.layer.cornerRadius = BGPAGECONTROLVIEWHEIGHT/2.0;
        _progressView.layer.masksToBounds = YES;
        _progressView.backgroundColor = self.pageStyle.selectedColor;
    }
    return _progressView;
}

- (void)setProgressIndex:(CGFloat)progressIndex {
    _progressIndex = progressIndex;
    
    if (self.pageControlType == PageControlTypeCustom) {
        // 每一个滚动 view 的宽度
        CGFloat progressViewW = self.frame.size.width/self.imageCount;
        // 当从第一张左滑展示最后一张时、无需动画效果
        if (progressIndex == -1) {
            self.progressView.frame = CGRectMake(progressViewW * (self.imageCount - 1), 0, progressViewW, self.frame.size.height);
        }
        // 当从最后一张右滑展示第一张时、无需动画效果
        else if (progressIndex == 0) {
            self.progressView.frame = CGRectMake(0, 0, progressViewW, self.frame.size.height);
        } else {
            self.progressView.frame = CGRectMake(progressViewW * progressIndex, 0, progressViewW, self.frame.size.height);
        }
    } else {
        if ((NSInteger)progressIndex == progressIndex) {//判断整数
            self.pageControl.currentPage = (NSInteger)progressIndex;
        }
    }
}

- (void)setPageControlPosition:(PageControlPosition)pageControlPosition {
    _pageControlPosition = pageControlPosition;
    
    if (_pageControlPosition == PageControlPositionLeft){
        self.frame = CGRectMake(20, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    } else if (_pageControlPosition == PageControlPositionRight) {
        self.frame = CGRectMake(SCREEN_WIDTH - 20 - self.frame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    } else if (_pageControlPosition == PageControlPositionNull){
        self.frame = CGRectMake(self.frame.origin.x, SCREEN_HEIGHT, self.frame.size.width, self.frame.size.height);
    } else if (_pageControlPosition == PageControlPositionTop) {
        self.frame = CGRectMake(self.frame.origin.x, 10, self.frame.size.width, self.frame.size.height);
    } else{
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    }
}

- (instancetype)initWithFrame:(CGRect)frame pageCount:(NSInteger)pageCount pageControlType:(PageControlType)pageControlType {
    HMCustomPageStyle *pageStyle = [[HMCustomPageStyle alloc] init];
    return [self initWithFrame:frame pageCount:pageCount pageControlType:pageControlType pageStyle:pageStyle];
}

- (instancetype)initWithFrame:(CGRect)frame pageCount:(NSInteger)pageCount pageControlType:(PageControlType)pageControlType pageStyle:(HMCustomPageStyle *)pageStyle {
    if (self = [super initWithFrame:frame]) {
        self.pageControlType = pageControlType;
        self.pageStyle = pageStyle;
        if (pageControlType == PageControlTypeCustom) {
            self.imageCount = pageCount;
            self.frame = CGRectMake((SCREEN_WIDTH - self.imageCount * PROGRESSSINGLEWIDTH)/2.0, frame.origin.y, self.imageCount * PROGRESSSINGLEWIDTH, BGPAGECONTROLVIEWHEIGHT);
            self.backgroundColor = self.pageStyle.normalColor;
            self.layer.cornerRadius = BGPAGECONTROLVIEWHEIGHT/2.0;
            self.layer.masksToBounds = YES;
            
            [self addSubview:self.progressView];
        } else if (pageControlType == PageControlTypeSystem) {
            self.pageControl = [self createPageControlCount:pageCount frame:CGRectMake(0, self.height - 14, SCREEN_WIDTH, 16)];
            [self addSubview:self.pageControl];
        }
    }
    return self;
}

- (UIPageControl *)createPageControlCount:(NSInteger)pageCount frame:(CGRect)frame {
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.frame = frame;
    pageControl.numberOfPages = pageCount;
    pageControl.pageIndicatorTintColor = self.pageStyle.normalColor;
    pageControl.currentPageIndicatorTintColor = self.pageStyle.selectedColor;
    pageControl.userInteractionEnabled = YES;
    pageControl.hidesForSinglePage = YES;
    return pageControl;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
