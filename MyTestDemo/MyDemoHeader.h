//
//  MyDemoHeader.h
//  MyTestDemo
//
//  Created by zhaosheng on 2018/8/7.
//  Copyright © 2018年 zs. All rights reserved.
//

#ifndef MyDemoHeader_h
#define MyDemoHeader_h

#ifndef weakify
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#endif

#ifndef strongify
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#endif

#endif /* MyDemoHeader_h */
