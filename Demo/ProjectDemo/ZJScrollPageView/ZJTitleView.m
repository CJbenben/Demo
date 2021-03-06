//
//  ZJCustomLabel.m
//  ZJScrollPageView
//
//  Created by jasnig on 16/5/6.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJTitleView.h"
#import "UILabel+ZJTextAlign.h"

@interface ZJTitleView() {
    CGSize _titleSize;
    CGSize _detailSize;
    CGFloat _imageHeight;
    CGFloat _imageWidth;
    BOOL _isShowImage;
}
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UILabel *detailL;
@property (strong, nonatomic) UIView *contentView;
/** 后续添加 */
// TODO: - 添加badge
@property (nonatomic) UIView *badgeView;

@end

@implementation ZJTitleView
- (instancetype)init {
    self = [self initWithFrame:CGRectZero];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.currentTransformSx = 1.0;
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        _isShowImage = NO;
        [self addSubview:self.label];
        [self addSubview:self.detailL];
    }
    
    return self;
}

- (void)setCurrentTransformSx:(CGFloat)currentTransformSx {
    _currentTransformSx = currentTransformSx;
    self.transform = CGAffineTransformMakeScale(currentTransformSx, currentTransformSx);
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!_isShowImage) {
        if (_detail.length) {
            CGFloat x = (self.bounds.size.width - _titleSize.width) * 0.5;
            CGFloat y = (self.bounds.size.height - _titleSize.height - _detailSize.height - self.padding) * 0.5;
            self.label.frame = CGRectMake(x, y, _titleSize.width, _titleSize.height);
            self.label.isBottom = YES;
            
            x = (self.bounds.size.width - _detailSize.width) * 0.5;
            self.detailL.frame = CGRectMake(x, CGRectGetMaxY(self.label.frame) + self.padding, _detailSize.width, _detailSize.height);
            self.detailL.isTop = YES;
        } else {
            self.label.frame = self.bounds;
        }
    }
}

- (void)adjustSubviewFrame {
    _isShowImage = YES;

    CGRect contentViewFrame = self.bounds;
    contentViewFrame.size.width = [self titleViewSize].width;
    contentViewFrame.origin.x = (self.frame.size.width - contentViewFrame.size.width) * 0.5;
    self.contentView.frame = contentViewFrame;
    self.label.frame = self.contentView.bounds;
    
    [self addSubview:self.contentView];
    [self.label removeFromSuperview];
    [self.detailL removeFromSuperview];
    [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.detailL];
    [self.contentView addSubview:self.imageView];
    
    switch (self.imagePosition) {
        case TitleImagePositionTop: {
            CGRect contentViewFrame = self.contentView.frame;
            contentViewFrame.size.height = _imageHeight + _titleSize.height;
            contentViewFrame.origin.y = (self.frame.size.height - contentViewFrame.size.height)*0.5;
            self.contentView.frame = contentViewFrame;
            
            self.imageView.frame = CGRectMake(0, 0, _imageWidth, _imageHeight);
            CGPoint center = self.imageView.center;
            center.x = self.label.center.x;
            self.imageView.center = center;
            
            CGFloat labelHeight = self.contentView.frame.size.height - _imageHeight;
            CGRect labelFrame = self.label.frame;
            labelFrame.origin.y = _imageHeight;
            labelFrame.size.height = labelHeight;
            self.label.frame = labelFrame;
            break;
        }
        case TitleImagePositionLeft: {
            
            CGRect labelFrame = self.label.frame;
            labelFrame.origin.x = _imageWidth;
            labelFrame.size.width = self.contentView.frame.size.width - _imageWidth;
            self.label.frame = labelFrame;
            
            CGRect imageFrame = CGRectZero;
            imageFrame.size.height = _imageHeight;
            imageFrame.size.width = _imageWidth;
            imageFrame.origin.y = (self.contentView.frame.size.height - imageFrame.size.height)/2;
            self.imageView.frame = imageFrame;
            
            break;
        }
        case TitleImagePositionRight: {
            CGRect labelFrame = self.label.frame;
            labelFrame.size.width = self.contentView.frame.size.width - _imageWidth;
            self.label.frame = labelFrame;
            
            CGRect imageFrame = CGRectZero;
            imageFrame.origin.x = CGRectGetMaxX(self.label.frame);
            imageFrame.size.height = _imageHeight;
            imageFrame.size.width = _imageWidth;
            imageFrame.origin.y = (self.contentView.frame.size.height - imageFrame.size.height)/2;
            self.imageView.frame = imageFrame;
            break;
        }
        case TitleImagePositionCenter:
            
            self.imageView.frame = self.contentView.bounds;
            [self.label removeFromSuperview];
            break;
        default:
            break;
    }

}



- (CGSize)titleViewSize {
    CGFloat width = 0.0f;
    switch (self.imagePosition) {
        case TitleImagePositionLeft:
            width = _imageWidth + _titleSize.width;
            break;
        case TitleImagePositionRight:
            width = _imageWidth + _titleSize.width;
            break;
        case TitleImagePositionCenter:
            width = _imageWidth;
            break;
        default:
            width = _titleSize.width;
            break;
    }
    
    return CGSizeMake(width, _titleSize.height);
}

- (CGSize)detailViewSize {
    CGFloat width = 0.0f;
    switch (self.imagePosition) {
        case TitleImagePositionLeft:
            width = _imageWidth + _detailSize.width;
            break;
        case TitleImagePositionRight:
            width = _imageWidth + _detailSize.width;
            break;
        case TitleImagePositionCenter:
            width = _imageWidth;
            break;
        default:
            width = _detailSize.width;
            break;
    }
    
    return CGSizeMake(width, _detailSize.height);
}


- (void)setNormalImage:(UIImage *)normalImage {
    _normalImage = normalImage;
    _imageWidth = normalImage.size.width;
    _imageHeight = normalImage.size.height;
    self.imageView.image = normalImage;
}

- (void)setSelectedImage:(UIImage *)selectedImage {
    _selectedImage = selectedImage;
    self.imageView.highlightedImage = selectedImage;
}

- (void)setFont:(UIFont *)font {
    _font = font;
    self.label.font = font;
}

- (void)setDetailFont:(UIFont *)detailFont {
    _detailFont = detailFont;
    self.detailL.font = detailFont;
}

- (void)setText:(NSString *)text {
    _text = text;
    self.label.text = text;
    CGRect bounds = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.label.font} context:nil];
    _titleSize = bounds.size;

}

- (void)setDetail:(NSString *)detail {
    _detail = detail;
    self.detailL.text = detail;
    CGRect bounds = [detail boundingRectWithSize:CGSizeMake(MAXFLOAT, 0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.detailL.font} context:nil];
    _detailSize = bounds.size;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.label.textColor = textColor;
    
}

- (void)setDetailColor:(UIColor *)detailColor {
    _detailColor = detailColor;
    self.detailL.textColor = detailColor;
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    self.imageView.highlighted = selected;
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeCenter;
    }
    return _imageView;
}

- (UILabel *)label {
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

- (UILabel *)detailL {
    if (_detailL == nil) {
        _detailL = [[UILabel alloc] init];
        _detailL.textAlignment = NSTextAlignmentCenter;
    }
    return _detailL;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
    }
    return _contentView;
}



@end
