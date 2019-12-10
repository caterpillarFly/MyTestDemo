//
//  MyTestButton.m
//  MyTestDemo
//
//  Created by zhaosheng on 2019/12/3.
//  Copyright © 2019 zs. All rights reserved.
//

#import "MyTestButton.h"

@implementation MyTestButton

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    [super sendAction:@selector(handleAction:) to:self forEvent:event];
    //[super sendAction:action to:target forEvent:event];
}

- (void)handleAction:(id)sender
{
    NSLog(@"handle Action");
}

- (void)dealloc
{
    NSLog(@"dealloc:%@", self);
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitTestView = [super hitTest:point withEvent:event];
    return hitTestView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan..............");
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesEnded..............");
    [super touchesCancelled:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesEnded..............");
    [super touchesEnded:touches withEvent:event];
}

@end
