//
//  HMRefreshNormalHeader.m
//  Demo
//
//  Created by ChenJie on 2018/4/16.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "HMRefreshNormalHeader.h"
//#import "TXCommonKit.h"

@implementation HMRefreshNormalHeader

- (void)prepare
{
    [super prepare];

    // 设置控件的高度
    //self.mj_h += IS_IPHONE_X ? 24:0;
    self.mj_h += ([UIScreen mainScreen].bounds.size.height >= 812.0 ? 24 : 0);
    
}

// 修改 subview 偏移 y 值
- (void)placeSubviews
{
    [super placeSubviews];
    
    if (self.stateLabel.hidden) return;
    
    BOOL noConstrainsOnStatusLabel = self.stateLabel.constraints.count == 0;
    
    //CGFloat iphonexPadding = IS_IPHONE_X ? 24:0;
    CGFloat iphonexPadding = ([UIScreen mainScreen].bounds.size.height >= 812.0 ? 24 : 0);
    
    if (self.lastUpdatedTimeLabel.hidden) {
        // 状态
        //if (noConstrainsOnStatusLabel) self.stateLabel.frame = self.bounds;
        
        if (noConstrainsOnStatusLabel) {
            CGRect frame = self.bounds;
            self.stateLabel.frame = CGRectMake(frame.origin.x, frame.origin.y + iphonexPadding, frame.size.width, frame.size.height - iphonexPadding);
        }
    } else {
        CGFloat stateLabelH = (self.mj_h - iphonexPadding) * 0.5;
        // 状态
        if (noConstrainsOnStatusLabel) {
            self.stateLabel.mj_x = 0;
            self.stateLabel.mj_y = iphonexPadding;
            self.stateLabel.mj_w = self.mj_w;
            self.stateLabel.mj_h = stateLabelH;
        }
        
        // 更新时间
        if (self.lastUpdatedTimeLabel.constraints.count == 0) {
            self.lastUpdatedTimeLabel.mj_x = 0;
            self.lastUpdatedTimeLabel.mj_y = stateLabelH + iphonexPadding;
            self.lastUpdatedTimeLabel.mj_w = self.mj_w;
            self.lastUpdatedTimeLabel.mj_h = self.mj_h - self.lastUpdatedTimeLabel.mj_y;
        }
        
        self.lastUpdatedTimeLabel.hidden = YES;
    }
    
    // 箭头的中心点
    CGFloat arrowCenterX = self.mj_w * 0.5;
    if (!self.stateLabel.hidden) {
        CGFloat stateWidth = self.stateLabel.mj_textWidth;
        CGFloat timeWidth = 0.0;
        if (!self.lastUpdatedTimeLabel.hidden) {
            timeWidth = self.lastUpdatedTimeLabel.mj_textWidth;
        }
        CGFloat textWidth = MAX(stateWidth, timeWidth);
        arrowCenterX -= textWidth / 2 + self.labelLeftInset;
    }
    CGFloat arrowCenterY = (self.mj_h - iphonexPadding) * 0.5;
    CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY + iphonexPadding);
    
    // 箭头
    if (self.arrowView.constraints.count == 0) {
        self.arrowView.mj_size = self.arrowView.image.size;
        self.arrowView.center = arrowCenter;
    }
    
    // 只为了获取indicatorview（superview 未公开）
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UIActivityIndicatorView class]]) {
            // 圈圈
            if (subView.constraints.count == 0) {
                subView.center = arrowCenter;
            }

        }
    }
    
    self.arrowView.tintColor = self.stateLabel.textColor;
}

@end
