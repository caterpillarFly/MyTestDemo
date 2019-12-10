//
//  ZSFileUploadDAO.m
//  MyTestDemo
//
//  Created by zhaosheng on 2019/1/21.
//  Copyright © 2019 zs. All rights reserved.
//

#import "ZSFileUploadDAO.h"

@implementation ZSFileUploadDAO

- (instancetype)init
{
    if (self = [super init]) {
        self.baseURL = @"http://120.77.202.153/TaskOverServer/api/web/index.php?r=upload/upload-task-set";
        self.method = @"POST";
    }
    return self;
}

- (void)setupHeader:(NSMutableDictionary *)headers
{
    [super setupHeader:headers];
    headers[@"osVersion"] = @"11.0.3";
    headers[@"brand"] = @"iPhone";
    headers[@"platform"] = @"iOS";
    headers[@"userId"] = @"2";
    headers[@"appVersion"] = @"1.0";
}

@end
