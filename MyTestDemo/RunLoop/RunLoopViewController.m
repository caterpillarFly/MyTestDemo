//
//  RunLoopViewController.m
//  MyTestDemo
//
//  Created by zhaosheng on 2018/8/7.
//  Copyright © 2018年 zs. All rights reserved.
//

#import "RunLoopViewController.h"
#import "RunLoopChangeModeVC.h"
#import "MyThread.h"

@interface RunLoopViewController ()

@property (nonatomic, weak) MyThread *subThread;
@property (nonatomic) BOOL isPerformSelectorTest;
@property (nonatomic) UIView *tmpView;
@property (nonatomic) NSTimer *timer;

@end

@implementation RunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    @weakify(self)
    [self addMenu:@"DefaultMode" callback:^(id sender, id data) {
        @strongify(self)
        self.isPerformSelectorTest = NO;
        [self.tmpView removeFromSuperview];
        [self subthreadWithSelector:@selector(runDefaultMode)];
    }];
    
    [self addMenu:@"CommonMode" callback:^(id sender, id data) {
        @strongify(self)
        self.isPerformSelectorTest = NO;
        [self.tmpView removeFromSuperview];
        [self subthreadWithSelector:@selector(runCommonMode)];
    }];
    
    [self addMenu:@"UITrackingRunLoopMode" callback:^(id sender, id data) {
        @strongify(self)
        self.isPerformSelectorTest = NO;
        [self.tmpView removeFromSuperview];
        [self subthreadWithSelector:@selector(runTrackingMode)];
    }];
    
    [self addMenu:@"PerformSelector:onThread:"
         subTitle:@"PerformSelector:onThread:withObject:waitUntilDone:"
         callback:^(id sender, id data) {
             @strongify(self)
             self.isPerformSelectorTest = YES;
             [self.view addSubview:self.tmpView];
             if (!self.subThread) {
                 self.subThread = [self subthreadWithSelector:@selector(subthreadToDo)];
             }
         }];
    
    [self addMenu:@"主线程NSTimer" callback:^(id sender, id data) {
        @strongify(self)
        NSTimer *timer = [NSTimer timerWithTimeInterval:1
                                                 target:self
                                               selector:@selector(timerWantTodo)
                                               userInfo:nil
                                                repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        /*[NSTimer scheduledTimerWithTimeInterval:1
         target:self
         selector:@selector(timerWantTodo)
         userInfo:nil
         repeats:YES];*/
    }];
    
    [self addMenu:@"子线程NSTimer" callback:^(id sender, id data) {
        @strongify(self)
        [self subthreadWithSelector:@selector(createTimer)];
    }];
    
    [self addMenu:@"停止timer" callback:^(id sender, id data) {
        @strongify(self)
        [self.timer invalidate];
    }];
    
    [self addMenu:@"子线程切换Mode" callback:^(id sender, id data) {
        @strongify(self)
        [self changeMode];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeMode
{
    RunLoopChangeModeVC *vc = [[RunLoopChangeModeVC alloc] initWithNibName:@"RunLoopChangeModeVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)createTimer
{
    NSLog(@"%@----开始执行子线程任务", [NSThread currentThread]);
    
    self.timer = [NSTimer timerWithTimeInterval:1
                                         target:self
                                       selector:@selector(timerWantTodo)
                                       userInfo:nil
                                        repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
}

- (void)timerWantTodo
{
    NSString *name = [NSThread currentThread].name;
    if ([NSThread isMainThread]) {
        name = @"main";
    }
    NSLog(@"%@----开始执行子线程定时任务", name);
}

- (MyThread *)subthreadWithSelector:(SEL)selector
{
    NSLog(@"%@----开辟子线程", [NSThread currentThread]);
    MyThread *tmpThread = [[MyThread alloc] initWithTarget:self
                                                  selector:selector
                                                    object:nil];
    NSString *threadName = NSStringFromSelector(selector);
    tmpThread.name = threadName;
    [tmpThread start];
    return tmpThread;
}

- (void)subthreadToDo
{
    [self runSubThreadWithMode:NSDefaultRunLoopMode runType:2];
}

- (void)runDefaultMode
{
    [self runSubThreadWithMode:NSDefaultRunLoopMode];
}

- (void)runCommonMode
{
    [self runSubThreadWithMode:NSRunLoopCommonModes];
}

- (void)runTrackingMode
{
    [self runSubThreadWithMode:UITrackingRunLoopMode];
}

- (void)runSubThreadWithMode:(NSRunLoopMode)mode
{
    [self runSubThreadWithMode:mode runType:0];
}

- (void)runSubThreadWithMode:(NSRunLoopMode)mode runType:(NSInteger)type
{
    NSLog(@"%@----开始执行子线程任务", [NSThread currentThread].name);
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addPort:[NSMachPort port] forMode:mode];
    if (type == 0) {
        [runLoop run];
    }
    else if (type == 1){
        [runLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:10]];
    }
    else if (type == 2){
        [runLoop runMode:mode beforeDate:[NSDate distantFuture]];
    }
    NSLog(@"%@----执行子线程任务结束",[NSThread currentThread].name);
}

- (void)performSelectorWantToDo
{
    NSLog(@"当前线程:%@ 执行任务处理数据", [NSThread currentThread].name);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.isPerformSelectorTest) {
        [self performSelector:@selector(performSelectorWantToDo)
                     onThread:self.subThread
                   withObject:nil
                waitUntilDone:NO];
    }
    else{
        [super touchesBegan:touches withEvent:event];
    }
}

#pragma mark --Getter
- (UIView *)tmpView
{
    if (!_tmpView) {
        _tmpView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
        _tmpView.backgroundColor = [UIColor purpleColor];
        _tmpView.userInteractionEnabled = YES;
    }
    return _tmpView;
}

@end
