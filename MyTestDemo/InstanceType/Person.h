//
//  Person.h
//  InstancetypeTest
//
//  Created by zhaosheng on 2018/8/1.
//  Copyright © 2018年 zs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person<__covariant ObjectType> : NSObject

@property (nonatomic) ObjectType tmpobject;

+(id)factoryMethodA;

+(instancetype)factoryMethodB;

+ (NSString *)firstName;

@end
