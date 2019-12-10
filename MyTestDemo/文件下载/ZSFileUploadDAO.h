//
//  ZSFileUploadDAO.h
//  MyTestDemo
//
//  Created by zhaosheng on 2019/1/21.
//  Copyright © 2019 zs. All rights reserved.
//

#import "HNetworkDAO.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZSFileUploadDAO : HNetworkDAO

@property (nonatomic) NSInteger taskSetId;
@property (nonatomic) HNetworkMultiDataObj *file;

@end

NS_ASSUME_NONNULL_END
