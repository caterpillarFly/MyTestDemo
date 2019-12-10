//
//  EncryptVC.m
//  MyTestDemo
//
//  Created by zhaosheng on 2018/10/11.
//  Copyright © 2018年 zs. All rights reserved.
//

#import "EncryptVC.h"
#import "MGDesEncrypt.h"
#import "MGSafeHostURLManager.h"

static NSString *const MG_DES_KEY = @"jbXGHTytBAxFqleSbJ";

@implementation EncryptVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [MGSafeHostURLManager sharedManager];
    
    //NSLog(@"class:%@", NSStringFromClass(self.urlsDic.class));
}


@end
