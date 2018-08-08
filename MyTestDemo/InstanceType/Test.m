//
//  Test.m
//  InstancetypeTest
//
//  Created by zhaosheng on 2018/8/1.
//  Copyright © 2018年 zs. All rights reserved.
//

#import "Test.h"

@interface Test ()

@property (nonatomic, copy) NSArray *contents;

@end

@implementation Test

+(id)factoryMethodA
{
    __autoreleasing Test *obj = [[self alloc] init];
    return obj;
}

+(instancetype)factoryMethodB
{
    __autoreleasing Test *obj = [[self alloc] init];
    return obj;
}

+ (__kindof Test *)factoryMethodC
{
    __autoreleasing Test *obj = [[self alloc] init];
    return obj;
}

+ (NSArray *)testSubViews
{
    NSArray *views = [[self factoryMethodB] contents];
    //NSArray *views = [self factoryMethodB].contents;
    //NSArray *views = [self factoryMethodC].contents;
    return views;
}

- (NSArray *)testContents
{
    return self.contents;
}

- (void)dealloc
{
    NSLog(@"%@ Test dealloced.........", _name);
}

@end
