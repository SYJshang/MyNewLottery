//
//  MovementsView.m
//  longzhicai
//
//  Created by lili on 2017/3/24.
//  Copyright © 2017年 wkw. All rights reserved.
//

#import "MovementsView.h"


#define COLLECTWITH      40     //网格视图的宽
#define COLLECTHIGHT     20     //网格视图的高

@interface MovementsView ()
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


@implementation MovementsView

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
    lbtitle.font = [UIFont systemFontOfSize:18];
    [_whiteview addSubview:lbtitle];

    _lbrecently = [[UILabel alloc] initWithFrame:CGRectMake(lbtitle.left,lbtitle.bottom, 200, 20)];
    _lbrecently.textColor =BlackTitleColor;
    _lbrecently.text=@"最近十二期开奖走势";
    _lbrecently.font = [UIFont systemFontOfSize:BigFont];
    [_whiteview addSubview:_lbrecently];
   
    _seleview=[[UIView alloc]initWithFrame:CGRectMake(10, _lbrecently.bottom+40,MSW-_Rightdistance-20, 25)];
    _seleview.layer.cornerRadius = 2;
    _seleview.layer.masksToBounds = YES;
    _seleview.backgroundColor=[UIColor whiteColor];
    [_whiteview addSubview:_seleview];
    _buttonarray= [NSMutableArray array];
    
    _dataview=[[UIView alloc]initWithFrame:CGRectMake(10, _seleview.bottom+30, _seleview.width, MSH-_seleview.bottom-40)];
    
    _dataview.backgroundColor=RedColor;
    [_whiteview addSubview:_dataview];
    
    
    
}

-(void)setBettype:(NSString *)bettype{
    if ([bettype isEqualToString:@"1"]) {//北京赛车
        _titelarray = [NSArray arrayWithObjects:@"号码",@"大小",@"单双",@"冠亚军和", @"1-5龙虎",nil];
        
    }else if ([bettype isEqualToString:@"2"]){
    
    
    }
    
    for(int i = 0; i < _titelarray.count; i++)
    {
        UIButton *btselete = [[UIButton alloc] init];
        btselete.frame = CGRectMake(i*_seleview.width/_titelarray.count, 0, _seleview.width/_titelarray.count, 25);
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
    [self Switchingperformancedatawithtype:@"0"];

}


-(void)Switchingperformancedatawithtype:(NSString *)type{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:type forKey:@"type"];//[必选]类型 0=号码 1=大小 2=单双 3=冠亚军和 4=1-5龙虎
    [[HttpManager manager] requestGetURL:HTTP_bjPk10_trend withParams:dict withTarget:self withHud:YES withSuccessBlock:^(id responseObject) {
        DLog(@"-----= %@", responseObject)
        
        [self setviewlayoutwitharray:responseObject[@"data"][@"items"]];
        
        
    } withFailureBlock:^(NSError *error) {
//        [self presentSheet:@"网络异常"];
    }];
    
}

