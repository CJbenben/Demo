//
//  HMConst.h
//  LYHM
//
//  Created by chenxiaojie on 2019/10/10.
//  Copyright © 2019 chenxiaojie. All rights reserved.
//

#ifndef HMConst_h
#define HMConst_h

//测试环境
#ifdef kDevTest

#define k_QUESTION_PAGEID               @"99"

//生产环境
#elif kReleaseH

#define k_QUESTION_PAGEID               @"232"

#endif

// 隐藏 h5 导航
#define hidden_h5_navi                  @"client=5"

#define ShopMaxCount                    999  // 商品购买最大数量

#define main_redColor                   [UIColor colorWithHexString:@"F03642"]
#define PlaceHolder_Rectangle_Image     [UIImage imageNamed:@"ic_publick_placeholder_rectangle"]
#define PlaceHolder_Square_Image        [UIImage imageNamed:@"ic_publick_placeholder_square"]
#define PlaceHolder_Header_Image        [UIImage imageNamed:@"icon_public_default_header"]
#define kAlertViewDefaultTitle          [[NSAttributedString alloc] initWithString:@"温馨提示"]

#define kBannerHeight                   360
#define kBannerHeightHome               280
#define SafeAreaBottomHeight            (SCREEN_HEIGHT >= 812.0 ? 34 : 0)
#define SafeAreaTopSpace                (SCREEN_HEIGHT >= 812.0 ? 24 : 0)
/**
 字体适配比例
 */
#define TXAdaptiveRate(x) ((float) x * SCREEN_WIDTH / 375.0)

// source 大统一
#define kShopSourceNormal               @"0"    // 常规商品
#define kShopSourcePoint                @"point"// 积分商品
#define kShopSourceOnLineStore          @"shop" // 线上店铺自提商品
#define kShopSourceZitong               @"199"  // 紫铜专区商品
#define kShopSource2997                 @"2997" // 2997 商品
//#define kShopSourceHanCC                @"11"   // 汉草臣商品
#define kShopSourceOffLineStore         @"12"   // 线下店铺自提商品
#define kShopSourceStorePurchase        @"13"   // 店铺进货商品
#define kShopSourceStoreTurn            @"14"   // 店铺周转商品
#define kShopSourceFirstBerth           @"15"   // 店铺首次铺货商品
#define kShopSourceVirtual              @"16"   // 虚拟商品
#define kShopSourceVIP                  @"17"   // 会籍费商品
#define kShopSource20                   @"20"   // 充值300商品
#define kShopSource22                   @"22"   // 生日礼包
#define kShopSource23                   @"23"   // 满赠礼包
#define kShopSource24                   @"24"   // 新人活动商品
#define kShopSource25                   @"25"   // 新人礼包
#define kShopSource26                   @"26"   // 店铺首次选购
#define kShopSource27                   @"27"   //
#define kShopSource28                   @"28"   //
#define kShopSource29                   @"29"   // 砍价商品

#define kIsShopSourceStore(source)  \
({BOOL isStoreSource = NO;\
if ([source isEqualToString:kShopSourceOnLineStore] || [source isEqualToString:kShopSourceOffLineStore] || [source isEqualToString:kShopSourceStorePurchase]) {\
isStoreSource = YES;\
}\
(isStoreSource);})
#define kIsShopSourceGift(source)  \
({BOOL isGiftSource = NO;\
if ([source isEqualToString:kShopSourceVIP] || [source isEqualToString:kShopSource22] || [source isEqualToString:kShopSource23] || [source isEqualToString:kShopSource25] || [source isEqualToString:kShopSource29]) {\
isGiftSource = YES;\
}\
(isGiftSource);})
#define kIsShowBottomCartView(source)  \
({BOOL isBottomCartSource = NO;\
if ([source isEqualToString:kShopSource24] || [source isEqualToString:kShopSource26] || [source isEqualToString:kShopSource27] || [source isEqualToString:kShopSource28]) {\
isBottomCartSource = YES;\
}\
(isBottomCartSource);})

// universal link
#define UNIVERSAL_LINK                  @"https://com.szgreenleaf/"
#define UNIVERSAL_LINK_VX               @"https://47f0005.umindex.com/"
#define UNIVERSAL_LINK_VX2              @"https://lv-img.oss-cn-hangzhou.aliyuncs.com/appdemo/"
#define UNIVERSAL_LINK_QQ               @"https://lv-img.oss-cn-hangzhou.aliyuncs.com/qq_conn/1109906228"

#define kAppStoreVersion                @"AppStoreVersion"
//@"客服后台开通的客服ID"
#define IM_CUSTOMER_ID_ALL              @"famall"

#define IM_RemoteNotification           @"kIMRemoteNotification"
// 刷新模板配置页面
#define kRefreshHMFlexibleUI            @"refreshFlexibleListVC"
// 在线客服未读消息数（原小红点）
#define kIsShowOnlineRedDto             @"isShowOnlineRedDto"
//// 互动消息未读消息数（原小红点）
//#define kIsShowIMlistRedDto             @"isShowIMlistRedDto"
// 系统消息未读消息数（原小红点）
#define kSystemMsgRedDtoCount           @"systemMsgRedDtoCount"
// 公告消息未读消息数（原小红点）
#define kAnnouncementMsgRedDtoCount     @"announcementMsgRedDtoCount"
// 公告消息未读消息数（原小红点）
#define kStoreMsgRedDtoCount            @"storeMsgRedDtoCount"

#define KIsHiddenSpecialAreaAlert       @"isHiddenSpecialAreaAlert"
// 小白升级紫铜猫弹框
#define KIsHiddenBasicUpgradeAlert      @"isHiddenBasicUpgradeAlert"

// 店铺进货实时更新商品在购物车数量
#define kRealTimeUpdateCount            @"realTimeUpdateCount"

// 新人福利实时更新商品在购物车数量
#define kUpdateActivityPageCount        @"updateActivityPageCount"
// 新人福利更新底部按钮UI
//#define kUpdateActivityPageBottonUI     @"updateActivityPageBottonUI"
// 新人福利刷新 tab 下面的商品列表数据
#define kRefreshTabShopListData         @"refreshTabShopListData"

// 回调请求数据
#define kCallBackRequestData            @"callBackRequestData"

#define kStringReplace                  @"haomaoproviders"
// 商品详情 banner 放大图是否显示分享二维码按钮
#define kIsHiddenShareBtn                 @"isHiddenShareBtn"
// token过期,失效通知
#define kNotificationTokenExpire        @"notificationTokenExpire"
// 刷新 viewController 页面 refreshData
#define kNotificationRefreshData        @"notificationRefreshData"
// 刷新可配置页面
#define kRefreshFlexibleVCData          @"refreshFlexibleVCData"

#endif /* HMConst_h */
