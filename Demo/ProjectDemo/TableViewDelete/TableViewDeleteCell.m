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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.contentView.backgroundColor = RGBCOLOR(150, 150, 150);

        [self addSubview:self.carInfoView];
        
    }
    return self;
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
