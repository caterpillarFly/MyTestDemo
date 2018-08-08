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
    [objA testContents];
    
    //Person *objB = [Person factoryMethodB];
    //[objB testContents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (__kindof NSArray *)tmpArray
{
    return [NSArray array];
}

@end
