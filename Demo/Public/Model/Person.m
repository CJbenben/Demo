//
//  Person.m
//  Demo
//
//  Created by ChenJie on 2017/11/2.
//  Copyright © 2017年 ChenJie. All rights reserved.
//

#import "Person.h"

@implementation Person

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    Person *person = [Person allocWithZone:zone];
    return person;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    Person *person = [[Person alloc] init];
    [person mutableCopyWithZone:zone];
    return person;
}

@end
