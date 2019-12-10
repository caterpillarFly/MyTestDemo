//
//  RunLoopShareTestDemoVC.m
//  MyTestDemo
//
//  Created by zhaosheng on 2019/7/18.
//  Copyright © 2019 zs. All rights reserved.
//

#import "RunLoopShareTestDemoVC.h"
#import "MyThread.h"
#import "Test.h"

@interface RunLoopShareTestDemoVC ()

@property (nonatomic) MyThread *subThread;

@end

@implementation RunLoopShareTestDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self subthreadWithSelector:@selector(runLoopSubthreadToDo)];
    //[self runLoopSubthreadToDo2];
    [self subthreadWithSelector:@selector(subThreadTodo)];
}

- (void)subthreadWithSelector:(SEL)selector
{
    NSLog(@"%@----开辟子线程", [NSThread currentThread]);
    MyThread *tmpThread = [[MyThread alloc] initWithTarget:self
                                                  selector:selector
                                                    object:nil];
    tmpThread.name = @"subThread";
    [tmpThread start];
    
    self.subThread = tmpThread;
}

- (void)runLoopSubthreadToDo2
{
    @weakify(self)
    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        @strongify(self)
        [self timerWantTodo];
    }];
}

- (void)runLoopSubthreadToDo
{
    NSLog(@"%@----开始执行子线程任务", [NSThread currentThread]);
    Test *test = [Test factoryMethodB];
    test.name = @"子线程RunLoop对象";
    
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    //[runLoop addPort:[NSMachPort port] forMode:NSRunLoopCommonModes];
    NSTimer *timer = [NSTimer timerWithTimeInterval:2
                                             target:self
                                           selector:@selector(timerWantTodo)
                                           userInfo:nil
                                            repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
    //[runLoop run];
    [runLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:10]];
    NSLog(@"behind runloop........");
}

- (void)timerWantTodo
{
    NSLog(@"%@----开始执行定时任务", [NSThread currentThread]);
}

- (void)subThreadTodo
{
    NSLog(@"%@----开始执行子线程任务",[NSThread currentThread]);
    
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:2
                                             target:self
                                           selector:@selector(timerWantTodo)
                                           userInfo:nil
                                            repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    [runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    NSLog(@"%@----执行子线程任务结束",[NSThread currentThread]);
}

//我们希望放在子线程中执行的任务
- (void)wantTodo{
    //断点2
    NSLog(@"当前线程:%@执行任务处理数据", [NSThread currentThread]);
}


//屏幕点击事件
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event{
    //断点1
    //在子线程中去响应wantTodo方法
    [self performSelector:@selector(wantTodo) onThread:self.subThread withObject:nil waitUntilDone:NO];
}

@end
