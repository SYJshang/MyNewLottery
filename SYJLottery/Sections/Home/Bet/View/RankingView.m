//
//  RankingView.m
//  longzhicai
//
//  Created by lili on 2017/3/28.
//  Copyright © 2017年 wkw. All rights reserved.
//

#import "RankingView.h"
@interface RankingView ()
{

    
    
}

@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIView *whiteview;
@property(nonatomic,strong) UIButton*btblack;

@end
@implementation RankingView
-(id)initWithRightdistance:(int)rightdistance{
    
    self = [super initWithFrame:CGRectMake(0, 0, MSW, MSH)];
    if (self) {
        
        self.Rightdistance=rightdistance;
        self.dataArray=[NSMutableArray array];
        [self createUI];
    }
    return self;
    
}

#pragma mark - 创建视图
- (void)createUI
{
    [self addSubview:self.bgView];
    [self addSubview:self.whiteview];
    self.bgView.hidden=YES;
    self.whiteview.hidden=YES;
    
    UILabel* lbtitle=[[UILabel alloc]initWithFrame:CGRectMake(10, 60, 90, 40)];
    lbtitle.textColor =BlackTitleColor;
    lbtitle.text=@"冷热排行";
    lbtitle.font = [UIFont systemFontOfSize:18];
    [_whiteview addSubview:lbtitle];
    
    
   
}

-(void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray=dataArray;
    
    CGFloat W = 80;
    CGFloat H = IPhone4_5_6_6P(20, 20, 23, 23);
    
    NSDictionary* style = @{@"body" :
                                @[
                                  [UIColor clearColor]],
                            @"u": @[RedColor,
                                    
                                    ]};

    for (int i = 0; i<_dataArray.count*2; i++) {
        RankingModel*model=[_dataArray objectAtIndex:i/2];
        UILabel*lable = [[UILabel alloc]initWithFrame:CGRectMake((W)*(i%2)+10,130 +(i/2) * H, W, H)];
        if (i%2==0) {
            lable.textColor=BlackTitleColor;
            lable.text=[NSString stringWithFormat:@"  %@",model.title];
        }else{
            lable.textColor=RedColor;
            lable.textAlignment = NSTextAlignmentRight;
//            lable.text=[NSString stringWithFormat:@"已连开%@期",model.num];
            lable.attributedText = [[NSString stringWithFormat:@"<u>已连开%@期</u>..",model.num] attributedStringWithStyleBook:style];

        }
        lable.backgroundColor=[UIColor whiteColor];
        lable.font=[UIFont systemFontOfSize:MiddleFont];
        [_whiteview addSubview:lable];
        
    }


}

-(UIView *)bgView
{
    if (!_bgView)
    {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
        _bgView.backgroundColor = [UIColor clearColor] ;
        _btblack=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
        _btblack.backgroundColor=[UIColor blackColor];
        [_bgView addSubview:_btblack];
        [_btblack addTarget:self action:@selector(hiddenView) forControlEvents:UIControlEventTouchUpInside];
        self.btblack.alpha=0.3;
        
    }
    return _bgView;
}

-(UIView *)whiteview
{
    if (!_whiteview)
    {
        _whiteview = [[UIView alloc]initWithFrame:CGRectMake(-MSW+_Rightdistance, 0, MSW-_Rightdistance, MSH)];
        _whiteview.backgroundColor=NavColor;
    }
    return _whiteview;
}


/**
 *   显示列表
 */
-(void)showView
{
    //    [self addSubview:self.bgView];
    //    [self addSubview:self.whiteview];
    self.bgView.hidden=NO;
    self.whiteview.hidden=NO;
    [UIView animateWithDuration:0.5f animations:^{
        self.bgView.alpha = 1;
        self.btblack.alpha=0.3;
        self.hidden=NO;
        self.whiteview.frame = CGRectMake(0, 0,MSW-_Rightdistance, MSH);
        
    }completion:^(BOOL finished) {
        
    }];
}
/**
 *  隐藏
 */
-(void)hiddenView
{
    
    [UIView animateWithDuration:0.5f animations:^{
        self.bgView.alpha = 0;
        self.btblack.alpha=0;
        self.whiteview.frame = CGRectMake(0, 0, -MSW+_Rightdistance, MSH);
        
    } completion:^(BOOL finished) {
        //        [_bgView removeFromSuperview];
        _bgView.hidden=YES;
        //        [self.delegate ShowSontrollerNavigationBar];
        self.hidden=YES;
        
        
    }];
}











/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
