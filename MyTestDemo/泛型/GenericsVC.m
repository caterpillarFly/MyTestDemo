//
//  GenericsVC.m
//  MyTestDemo
//
//  Created by zhaosheng on 2018/9/1.
//  Copyright © 2018年 zs. All rights reserved.
//

#import "GenericsVC.h"
#import "Fruit.h"

int globalCount = 100;

void (^block)() = ^{
    globalCount -= 1;
    NSLog(@"Block A");
};

@interface GenericsVC ()

@property (nonatomic, copy) NSString *testName;
@property (nonatomic) NSInteger count;

@end

@implementation GenericsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableArray<Apple *> *apples = [NSMutableArray array];
    
    self.testName = @"张三";
    self.count = 10;
    
    [apples addObject:[Apple new]];
    [apples addObject:[Apple new]];
    
    [self printFruits:apples];
    [self testBlock];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)printFruits:(NSArray<__kindof Fruit *> *)fruits
{
    //[fruits addObject:[Orange new]];
    for (Fruit *fruit in fruits) {
        NSLog(@"fruit:%@", fruit);
    }
}

- (void)testBlock
{
    NSLog(@"before block:");
    NSLog(@"testName:%@, count:%ld, globalCount:%d", self.testName, self.count, globalCount);
    
    Apple *apple = [[Apple alloc] init];
    apple.name = @"苹果";
    
    void (^someBlock)() = ^(){
        self.testName = @"李四";
        self.count = 8;
        globalCount = 80;
        apple.name = @"橘子";
    };
    
    someBlock();
    block();
    
    NSLog(@"===========================");
    NSLog(@"after block:");
    NSLog(@"testName:%@, count:%ld, globalCount:%d", self.testName, self.count, globalCount);
    NSLog(@"fruit name: %@", apple.name);
    
    BOOL flag = YES;
    
    void (^block)();
    if (flag) {
        block = ^{
            NSLog(@"Block A");
        };
    }
    else{
        block = ^{
            NSLog(@"Block B");
        };
    }
    block();
}


@end
