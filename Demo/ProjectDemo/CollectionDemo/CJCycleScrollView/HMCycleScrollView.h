//
//  HMCycleScrollView.h
//  Demo
//
//  Created by ChenJie on 2018/1/26.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMCustomPageView.h"
#import "NSTimer+Add.h"

@interface HMCycleScrollView : UIView

@property (nonatomic, strong) NSArray <NSString *> *imageArray;

/** pageConrol 类型，默认 PageControlTypeCustom 类型 */
@property (nonatomic, assign) PageControlType pageControlType;
/** pageConrol 位置，默认 PageControlPositionCenter 类型 */
@property (nonatomic, assign) PageControlPosition pageControlPosition;
/** 当点击的时候，执行的block */
@property (nonatomic , copy) void (^tapActionBlock)(NSInteger pageIndex);
/** 滚动停止的时候，执行的block */
@property (nonatomic , copy) void (^scrollDidEndBlock)(NSInteger pageIndex);
/** 定时器 */
@property(nonatomic,strong) NSTimer *timer;
/** 是否设置悼念日灰色 imageView 默认：NO */
@property (nonatomic, assign) BOOL grayImageView;

/**
 @brief 循环滚动 banner 可设置是否循环轮播、自动轮播时间
 @param frame                                  scrollViewFrame
 @param radius                                图片圆角
 @param repeats                             是否循环轮播（默认：NO）
 @param autoScrollDuration     自动滚动间隔，传 0 则不自动轮播
 @return HMCycleScrollView
 */
+ (instancetype)cycleScrollViewFrame:(CGRect)frame radius:(CGFloat)radius repeats:(BOOL)repeats autoScrollDuration:(NSTimeInterval)autoScrollDuration;

/**
 @brief 循环滚动 banner 可设置是否循环轮播、自动轮播时间
 @param frame                                  scrollViewFrame
 @param imageViewF                       imageViewFrame
 @param radius                                图片圆角
 @param repeats                             是否循环轮播（默认：NO）
 @param autoScrollDuration     自动滚动间隔，传 0 则不自动轮播
 @return HMCycleScrollView
 */
+ (instancetype)cycleScrollViewFrame:(CGRect)frame imageViewFrame:(CGRect)imageViewF radius:(CGFloat)radius repeats:(BOOL)repeats autoScrollDuration:(NSTimeInterval)autoScrollDuration;

/**
 @brief 循环滚动 banner 可设置是否循环轮播、自动轮播时间
 @param frame                                  scrollViewFrame
 @param imageViewF                       imageViewFrame
 @param radius                                图片圆角
 @param repeats                             是否循环轮播（默认：NO）
 @param autoScrollDuration     自动滚动间隔，传 0 则不自动轮播
 @return HMCycleScrollView
 */
- (instancetype)initWithFrame:(CGRect)frame imageViewFrame:(CGRect)imageViewF radius:(CGFloat)radius repeats:(BOOL)repeats autoScrollDuration:(NSTimeInterval)autoScrollDuration;

@end