-(void)setviewlayoutwitharray:(NSArray*)array{
    
    
    DLog(@"=-=-------- %@",array);
    
    [_dataview removeAllSubviews];
    _Noarray=@[@"期号",@"万",@"千",@"百",@"十",@"个",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2"];
    
    CGFloat W = _seleview.width/6;
    CGFloat H = 20;
    for (int i = 0; i<_Noarray.count; i++) {
        UILabel*lable = [[UILabel alloc]initWithFrame:CGRectMake((W)*(i%6),+(i/6) * H, W, H)];
        lable.backgroundColor=[UIColor whiteColor];
        lable.text=[_Noarray objectAtIndex:i];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font=[UIFont systemFontOfSize:MiddleFont];
        [_dataview addSubview:lable];
    }


}







-(void)seleteviewclickwithbutton:(UIButton*)button{
    
    for (UIButton * _button in _buttonarray) {
        _button.backgroundColor=[UIColor whiteColor];
        [_button setTitleColor:BlackTitleColor forState:0];
    }
    button.backgroundColor=RedColor;
    [button setTitleColor:[UIColor whiteColor] forState:0];
    [_dataview removeAllSubviews];
    
    [self Switchingperformancedatawithtype:[NSString stringWithFormat:@"%li",button.tag]];

    
    if (button.tag==100) {

    }else if (button.tag==101){
        DLog(@"大小");
    }else if (button.tag==102){
    
        DLog(@"-=-=----单双");
    }else{
    
        DLog(@"-=--   龙湖");
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





//备用代码
/*    if (button.tag==100) {
 DLog(@"走势");
 _Noarray=@[@"期号",@"万",@"千",@"百",@"十",@"个",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2"];
 
 CGFloat W = _seleview.width/6;
 CGFloat H = 20;
 for (int i = 0; i<_Noarray.count; i++) {
 UILabel*lable = [[UILabel alloc]initWithFrame:CGRectMake((W)*(i%6),(i/6) * H, W, H)];
 lable.backgroundColor=[UIColor whiteColor];
 lable.text=[_Noarray objectAtIndex:i];
 lable.textAlignment = NSTextAlignmentCenter;
 lable.font=[UIFont systemFontOfSize:MiddleFont];
 [_dataview addSubview:lable];
 }
 
 }else if (button.tag==101){
 _Noarray=@[@"期号",@"万",@"千",@"百",@"十",@"个",@"036",@"大",@"小",@"大",@"小",@"大",@"036",@"大",@"小",@"大",@"小",@"大",@"036",@"大",@"小",@"大",@"小",@"大",@"036",@"大",@"小",@"大",@"小",@"大",@"036",@"大",@"小",@"大",@"小",@"大",@"036",@"大",@"小",@"大",@"小",@"大",@"036",@"大",@"小",@"大",@"小",@"大",@"036",@"大",@"小",@"大",@"小",@"大",@"036",@"大",@"小",@"大",@"小",@"大",];
 
 CGFloat W = _seleview.width/6;
 CGFloat H = 20;
 for (int i = 0; i<_Noarray.count; i++) {
 UILabel*lable = [[UILabel alloc]initWithFrame:CGRectMake((W)*(i%6),(i/6) * H, W, H)];
 lable.backgroundColor=[UIColor whiteColor];
 lable.text=[_Noarray objectAtIndex:i];
 lable.textAlignment = NSTextAlignmentCenter;
 lable.font=[UIFont systemFontOfSize:MiddleFont];
 [_dataview addSubview:lable];
 NSString*str=[_Noarray objectAtIndex:i];
 if ([str isEqualToString:@"大"]) {
 lable.textColor=RedColor;
 }else if ([str isEqualToString:@"小"]){
 lable.textColor=[UIColor greenColor];
 }
 }
 
*/












//    _segment = [[UISegmentedControl alloc]initWithItems:array];
//    //根据内容定分段宽度
//    _segment.apportionsSegmentWidthsByContent = NO;
//    //控件渲染色(也就是外观字体颜色)
//    _segment.tintColor =RedColor;
//    _segment.frame = CGRectMake(10, _lbrecently.bottom+40,MSW-_Rightdistance-20, 30);
//    _segment.backgroundColor=[UIColor whiteColor];
//
//    [_segment addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
//    [_whiteview addSubview:_segment];
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"" size:BigFont],NSFontAttributeName ,nil];
//    [_segment setTitleTextAttributes:dic forState:UIControlStateNormal];
////
//    NSDictionary *dicselete = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"" size:BigFont],NSFontAttributeName ,nil];
//
//    [_segment setTitleTextAttributes:dicselete forState:UIControlStateSelected];//设置文字属性
//    _segment.layer.cornerRadius = 2;
//    _segment.layer.masksToBounds = YES;
//    _segment.selectedSegmentIndex = 0;//默认选中的按钮索引
//    _segment.hidden=YES;
//    _segment.layer.borderWidth = 2;
//      _segment.layer.borderColor = NavColor.CGColor;
//    [_segment setDividerImage:[UIImage imageNamed:@"bet_segmentation"] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//

@end
