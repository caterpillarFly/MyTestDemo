//
//  file1.c
//  MyTestDemo
//
//  Created by zhaosheng on 2018/8/20.
//  Copyright © 2018年 zs. All rights reserved.
//

#include "file1.h"

void printStr1()
{
    int normal = 0;
    static int stat = 0;        //this is a static local var
    printf("normal = %d ---- stat = %d\n",normal, stat);
    normal++;
    stat++;
}
