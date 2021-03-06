//
//  ZJCustomLabel.h
//  ZJScrollPageView
//
//  Created by jasnig on 16/5/6.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJSegmentStyle.h"
@interface ZJTitleView : UIView
@property (assign, nonatomic) CGFloat currentTransformSx;

@property (assign, nonatomic) TitleImagePosition imagePosition;

@property (strong, nonatomic) NSString *text;
@property (nonatomic, strong) NSString *detail;
@property (strong, nonatomic) UIColor *textColor;
@property (strong, nonatomic) UIFont *font;
@property (strong, nonatomic) UIFont *detailFont;
@property (strong, nonatomic) UIColor *detailColor;
/** title 与 detail 之间边距 默认 0 */
@property (assign, nonatomic) CGFloat padding;
@property (assign, nonatomic, getter=isSelected) BOOL selected;
/** 代理方法中推荐只设置下面的属性, 当然上面的属性设置也会有效, 不过建议上面的设置在style里面设置 */
@property (strong, nonatomic) UIImage *normalImage;
@property (strong, nonatomic) UIImage *selectedImage;

@property (strong, nonatomic, readonly) UIImageView *imageView;
@property (strong, nonatomic, readonly) UILabel *label;
@property (strong, nonatomic, readonly) UILabel *detailL;
- (CGSize)titleViewSize;
- (CGSize)detailViewSize;
- (void)adjustSubviewFrame;
@end
