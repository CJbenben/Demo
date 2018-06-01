//
//  AtItemTableViewCell.h
//  Demo
//
//  Created by ChenJie on 2018/6/1.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AtItemCollectionView.h"

@interface AtItemTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *topPromptV;
@property (nonatomic, strong) AtItemCollectionView *itemCollectionView;

@property (strong, nonatomic) NSArray *homeCityAry;

@end
