//
//  ViewController.m
//  MyTestDemo
//
//  Created by zhaosheng on 2018/8/7.
//  Copyright © 2018年 zs. All rights reserved.
//

#import "ViewController.h"
#import "RunLoopViewController.h"
#import "InstanceTypeVC.h"
#import "VarableStructVC.h"
#import "AutoreleaseVC.h"
#import "GCDDemoVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    @weakify(self)
    [self addMenu:@"RunLoopDemo" callback:^(id sender, id data) {
        @strongify(self)
        [self runloopDemo];
    }];
    
    [self addMenu:@"VariableStruct" subTitle:@"可变结构体" callback:^(id sender, id data) {
        @strongify(self)
        [self variableStructDemo];
    }];
    
    [self addMenu:@"InstanceType" subTitle:@"instanceType、id、__kindof" callback:^(id sender, id data) {
        @strongify(self)
        [self instanceTypeDemo];
    }];
    
    [self addMenu:@"Autorelease对象释放" callback:^(id sender, id data) {
        @strongify(self)
        [self autoreleaseDemo];
    }];
    
    [self addMenu:@"GCD测试" callback:^(id sender, id data) {
        @strongify(self)
        [self gcdDemo];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)runloopDemo
{
    RunLoopViewController *vc = [RunLoopViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)variableStructDemo
{
    VarableStructVC *vc = [VarableStructVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)instanceTypeDemo
{
    InstanceTypeVC *vc = [InstanceTypeVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)autoreleaseDemo
{
    AutoreleaseVC *vc = [AutoreleaseVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gcdDemo
{
    GCDDemoVC *vc = [GCDDemoVC new];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
