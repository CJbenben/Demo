//
//  AtItemTableViewCell.m
//  Demo
//
//  Created by ChenJie on 2018/6/1.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "AtItemTableViewCell.h"
#import "AtItemCollectionViewCell.h"

@interface AtItemTableViewCell()

@end

@implementation AtItemTableViewCell

- (UIView *)topPromptV {
    if (_topPromptV == nil) {
        _topPromptV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        _topPromptV.backgroundColor = [UIColor cyanColor];
    }
    return _topPromptV;
}

- (AtItemCollectionView *)itemCollectionView {
    if (_itemCollectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(SCREEN_WIDTH/3.0, 60);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        //layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _itemCollectionView = [[AtItemCollectionView alloc] initWithFrame:CGRectMake(0, self.topPromptV.bottom, SCREEN_WIDTH, 60 * 2) collectionViewLayout:layout];
        
    }
    return _itemCollectionView;
}

- (void)setHomeCityAry:(NSArray *)homeCityAry {
    _homeCityAry = homeCityAry;
    self.itemCollectionView.homeCityAry = homeCityAry;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.topPromptV];
        [self.contentView addSubview:self.itemCollectionView];
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
