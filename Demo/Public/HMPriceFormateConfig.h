//
//  HMPriceFormateConfig.h
//  LYHM
//
//  Created by chenxiaojie on 2020/4/2.
//  Copyright © 2022 chenxiaojie. All rights reserved.
//

#ifndef HMPriceFormateConfig_h
#define HMPriceFormateConfig_h

//#define RMB(priceStr)                   [NSString stringWithFormat:@"￥%.2f", priceStr.floatValue]
#define RMB_Attr(priceStr) \
({NSMutableAttributedString *priceAttr = [[NSMutableAttributedString alloc] init];\
priceAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@", priceStr]];\
[priceAttr addAttribute:NSKernAttributeName value:@(-2) range:NSMakeRange(0, 1)];\
(priceAttr);})
// 整数价格只显示整数，小数价格保留两位有效数字
#define FormatFloat(float) \
({NSString *price = @"";\
if (fmodf(float, 1)==0) {\
price = [NSString stringWithFormat:@"%.0f", float];\
}\
else if (fmodf(float*10, 1)==0) {\
price = [NSString stringWithFormat:@"%.1f", float];\
}\
else {\
price = [NSString stringWithFormat:@"%.2f", float];\
}\
(price);})

#define SHARE(priceStr)                 [NSString stringWithFormat:@"分享赚￥%@", priceStr]
#define SHARENO(priceStr)               [NSString stringWithFormat:@"分享赚%@", RMB(priceStr)]
#define PriceFormate(priceStr)          [NSString stringWithFormat:@"%.2f", priceStr.floatValue]
#define PV(productPV)                   [NSString stringWithFormat:@"积分:%.2f", productPV.floatValue]
#define DISCOUNT(priceStr)              [NSString stringWithFormat:@"省%@", priceStr]

#endif /* HMPriceFormateConfig_h */
