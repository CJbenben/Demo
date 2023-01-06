//
//  HMCustomPageView.h
//  LYHM
//
//  Created by chenxiaojie on 2019/12/23.
//  Copyright © 2019 chenxiaojie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** pageControl 类型 */
typedef NS_ENUM(NSUInteger, PageControlType) {
    PageControlTypeCustom = 0,          // 自定义 pageControl
    PageControlTypeSystem,              // 系统 pageControl
    PageControlTypeNone                 // 不需要 pageControl
};

typedef NS_ENUM(NSUInteger, PageControlPosition) {
    /** Center position. */
    PageControlPositionCenter = 0,
    /** top position. */
    PageControlPositionTop,
    /** left position. */
    PageControlPositionLeft,
    /** bottom position. */
    PageControlPositionBottom,
    /** right position. */
    PageControlPositionRight,
    /** null position. */
    PageControlPositionNull,
};

@interface HMCustomPageStyle : NSObject
/** 未选中时颜色，默认 whiteColor */
@property (nonatomic, strong) UIColor *normalColor;
/** 已选中时颜色，默认 redColor */
@property (nonatomic, strong) UIColor *selectedColor;

@end

/** pageControl 使用类（支持系统 和 自定义） */
@interface HMCustomPageView : UIView

/** 小数点位置（自定义 pageControl 情况下可用） */
@property (assign, nonatomic) PageControlPosition pageControlPosition;

/** 当前页 为了更新进度 */
@property (nonatomic, assign) CGFloat progressIndex;

/**
 @brief 初始化进度条方法
 @param frame                               需要展示进度条frame，width、height、x 会在私有方法中重新计算
 @param pageControlType         pageControlType
*/
- (instancetype)initWithFrame:(CGRect)frame pageCount:(NSInteger)pageCount pageControlType:(PageControlType)pageControlType;

/**
 @brief 初始化进度条方法，支持设置自定义颜色
 @param frame                               需要展示进度条frame，width、height、x 会在私有方法中重新计算
 @param pageControlType         pageControlType
 @param pageStyle                      pageStyle
*/
- (instancetype)initWithFrame:(CGRect)frame pageCount:(NSInteger)pageCount pageControlType:(PageControlType)pageControlType pageStyle:(HMCustomPageStyle *)pageStyle;

@end

NS_ASSUME_NONNULL_END
