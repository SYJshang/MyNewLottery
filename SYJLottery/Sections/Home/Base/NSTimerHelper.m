//
//  NSTimerHelper.m
//  PlanTo
//
//  Created by  zhang jian on 14-3-23.
//  Copyright (c) 2014年 DoubleCat. All rights reserved.
//
//  Edited by liwenzhi

#import "NSTimerHelper.h"

@interface NSTimerHelper()
{
    id __unsafe_unretained delegate_;
    SEL action_;
}

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, unsafe_unretained) id delegate;
@property (nonatomic, assign) SEL action;

@end

/*********************************************************************/

@implementation NSTimerHelper

@synthesize timer = timer_;
@synthesize delegate = delegate_;
@synthesize action = action_;

- (void)dealloc {
    [self invalidate];
    delegate_ = nil;
    action_ = nil;
}

+ (NSTimerHelper *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo
{
    NSTimerHelper *helper = [[NSTimerHelper alloc] init];
    
    [helper invalidate];
    
    helper.delegate = aTarget;
    helper.action = aSelector;
    
    helper.timer = [NSTimer scheduledTimerWithTimeInterval:ti target:helper selector:@selector(doSomething) userInfo:userInfo repeats:yesOrNo];
    
    return helper;
}

- (void)invalidate
{
    [timer_ invalidate];
    timer_ = nil;
}

- (void)doSomething
{
    if (self.delegate && [self.delegate respondsToSelector:self.action]) {
//        ([self.delegate performSelector:self.action]);
        
        //上面的方法会出现 ARC 警告
        /*
         原因：
         在ARC模式下，运行时需要知道如何处理你正在调用的方法的返回值。这个返回值可以是任意值，如 void , int , char , NSString , id 等等。ARC通过头文件的函数定义来得到这些信息。所以平时我们用到的静态选择器就不会出现这个警告。因为在编译期间，这些信息都已经确定。
         **/
        //使用函数指针的方式，避免上面的方法出现 ARC 警告
        IMP imp = [self.delegate methodForSelector:self.action];
        void (*func)(id, SEL) = (void *)imp;
        func(self.delegate, self.action);
        
        /*
         当有额外参数时，如
         
         SEL selector = NSSelectorFromString(@"processRegion:ofView:");
         IMP imp = [_controller methodForSelector:selector];
         CGRect (*func)(id, SEL, CGRect, UIView *) = (void *)imp;
         CGRect result = func(_controller, selector, someRect, someView);
         **/
    }
}

@end
