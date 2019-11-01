//
//  SPBaseLoadingView.m
//  ShopMobile
//
//  Created by chenxiaojie on 2018/12/13.
//  Copyright © 2018年 soubao. All rights reserved.
//

#import "BaseLoadingView.h"
#import <Lottie/Lottie.h>
#import "UIImage+GIF.h"

#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height
#define LOADINGWIDTH    60
#define LOADINGWIDTH_GIF    80

@interface BaseLoadingView ()

//@property (strong, nonatomic) UIView *whiteBgView;
@property (strong, nonatomic) UIImageView *whiteIV;
@property (strong, nonatomic) LOTAnimationView *animationView;

@end

@implementation BaseLoadingView

//- (UIView *)whiteBgView {
//    if (_whiteBgView == nil) {
//        _whiteBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LOADINGWIDTH, LOADINGWIDTH)];
//        _whiteBgView.center = self.center;
//        _whiteBgView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0];
//        _whiteBgView.layer.cornerRadius = LOADINGWIDTH/2.0;
//        _whiteBgView.layer.masksToBounds = YES;
//    }
//    return _whiteBgView;
//}

- (UIImageView *)whiteIV {
    if (_whiteIV == nil) {
        _whiteIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, LOADINGWIDTH + 20, LOADINGWIDTH + 20)];
        _whiteIV.center = self.center;
        _whiteIV.image = [UIImage imageNamed:@"public_base_loading_bg"];
        _whiteIV.userInteractionEnabled = YES;
    }
    return _whiteIV;
}

- (LOTAnimationView *)animationView {
    if (_animationView == nil) {
        _animationView = [LOTAnimationView animationNamed:@"loading"];
        _animationView.loopAnimation = YES;
        _animationView.frame = CGRectMake(0, 0, LOADINGWIDTH, LOADINGWIDTH);
        //_animationView.size = CGSizeMake(LOADINGWIDTH, LOADINGWIDTH);
        _animationView.center = self.center;
    }
    return _animationView;
}

+ (instancetype)showLoading {
    return [[self alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0];
        
        //[self addSubview:self.whiteBgView];
//        [self addSubview:self.whiteIV];
//        [self addSubview:self.animationView];
//        [self.animationView playWithCompletion:^(BOOL animationFinished) {
//            //[self removeFromSuperview];
//        }];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"loading" ofType:@"gif"];
        NSData *gifData = [NSData dataWithContentsOfFile:path];
        UIImageView *sdImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - LOADINGWIDTH_GIF)/2.0, (SCREEN_HEIGHT - LOADINGWIDTH_GIF)/2.0, LOADINGWIDTH_GIF, LOADINGWIDTH_GIF)];
        sdImageView.image = [UIImage sd_imageWithGIFData:gifData];
        [self addSubview:sdImageView];
        
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        
    }
    return self;
}

+ (void)hiddenLoading {
    BaseLoadingView *loadingView = [self loadingView];
    if (loadingView != nil) {
        [loadingView removeLoadingSubViews];
    }
}

+ (BaseLoadingView *)loadingView {
    NSEnumerator *subviewsEnum = [[UIApplication sharedApplication].keyWindow.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            BaseLoadingView *loadingView = (BaseLoadingView *)subview;
            return loadingView;
        }
    }
    return nil;
}

- (void)removeLoadingSubViews {
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
