//
//  HMCycleScrollView.h
//  Demo
//
//  Created by ChenJie on 2018/1/26.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSTimer+Add.h"

@interface HMCycleScrollView : UIView

/**
 * 当点击的时候，执行的block
 */
@property (nonatomic , copy) void (^TapActionBlock)(NSInteger pageIndex);

/**
 * 滚动停止的时候，执行的block
 */
@property (nonatomic , copy) void (^ScrollActionBlock)(NSInteger pageIndex);

/**
 *  定时器
 */
@property(nonatomic,strong) NSTimer *timer;

/**
 @brief 循环滚动 banner
 @param scrollViewF                     scrollViewF
 @param imagePaths                       需要展示图片地址数组
 */
+ (instancetype)atzucheCycleScrollViewFrame:(CGRect)scrollViewF imagePaths:(NSArray<NSString *> *)imagePaths;

/**
 @brief 循环滚动 banner
 @param scrollViewF                     scrollViewF
 @param imagePaths                       需要展示图片地址数组
 @param animationDuration       自动滚动间隔
 */
+ (instancetype)atzucheCycleScrollViewFrame:(CGRect)scrollViewF imagePaths:(NSArray<NSString *> *)imagePaths animationDuration:(NSTimeInterval)animationDuration;

/**
 @brief 循环滚动 banner
 @param scrollViewF                     scrollViewF
 @param imageViewF                       imageViewF
 @param radius                                图片圆角
 @param imagePaths                       需要展示图片地址数组
 @param animationDuration       自动滚动间隔
 @return UIview
 */
+ (instancetype)atzucheCycleScrollViewFrame:(CGRect)scrollViewF imageViewFrame:(CGRect)imageViewF radius:(CGFloat)radius imagePaths:(NSArray *)imagePaths animationDuration:(NSTimeInterval)animationDuration;

/**
 @brief 循环滚动 banner
 @param frame                                  scrollViewF
 @param imageViewF                       imageViewF
 @param radius                                图片圆角
 @param imagePaths                       需要展示图片地址数组
 @param animationDuration       自动滚动间隔
 @return UIview
 */
- (instancetype)initWithFrame:(CGRect)frame imageViewFrame:(CGRect)imageViewF radius:(CGFloat)radius imagePaths:(NSArray *)imagePaths animationDuration:(NSTimeInterval)animationDuration;

@end
