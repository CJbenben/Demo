//
//  HMGrayImageView.m
//  LYHM
//
//  Created by chenxiaojie on 2023/1/5.
//  Copyright © 2023 chenxiaojie. All rights reserved.
//

#import "HMGrayImageView.h"
#import "UIImage+TXGrayImage.h"

@implementation HMGrayImageView

- (void)setImage:(UIImage *)image {
    if (self.used) {
        super.image = [image grayImage];
    } else {
        super.image = image;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
