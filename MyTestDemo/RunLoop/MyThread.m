//
//  MyThread.m
//  MyTestDemo
//
//  Created by zhaosheng on 2018/8/7.
//  Copyright © 2018年 zs. All rights reserved.
//

#import "MyThread.h"

@implementation MyThread

- (void)dealloc
{
    NSLog(@"........... %@ 子线程被释放了..........", self.name);
}

@end
