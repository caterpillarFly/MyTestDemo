//
//  Person.m
//  InstancetypeTest
//
//  Created by zhaosheng on 2018/8/1.
//  Copyright © 2018年 zs. All rights reserved.
//

#import "Person.h"

@implementation Person

+(id)factoryMethodA
{
    return [[self alloc] init];
}

+(instancetype)factoryMethodB
{
    return [[self alloc] init];
}

@end
