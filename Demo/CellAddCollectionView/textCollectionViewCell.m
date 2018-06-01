//
//  textCollectionViewCell.m
//  Demo
//
//  Created by ChenJie on 2018/6/1.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "textCollectionViewCell.h"

@interface textCollectionViewCell ()
@property(nonatomic,strong)UIImageView *imageView;

@end

@implementation textCollectionViewCell
-(instancetype)initWithFrame:(CGRect)fram{
    if (self = [super initWithFrame:fram]) {
        self.imageView  = [[UIImageView alloc]init];
        self.backgroundView = self.imageView;
        self.imageView.image = [UIImage imageNamed:@"a"];
    }
    return self;
}

-(void)setImageName:(NSString *)imageName{
    _imageName  = imageName;
    //self.imageView.image = [UIImage imageNamed:_imageName];
    self.imageView.backgroundColor = [UIColor cyanColor];
}
@end
