//
//  InstanceTypeVC.m
//  MyTestDemo
//
//  Created by zhaosheng on 2018/8/7.
//  Copyright © 2018年 zs. All rights reserved.
//

#import "InstanceTypeVC.h"
#import "Test.h"
#import "Person.h"

@interface InstanceTypeVC ()

@end

@implementation InstanceTypeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
     这里，没报错的原因是，编译器发现当前引入的文件中，有头文件暴露了testContents这个方法，
     并且编译器无法确定返回的id对象是否是支持这个方法的类型
     */
    id objA = [Person factoryMethodA];
    //[objA testContents];
    [objA testName];
    
    [[Test factoryMethodA] testContents];
    
    //id objB = [Person newPerson];
    //[objB subviews];
    
    //内存泄露测试
    id testObj = [Person performSelector:@selector(newObj) withObject:nil];
    NSLog(@"testObj:%@",testObj);
    testObj = nil;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"2");
        [self performSelectorOnMainThread:@selector(mainThreadMethod) withObject:nil waitUntilDone:YES];
        NSLog(@"3");
    });
    
    //Person *objB = [Person factoryMethodB];
    //[objB testContents];
    
    //[[Person newPerson] subviews];
    //NSLog(@"obj:%@", obj);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (__kindof NSArray *)tmpArray
{
    return [NSArray array];
}

- (void)mainThreadMethod
{
    NSLog(@"0");
    sleep(5);
    NSLog(@"1");
}

@end
