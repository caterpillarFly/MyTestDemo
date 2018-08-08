//
//  VarableStructVC.m
//  MyTestDemo
//
//  Created by zhaosheng on 2018/8/7.
//  Copyright © 2018年 zs. All rights reserved.
//

#import "VarableStructVC.h"

typedef struct MyData
{
    int nLen;
    char data[0];
}MyData;

@interface VarableStructVC ()

@property (nonatomic) UILabel *contentLabel;
@property (nonatomic) NSString *structData;
@property (nonatomic) NSString *content;

@end

@implementation VarableStructVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.contentLabel];
    self.structData = @"typedef struct MyData\n{\n       int nLen;\n      char data[0];\n}MyData\n\n";
    self.content = varableTest();
    self.contentLabel.text = self.structData;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSString *data = [self.structData stringByAppendingString:self.content];
    self.contentLabel.text = data;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = [UIColor blackColor];
    }
    return _contentLabel;
}

NSString *varableTest()
{
    printf("Hello, World!\n");
    
    char str[10] = "123456789";
    
    printf("Size of MyData: %lu\n", sizeof(MyData));
    
    MyData *myData = (MyData*)malloc(sizeof(MyData) + 10);
    memcpy(myData->data,  str, 10);
    
    printf("Size of myData: %lu\n", sizeof(myData));
    printf("myData's Data is: %s\n", myData->data);
    
    free(myData);
    
    MyData t;
    int x1 = (unsigned int)(void*)&t.nLen;
    int x2 = (unsigned int)(void*)&t.data;
    //int x3 = (unsigned int)(void*)&t.c - (unsigned int)(void*)&t;
    //int x4 = (unsigned int)(void*)&t.d - (unsigned int)(void*)&t;
    //int x5 = (unsigned int)(void*)&t.e - (unsigned int)(void*)&t;
    printf("nlen=%p\ndata=%p", x1, x2);
    
    NSString *content = [NSString stringWithFormat:@"Size of MyData: %lu,\n Size of myData: %lu,\n myData's Data is: %@,\n nlen=%p\ndata=%p", sizeof(MyData), sizeof(myData), @"123456789", x1, x2];
    return content;
}

@end
