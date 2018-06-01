//
//  testTableViewCell.h
//  Demo
//
//  Created by ChenJie on 2018/6/1.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class testTableViewCell;
@protocol testTableViewCellDelegate <NSObject>

-(void)uodataTableViewCellHight:(testTableViewCell*)cell andHight:(CGFloat)hight andIndexPath:(NSIndexPath *)indexPath;
@end

@interface testTableViewCell : UITableViewCell
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,weak) id<testTableViewCellDelegate>deleget;
@property(nonatomic,strong)UILabel *lable;
@end

