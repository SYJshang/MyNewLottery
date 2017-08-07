//
//  WalkHorseView.m
//  longzhicai
//
//  Created by lili on 2017/3/23.
//  Copyright © 2017年 wkw. All rights reserved.
//

#import "WalkHorseView.h"

@implementation WalkHorseView
{
    UIScrollView * _scrollView;
    NSTimer * _timer;
    NSInteger _page;
    UIWindow * window;
}

#pragma mark - lifeCycle
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initialization];
        [self initScrollView];
    }
    return self;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initialization];
    [self initScrollView];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    /** 对使用walkHorseLightWithFrame初始化方法 进行单独定义 */
    if (_labelHeight == 0) _labelHeight = self.frame.size.height / _titleCount;
    if (_labelWidth == 0) _labelWidth = self.frame.size.width;
    
    _scrollView.frame = CGRectMake(0, 0, _labelWidth, _titleCount * _labelHeight);
    
    /** 添加七个label */
    for (NSInteger i = 0; i < _labelTitleArray.count; i ++) {
        
        UILabel * label = [[UILabel alloc]init];
        label.frame = CGRectMake(10, (i - 1) * _labelHeight, _labelWidth - 20, _labelHeight);
        label.tag = 100 + i;
        label.userInteractionEnabled = YES;
        label.text = _labelTitleArray[i];
//        label.textColor = _textColor;
        label.font = _textFont;
        label.backgroundColor=[UIColor whiteColor];
        [_scrollView addSubview:label];
        if (i%2==1) {
            label.textColor=_textColor;
        }else{
            label.textColor=_textColor2;
        }
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        [label addGestureRecognizer:tap];
    }
}
#pragma mark - initialization
-(void)initialization
{
//    _titleCount = 5;
    
    _labelHeight = self.frame.size.height / _titleCount;
    
    _labelWidth = self.frame.size.width;
    
    _textFont = [UIFont systemFontOfSize:12];
    
    _textColor = [UIColor grayColor];
}
+ (instancetype)walkHorseLightWithFrame:(CGRect)frame delegate:(id<WalkHorseViewDelegate>)delegate
{
    WalkHorseView * walkHorseLight = [[self alloc]initWithFrame:frame];
    walkHorseLight.delegate = delegate;
    
    return walkHorseLight;
}

+(instancetype)walkHorseLightWithFrame:(CGRect)frame titleStringsGroup:(NSArray *)titleStringsGroup
{
    WalkHorseView * walkHorseview = [[self alloc]initWithFrame:frame];
    walkHorseview.labelTitleArray = titleStringsGroup;
    
    return walkHorseview;
}
#pragma mark - initScrollView
-(void)initScrollView
{
    UIScrollView * scrollView = [[UIScrollView alloc]init];
    scrollView.delegate = self;
    scrollView.bounces = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:scrollView];
    _scrollView = scrollView;
}
#pragma mark - properties
-(void)setLabelTitleArray:(NSArray *)labelTitleArray
{
    if (labelTitleArray.count>0) {
        DLog(@"-=-=--%@",[labelTitleArray objectAtIndex:0]);

        _labelTitleArray = labelTitleArray;
        
        /** 设置scrollView属性 */
        _scrollView.scrollEnabled = labelTitleArray.count > 1 ? YES : NO;
        
        /** 开启定时器 */
        [self startTimer];

    }
}
-(void)setTitleCount:(NSInteger)titleCount
{
    _titleCount = titleCount;
    
    _page = _titleCount + 1;
}
#pragma mark - timer
-(void)startTimer
{
    [_timer invalidate];
    _timer = nil;
    
    _timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}
-(void)automaticScroll
{
    NSInteger  page = (_page + 1) % _labelTitleArray.count;
    
    _page = page;
    
    /** 遍历每一个label */
    for (UILabel * topLabel in _scrollView.subviews) {
        float top = topLabel.frame.origin.y;

//        DLog(@"-=-=   =====---%li    -----%@",page,_labelTitleArray[page])
        /** 拿出最上面的label 放到最下面 */
        if (-_labelHeight == top) {
            
            topLabel.frame = CGRectMake(10, _titleCount * _labelHeight, _labelWidth - 20, _labelHeight);
            topLabel.text = _labelTitleArray[page];
            
            if (page%2==1) {
                topLabel.textColor=_textColor;
            
            }else{
                topLabel.textColor=_textColor2;
            }
            
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            
            /** 将不是最上面的label向上移动_labelHeight高度 */
            if (-_labelHeight != top) {
                
                topLabel.frame = CGRectMake(10, topLabel.frame.origin.y - _labelHeight, _labelWidth - 20, _labelHeight);
            }
        } completion:^(BOOL finished) {
            
            /** 拉回scrollView */
            [_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        }];
    }
}
#pragma mark - clickEvent
-(void)tapClick:(UITapGestureRecognizer *)tap
{
    for (UILabel * label in _scrollView.subviews) {
        
        /** 通过tag值获取label */
        if (label.tag == tap.view.tag) {
            
            [self.delegate WalkHorseViewClick:label.text];
            
            if (_clickBlock) {
                
                _clickBlock(label.text);
            }
        }
    }
}


@end
