//
//  Test.h
//  InstancetypeTest
//
//  Created by zhaosheng on 2018/8/1.
//  Copyright © 2018年 zs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Test : NSObject

@property (nonatomic, copy) NSString *name;

+(id)factoryMethodA;

+(instancetype)factoryMethodB;

+ (NSArray *)testSubViews;

- (NSArray *)testContents;

@end
