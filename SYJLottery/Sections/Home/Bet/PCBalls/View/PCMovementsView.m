//
//  PCMovementsView.m
//  longzhicai
//
//  Created by lili on 2017/4/8.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import "PCMovementsView.h"
#define COLLECTWITH      40     //网格视图的宽
#define COLLECTHIGHT     20     //网格视图的高

@interface PCMovementsView ()
{
    UILabel               *_lbrecently;     //最近几期的走势
    UISegmentedControl    *_segment;
    UIView                *_seleview;       //选择view
    NSMutableArray        *_buttonarray;
    
    NSArray               *_Noarray;        //号码数组
    UIView                *_dataview;       //书据展示view
    NSArray               *_titelarray;     //
    
}

@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIView *whiteview;
@property(nonatomic,strong) UIButton*btblack;

@end

@implementation PCMovementsView

-(id)initWithRightdistance:(int)rightdistance{
    
    self = [super initWithFrame:CGRectMake(0, 0, MSW, MSH)];
    if (self) {
        
        self.Rightdistance=rightdistance;
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
    lbtitle.text=@"走势";
    lbtitle.font = [UIFont systemFontOfSize:20];
    [_whiteview addSubview:lbtitle];
    
    _lbrecently = [[UILabel alloc] initWithFrame:CGRectMake(lbtitle.left,lbtitle.bottom, 200, 20)];
    _lbrecently.textColor =BlackTitleColor;
    _lbrecently.text=@"最近十二期开奖走势";
    _lbrecently.font = [UIFont systemFontOfSize:16];
    [_whiteview addSubview:_lbrecently];
    
    _seleview=[[UIView alloc]initWithFrame:CGRectMake(10, _lbrecently.bottom+40,MSW-_Rightdistance-20,  IPhone4_5_6_6P(30, 30, 35, 35))];
    _seleview.layer.cornerRadius = 2;
    _seleview.layer.masksToBounds = YES;
    _seleview.backgroundColor=[UIColor whiteColor];
    [_whiteview addSubview:_seleview];
    _buttonarray= [NSMutableArray array];
    
    _dataview=[[UIView alloc]initWithFrame:CGRectMake(10, _seleview.bottom+30, _seleview.width, MSH-_seleview.bottom-40)];
    
    _dataview.backgroundColor=[UIColor clearColor];
    [_whiteview addSubview:_dataview];
    
    _titelarray = [NSArray arrayWithObjects:@"号码",@"混合",nil];
    for(int i = 0; i < _titelarray.count; i++)
    {
        UIButton *btselete = [[UIButton alloc] init];
        btselete.frame = CGRectMake(i*_seleview.width/_titelarray.count, 0, _seleview.width/_titelarray.count, _seleview.height);
        if (i==0) {
            btselete.backgroundColor=RedColor;
            [btselete setTitleColor:[UIColor whiteColor] forState:0];
        }else{
            btselete.backgroundColor=[UIColor whiteColor];
            [btselete setTitleColor:BlackTitleColor forState:0];
        }
        [btselete setTitle:[_titelarray objectAtIndex:i] forState:0];
        btselete.tag=i;
        btselete.titleLabel.font=[UIFont systemFontOfSize:13];
        [_seleview addSubview:btselete];
        [_buttonarray addObject:btselete];
        [btselete addTarget:self action:@selector(seleteviewclickwithbutton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    [self Switchingperformancedatawithtype:[NSString stringWithFormat:@"0"]];
    
}


-(void)Switchingperformancedatawithtype:(NSString *)type{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:type forKey:@"type"];//[必选]类型 0=号码 1混合
    [[HttpManager manager] requestGetURL:HTTP_bjLu28_trend withParams:dict withTarget:self withHud:YES withSuccessBlock:^(id responseObject) {
        DLog(@"-----= %@", responseObject)
        
        [self setviewlayoutwitharray:responseObject[@"data"][@"items"]andtype:type];
        
        
    } withFailureBlock:^(NSError *error) {
        //        [self presentSheet:@"网络异常"];
    }];
    
}

-(void)setviewlayoutwitharray:(NSArray*)array andtype:(NSString*)type{
    
    
    
    [_dataview removeAllSubviews];
    NSArray*titlearr=[array objectAtIndex:0];
    CGFloat W = _seleview.width/titlearr.count;
    CGFloat H = IPhone4_5_6_6P(20, 20, 23, 23);
    
    for (int i = 0; i<array.count; i++) {
        NSArray*numarr=[array objectAtIndex:i];
        for (int j = 0; j<numarr.count; j++) {
            UILabel*lable = [[UILabel alloc]initWithFrame:CGRectIntegral(CGRectMake((W)*j,i* H, W+1, H))];
            lable.lineBreakMode = NSLineBreakByTruncatingHead;
          lable.backgroundColor=[UIColor whiteColor];
            lable.text=[numarr objectAtIndex:j];
            if ([lable.text isEqualToString:@"大"]||[lable.text isEqualToString:@"双"]||[lable.text isEqualToString:@"龙"]||[lable.text isEqualToString:@"红波"]) {
                lable.textColor=RedColor;
            }else if ([lable.text isEqualToString:@"小"]||[lable.text isEqualToString:@"单"]||[lable.text isEqualToString:@"虎"]||[lable.text isEqualToString:@"绿波"]){
                lable.textColor=GreenColor;
                
            }else if ([lable.text isEqualToString:@"蓝波"]){
                lable.textColor=BlueColor;
            }else{
                lable.textColor= BlackTitleColor;
            }

            if (i%2==0) {
                lable.backgroundColor=[UIColor whiteColor];
            }else{
                lable.backgroundColor=RGBCOLOR(255, 251, 251);
                
            }
            lable.textAlignment = NSTextAlignmentCenter;
            lable.font=[UIFont systemFontOfSize:MiddleFont];
            [_dataview addSubview:lable];
        }
    }
    
    
}







-(void)seleteviewclickwithbutton:(UIButton*)button{
    
    for (UIButton * _button in _buttonarray) {
        _button.backgroundColor=[UIColor whiteColor];
        [_button setTitleColor:BlackTitleColor forState:0];
    }
    button.backgroundColor=RedColor;
    [button setTitleColor:[UIColor whiteColor] forState:0];
    [self Switchingperformancedatawithtype:[NSString stringWithFormat:@"%li",button.tag]];
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


@end
