//
//  Person.h
//  Demo
//
//  Created by ChenJie on 2017/11/2.
//  Copyright © 2017年 ChenJie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Country.h"

@interface Person : NSObject//<NSCopying, NSMutableCopying>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, copy) Country * country;

@end
