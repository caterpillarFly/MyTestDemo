//
//  ViewController.m
//  MyTestDemo
//
//  Created by zhaosheng on 2018/8/7.
//  Copyright © 2018年 zs. All rights reserved.
//

#import "ViewController.h"
#import "RunLoopShareTestDemoVC.h"
#import "RunLoopViewController.h"
#import "InstanceTypeVC.h"
#import "VarableStructVC.h"
#import "AutoreleaseVC.h"
#import "GCDDemoVC.h"
#import "GenericsVC.h"
#import "EncryptVC.h"
#import "ZSDownloadVC.h"
#import "ZSHtmlToRichTextVC.h"
#import "ZSNextResponsderVC.h"

#import "QNUploadManager.h"

#include "file1.h"

#import <ReactiveCocoa.h>

@interface ViewController ()

@property (nonatomic) NSInteger testCount;

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
    
    [self addMenu:@"Static函数" callback:^(id sender, id data) {
        @strongify(self)
        [self staticFunction];
    }];
    
    [self addMenu:@"泛型测试" callback:^(id sender, id data) {
        @strongify(self)
        [self genericTest];
    }];
    
    [self addMenu:@"七牛上传测试" callback:^(id sender, id data) {
        @strongify(self)
        [self qiniuUpload];
    }];
    
    [self addMenu:@"加密" callback:^(id sender, id data) {
        @strongify(self)
        [self gotoEncryptVC];
    }];
    
    [self addMenu:@"文件下载" callback:^(id sender, id data) {
        @strongify(self)
        [self gotoDownloadVC];
    }];
    
    [self addMenu:@"html转富文本" callback:^(id sender, id data) {
        @strongify(self)
        [self gotoHtmlToRichTextVC];
    }];
    
    [self addMenu:@"事件响应链" callback:^(id sender, id data) {
        @strongify(self)
        [self gotoNextResponsderVC];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    @weakify(self)
    [[RACObserve(self, testCount) takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self)
        NSLog(@"......testCount=%ld.........", self.testCount);
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    ++self.testCount;
}

- (void)runloopDemo
{
    RunLoopShareTestDemoVC *vc = [RunLoopShareTestDemoVC new];
    //RunLoopViewController *vc = [RunLoopViewController new];
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

- (void)staticFunction
{
    printStr1();
}

- (void)genericTest
{
    GenericsVC *vc = [GenericsVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)qiniuUpload
{
    NSString *token = @"XnBwUFvn_KFwSqVzkZkm4XmYj0S2rt7wStBPFzlr:63UMkWAIqJJLr_q0rKK5PYlMBnM=:eyJzY29wZSI6InRhc2tvdmVyc2VydmVyIiwiZGVhZGxpbmUiOjE1NDIwMDQ3NDN9";
    //NSString *token;
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    UIImage *qntest = [UIImage imageNamed:@"qntest.jpg"];
    NSData *data = UIImageJPEGRepresentation(qntest, 1.0);
    [upManager putData:data
                   key:@"image12345"
                 token:token
              complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                  NSLog(@"%@", info);
                  NSLog(@"%@", resp);
              } option:nil];
}

- (void)gotoEncryptVC
{
    EncryptVC *vc = [[EncryptVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoDownloadVC
{
    ZSDownloadVC *vc = [ZSDownloadVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoHtmlToRichTextVC
{
    ZSHtmlToRichTextVC *vc = [ZSHtmlToRichTextVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoNextResponsderVC
{
    ZSNextResponsderVC *vc = [ZSNextResponsderVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
