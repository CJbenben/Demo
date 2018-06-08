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
        _deleteBtn.frame = CGRectMake(SCREEN_WIDTH - 20 - 55, 10, 55, 60);
        _deleteBtn.backgroundColor = RGBCOLOR(255, 60, 47);
    }
    return _deleteBtn;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.contentView.backgroundColor = RGBCOLOR(150, 150, 150);
        //[self.contentView removeFromSuperview];
        
        [self addSubview:self.deleteBtn];
        [self addSubview:self.carInfoView];
        
        
        UISwipeGestureRecognizer *swipegr = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipegr:)];
        swipegr.direction = UISwipeGestureRecognizerDirectionLeft;
        //[self addGestureRecognizer:swipegr];
        
    }
    return self;
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
