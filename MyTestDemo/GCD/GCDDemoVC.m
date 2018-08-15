//
//  GCDDemoVC.m
//  MyTestDemo
//
//  Created by zhaosheng on 2018/8/9.
//  Copyright © 2018年 zs. All rights reserved.
//

/*
 -------------------------------------------------------------|
 |区别 | 并发队列                 | 串行队列                      |
 ------------------------------ |-----------------------------|
 |同步 | 没有开启新线程，串行执行任务 | 没有开启新线程，串行执行任务     |
 |——— |-------------------------|-----------------------------|
 |异步 | 有开启新线程，并发执行任务   | 有开启新线程(1条)，串行执行任务  |
 -------------------------------------------------------------|
 */

#import "GCDDemoVC.h"

@interface GCDDemoVC ()

@end

@implementation GCDDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self)
    [self addMenu:@"同步-并发队列" callback:^(id sender, id data) {
        @strongify(self)
        [self syncConcurrent];
//        [self asyncConcurrent];
    }];
    
    [self addMenu:@"异步-并发队列" callback:^(id sender, id data) {
        @strongify(self)
        [self asyncConcurrent];
    }];
    
    [self addMenu:@"同步-串行队列" callback:^(id sender, id data) {
        @strongify(self)
        [self syncSerial];
    }];
    
    [self addMenu:@"异步-串行队列" callback:^(id sender, id data) {
        @strongify(self)
        [self asyncSerial];
    }];
    
    //栅栏方法，还可用于读写锁
    [self addMenu:@"dispatch_barrier_async" callback:^(id sender, id data) {
        @strongify(self)
        [self asyncBarrier];
    }];
    
    [self addMenu:@"dispatch_barrier_sync" callback:^(id sender, id data) {
        @strongify(self)
        [self syncBarrier];
    }];
    
    [self addMenu:@"dispatch_apply" callback:^(id sender, id data) {
        @strongify(self)
        [self apply];
    }];
    
    [self addMenu:@"dispatch_group_notify" callback:^(id sender, id data) {
        @strongify(self)
        [self groupNotify];
    }];
    
    [self addMenu:@"dispatch_group_wait" callback:^(id sender, id data) {
        @strongify(self)
        [self groupWait];
    }];
    
    [self addMenu:@"dispatch_group_enter(leave)" callback:^(id sender, id data) {
        @strongify(self)
        [self groupEnterAndLeave];
    }];
    
    [self addMenu:@"dispatch_semaphore" callback:^(id sender, id data) {
        @strongify(self)
        [self semaphoreSync];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 同步执行 + 并发队列
 * 特点：在当前线程中执行任务，不会开启新线程，执行完一个任务，再执行下一个任务。
 */
- (void)syncConcurrent
{
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"syncConcurrent---begin");
    
    dispatch_queue_t queue = dispatch_queue_create("com.mydemo.testQueue", DISPATCH_QUEUE_CONCURRENT);
    
    NSLog(@"syncConcurrent---befor1");
    dispatch_sync(queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    NSLog(@"syncConcurrent---befor2");
    dispatch_sync(queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    NSLog(@"syncConcurrent---end");
}

/**
 * 异步执行 + 并发队列
 * 特点：可以开启多个线程，任务交替（同时）执行。
 */
- (void)asyncConcurrent {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"asyncConcurrent---begin");
    
    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_CONCURRENT);
    
    NSLog(@"syncConcurrent---befor1");
    dispatch_async(queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    NSLog(@"syncConcurrent---befor2");
    dispatch_async(queue, ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    NSLog(@"asyncConcurrent---end");
}

/**
 * 同步执行 + 串行队列
 * 特点：不会开启新线程，在当前线程执行任务。任务是串行的，执行完一个任务，再执行下一个任务。
 */
- (void)syncSerial
{
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"syncSerial---begin");
    
    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    dispatch_sync(queue, ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    NSLog(@"syncSerial---end");
}

/**
 * 异步执行 + 串行队列
 * 特点：会开启新线程，但是因为任务是串行的，执行完一个任务，再执行下一个任务。
 */
- (void)asyncSerial
{
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"asyncSerial---begin");
    
    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    dispatch_async(queue, ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    NSLog(@"asyncSerial---end");
}

/**
 * 栅栏方法 dispatch_barrier_async
 */
- (void)asyncBarrier
{
    [self barrierWithType:1];
}

//栅栏方法 dispatch_barrier_sync
- (void)syncBarrier
{
    [self barrierWithType:0];
}

- (void)barrierWithType:(NSInteger)type
{
    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    dispatch_async(queue, ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    if (type == 0) {
        dispatch_barrier_sync(queue, ^{
            // 追加任务 barrier
            for (int i = 0; i < 2; ++i) {
                [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
                NSLog(@"barrier---%@",[NSThread currentThread]);// 打印当前线程
            }
        });
    }
    else{
        dispatch_barrier_async(queue, ^{
            // 追加任务 barrier
            NSLog(@"in-barrier-begin");
            dispatch_barrier_sync(queue, ^{
                for (int i = 0; i < 2; ++i) {
                    [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
                    NSLog(@"barrier---%@",[NSThread currentThread]);// 打印当前线程
                }
            });
            NSLog(@"in-barrier-end");
        });
    }
    
    NSLog(@"bbbbbbbbbbb");
    
    dispatch_async(queue, ^{
        // 追加任务3
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
}

/**
 * 快速迭代方法 dispatch_apply
 */
- (void)apply
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    NSLog(@"apply---begin");
    dispatch_apply(6, queue, ^(size_t index) {
        NSLog(@"%zd---%@",index, [NSThread currentThread]);
    });
    NSLog(@"apply---end");
}

/**
 * 队列组 dispatch_group_notify
 */
- (void)groupNotify
{
    [self groupWaitOrNotifiy:0];
}

/**
 * 队列组 dispatch_group_wait
 */
- (void)groupWait
{
    [self groupWaitOrNotifiy:1];
}

- (void)groupWaitOrNotifiy:(NSInteger)type
{
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"group---begin");
    
    dispatch_group_t group =  dispatch_group_create();
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    if (type == 0) {
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            // 等前面的异步任务1、任务2都执行完毕后，回到主线程执行下边任务
            for (int i = 0; i < 2; ++i) {
                [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
                NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
            }
            NSLog(@"group---end");
        });
    }
    else{
        // 等待上面的任务全部完成后，会往下继续执行（会阻塞当前线程）
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
        }
        NSLog(@"group---end");
    }
    NSLog(@"group---finish");
}

/**
 * 队列组 dispatch_group_enter、dispatch_group_leave
 */
- (void)groupEnterAndLeave
{
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"group---begin");
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        }
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 等前面的异步操作都执行完毕后，回到主线程.
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
        }
        NSLog(@"group---end");
    });
    NSLog(@"group---finish");
}

/**
 * semaphore 线程同步
 */
- (void)semaphoreSync
{
    NSLog(@"currentThread---%@", [NSThread currentThread]);  // 打印当前线程
    NSLog(@"semaphore---begin");
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    __block int number = 0;
    dispatch_async(queue, ^{
        // 追加任务1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        
        number = 100;
        
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"semaphore---end,number = %d",number);
}

@end
