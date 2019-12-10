//
//  AutoreleaseVC.m
//  MyTestDemo
//
//  Created by zhaosheng on 2018/8/8.
//  Copyright © 2018年 zs. All rights reserved.
//

#import "AutoreleaseVC.h"
#import "MyThread.h"
#import "Test.h"

@interface AutoreleaseVC ()

@property (nonatomic, weak) MyThread *subThread;
@property (nonatomic, weak) id testObject;

@end

@implementation AutoreleaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    @weakify(self)
    [self addMenu:@"主线程" callback:^(id sender, id data) {
        @strongify(self)
        [self mainThreadTest];
    }];
    
    [self addMenu:@"子线程" callback:^(id sender, id data) {
        @strongify(self)
        [self subthreadWithSelector:@selector(subthreadToDo)];
    }];
    
    [self addMenu:@"子线程带RunLoop" callback:^(id sender, id data) {
        @strongify(self)
        [self subthreadWithSelector:@selector(runLoopSubthreadToDo)];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mainThreadTest
{
    Test *test = [Test factoryMethodB];
    test.name = @"主线程对象";
    self.testObject = test;
}

- (void)subthreadWithSelector:(SEL)selector
{
    NSLog(@"%@----开辟子线程", [NSThread currentThread]);
    MyThread *tmpThread = [[MyThread alloc] initWithTarget:self
                                                  selector:selector
                                                    object:nil];
    tmpThread.name = @"subThread";
    [tmpThread start];
}

- (void)subthreadToDo
{
    NSLog(@"%@----开始执行子线程任务", [NSThread currentThread]);
    Test *test = [Test factoryMethodB];
    test.name = @"子线程对象";
    self.testObject = test;
}

- (void)runLoopSubthreadToDo
{
    NSLog(@"%@----开始执行子线程任务", [NSThread currentThread]);
    Test *test = [Test factoryMethodB];
    test.name = @"子线程RunLoop对象";
    self.testObject = test;
    
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addPort:[NSMachPort port] forMode:NSRunLoopCommonModes];
    NSTimer *timer = [NSTimer timerWithTimeInterval:2
                                             target:self
                                           selector:@selector(timerWantTodo)
                                           userInfo:nil
                                            repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    //[runLoop run];
    [runLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:10]];
    NSLog(@"behind runloop........");
}

- (void)timerWantTodo
{
    NSLog(@"%@----开始执行定时任务", [NSThread currentThread]);
    Test *test = [Test factoryMethodB];
    test.name = @"Timer对象";
    self.testObject = test;
}


@end
