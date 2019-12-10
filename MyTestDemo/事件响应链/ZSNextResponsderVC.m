//
//  ZSNextResponsderVC.m
//  MyTestDemo
//
//  Created by zhaosheng on 2019/12/3.
//  Copyright © 2019 zs. All rights reserved.
//

#import "ZSNextResponsderVC.h"
#import "MyTestButton.h"

@interface ZSNextResponsderVC ()

@property (nonatomic) UIButton *testButton;
@property (nonatomic) MyTestButton *myTestButton;

@end

@implementation ZSNextResponsderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.testButton];
    self.testButton.frame = CGRectMake(100, 200, 80, 40);
    
    [self.view addSubview:self.myTestButton];
    self.myTestButton.frame = CGRectMake(200, 200, 80, 40);
    
    [self.myTestButton sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (void)testButtonClicked:(UIButton *)sender
{
    NSLog(@"button clicked.......");
}

- (void)myTestButtonClicked:(UIButton *)sender
{
    NSLog(@"my test button clicked.......");
}

- (MyTestButton *)newButtonClicked:(UIButton *)sender
{
    MyTestButton *button = [MyTestButton new];
    return button;
}

- (void)handleTapGesture:(UITapGestureRecognizer *)ges
{
    NSLog(@"tapgesture clicked.......");
}

- (UIButton *)testButton
{
    if (!_testButton) {
        _testButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _testButton.backgroundColor = [UIColor yellowColor];
        [_testButton addTarget:self action:@selector(testButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        //tap.cancelsTouchesInView = NO;
        [self.view addGestureRecognizer:tap];
    }
    return _testButton;
}

- (MyTestButton *)myTestButton
{
    if (!_myTestButton) {
        _myTestButton = [MyTestButton buttonWithType:UIButtonTypeCustom];
        _myTestButton.backgroundColor = [UIColor blueColor];
        [_myTestButton addTarget:self action:@selector(newButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _myTestButton;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touch ......");
}

@end
