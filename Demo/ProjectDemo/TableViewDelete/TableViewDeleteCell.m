//
//  TableViewDeleteCell.m
//  Demo
//
//  Created by ChenJie on 2018/6/8.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "TableViewDeleteCell.h"

@implementation TableViewDeleteCell

- (UIView *)carInfoView {
    if (_carInfoView == nil) {
        _carInfoView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 60)];
        _carInfoView.backgroundColor = [UIColor cyanColor];
    }
    return _carInfoView;
}

- (UIButton *)deleteBtn {
    if (_deleteBtn == nil) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        _deleteBtn.frame = CGRectMake(SCREEN_WIDTH, 10, 55, 60);
        _deleteBtn.backgroundColor = RGBCOLOR(255, 60, 47);
        [_deleteBtn addTarget:self action:@selector(deleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.contentView.backgroundColor = RGBCOLOR(150, 150, 150);
        //[self.contentView removeFromSuperview];
        
        //[self addSubview:self.deleteBtn];
        [self addSubview:self.carInfoView];
        
        
        UISwipeGestureRecognizer *swipegr = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipegr:)];
        swipegr.direction = UISwipeGestureRecognizerDirectionLeft;
        //[self addGestureRecognizer:swipegr];
        
    }
    return self;
}

- (void)willTransitionToState:(UITableViewCellStateMask)state
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //[self setupSlideBtn];
    });
}
// 设置左滑菜单按钮的样式
- (void)setupSlideBtn
{
    if (@available(iOS 11.0, *)) {
        
    } else {
        
        for (UIView *subView in self.subviews) {
            if(![subView isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")]) {
                continue;
            }
            
            // 删除
            UIView *deleteContentView = subView.subviews[0];
            [self setupRowActionView:deleteContentView imageName:@"1111"];
            
//            // 修改备注
//            UIView *remarkContentView = subView.subviews[1];
//            [self setupRowActionView:remarkContentView imageName:@"left_slide_modify_note2"];
        }
    }
}

// 设置背景图片
- (void)setupRowActionView:(UIView *)rowActionView imageName:(NSString *)imageName
{
    rowActionView.backgroundColor = [UIColor cyanColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [rowActionView insertSubview:imageView atIndex:0];
    
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(rowActionView);
        make.width.equalTo(@180);
    }];
    
    
    CGRect actionFrame = rowActionView.frame;
    actionFrame.origin.x -= 50;
    actionFrame.size.width += 50;
    rowActionView.frame = actionFrame;

//    [rowActionView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(@180);
//    }];
    
//    [rowActionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.bottom.equalTo(rowActionView);
//        make.width.equalTo(@180);
//    }];
    
}

- (void)deleteBtnAction:(UIButton *)sender {
    CGRect cellFrame = self.frame;
    cellFrame.origin.x -= 50;
    self.frame = cellFrame;
    
    CGRect deleteBtnFrame = self.deleteBtn.frame;
    deleteBtnFrame.size.width += 50;
    self.deleteBtn.frame = deleteBtnFrame;
}

- (void)swipegr:(UIGestureRecognizer *)gr {
    
    CGRect carInfoViewFrame = self.carInfoView.frame;
    
    if (carInfoViewFrame.origin.x > 0) {
        
        carInfoViewFrame.origin.x -= 50;
        
        [UIView animateWithDuration:0.3 animations:^{
            self.carInfoView.frame = carInfoViewFrame;
        }];
        
    }

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
