//
//  ZSHFrame.h
//  DP
//
//  Created by 笨笨编程 on 2017/7/5.
//  Copyright © 2017年 dp. All rights reserved.
//

#ifndef ZSHFrame_h
#define ZSHFrame_h

#endif /* ZSHFrame_h */

/* 获取设备的物理宽度 */
#define SCREEN_WIDTH            [UIScreen mainScreen].bounds.size.width
/* 获取设备的物理高度 */
#define SCREEN_HEIGHT           [UIScreen mainScreen].bounds.size.height
/* 获取设备的物理宽度一半 */
#define SCREEN_WIDTH_HALF       SCREEN_WIDTH/2.0
/* 获取设备的物理宽度四分之一 */
#define SCREEN_WIDTH_QUARTER    SCREEN_WIDTH/4.0


#define isIphoneX ({\
BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
    if (!UIEdgeInsetsEqualToEdgeInsets([UIApplication sharedApplication].delegate.window.safeAreaInsets, UIEdgeInsetsZero)) {\
    isPhoneX = YES;\
    }\
}\
isPhoneX;\
})

#define naviHeight              (isIphoneX ? 89 : 64)
#define iPadNaviHeight          80
