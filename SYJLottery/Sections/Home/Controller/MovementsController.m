//
//  MovementsController.m
//  longzhicai
//
//  Created by lili on 2017/4/11.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import "MovementsController.h"
#import "DropDownListView.h"
#import "XJTimeColorController.h"
#import "TJTimeColorController.h"
#import "HappyPokerController.h"

@interface MovementsController ()<DropDownViewDelegate>
{
    UIView                *_TopView;
    UIView                *_seleview;       //选择view
    NSArray               *_titelarray;     //
    NSMutableArray        *_buttonarray;
    NSString              *_movementsstr;    //走势接口
    NSArray               *_movenmentarray;     //


}
@property (nonatomic, strong) DropDownListView *list;
@property (nonatomic, strong) NSArray    *array;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIScrollView          *scrollview;            //主滑动视图
@property (nonatomic, strong) NSMutableArray    *titlearray;



@end

@implementation MovementsController
- (instancetype)init {
    self = [super init];
    if (self) {
        self.isNeedBackItem = YES;
        self.titlearray=[NSMutableArray array];
        _buttonarray= [NSMutableArray array];
        _lotterytype=@"0";
        _movementsstr=HTTP_bj3_trend;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    DLog(@"----------  %@",[MyConfig currentConfig].unit);

    self.array = [NSArray arrayWithObjects:@"三分彩",@"北京赛车PK10",@"幸运28",@"重庆时时彩",@"PC蛋蛋",@"广东快乐十分",@"天津时时彩",@"新疆时时彩",@"快乐扑克3",@"广东11选5",@"江苏快3",@"广西快乐十分",@"六合彩",nil];
    _movenmentarray=[NSArray arrayWithObjects:HTTP_bj3_trend,HTTP_bjPk10_trend,HTTP_xjpLu28_trend,HTTP_cqSSc_trend,HTTP_bjLu28_trend,HTTP_gdk10_trend,HTTP_tjSsc_trend,HTTP_xjSsc_trend,HTTP_poker_trend,HTTP_gdPick11_trend,HTTP_jsK3_trend,HTTP_gxK10_trend,HTTP_markSix_trend,nil];
    
    _seleview=[[UIView alloc]initWithFrame:CGRectMake(10, 0,MSW-20, 40)];
    _seleview.layer.cornerRadius = 2;
    _seleview.layer.masksToBounds = YES;
    _seleview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_seleview];
//    [self setviewlayoutwithtype:@"0"];

    [self.view addSubview:self.scrollview];
    [self.view addSubview:self.list];
    [self addTopView];
    [self dropDownListParame:[self.array objectAtIndex:[_lotterytype intValue]]];
    
}
-(void)setviewlayoutwithtype:(NSString*)type{
    if ([_lotterytype isEqualToString:@"0"]) {
        _titelarray = [NSArray arrayWithObjects:@"号码",@"大小",@"单双",@"总和/龙虎",nil];

    }else if ([_lotterytype isEqualToString:@"1"]){
        _titelarray = [NSArray arrayWithObjects:@"号码",@"大小",@"单双",@"冠亚军和", @"1-5龙虎",nil];
    }else if ([_lotterytype isEqualToString:@"2"]){
        _titelarray = [NSArray arrayWithObjects:@"号码",@"混合",nil];
    }
    else if ([_lotterytype isEqualToString:@"3"]){
        _titelarray = [NSArray arrayWithObjects:@"号码",@"大小",@"单双",@"总和/龙虎",nil];
    }
    else if ([_lotterytype isEqualToString:@"4"]){
        _titelarray = [NSArray arrayWithObjects:@"号码",@"混合",nil];
    }else if ([_lotterytype isEqualToString:@"5"]){
        _titelarray = [NSArray arrayWithObjects:@"号码",@"大小",@"单双",@"总和/龙虎",nil];
    }
    else if ([_lotterytype isEqualToString:@"6"]){
        _titelarray = [NSArray arrayWithObjects:@"号码",@"大小",@"单双",@"总和/龙虎",nil];
    }
    else if ([_lotterytype isEqualToString:@"7"]){
        _titelarray = [NSArray arrayWithObjects:@"号码",@"大小",@"单双",@"总和/龙虎",nil];
    } else if ([_lotterytype isEqualToString:@"8"]){
        _titelarray = [NSArray arrayWithObjects:@"号码",@"混合",nil];
    }else if ([_lotterytype isEqualToString:@"9"]){
        _titelarray = [NSArray arrayWithObjects:@"号码",@"大小",@"单双",@"总和/龙虎",nil];
    }else if ([_lotterytype isEqualToString:@"10"]){
        _titelarray = [NSArray arrayWithObjects:@"号码",@"和值",nil];
    }else if ([_lotterytype isEqualToString:@"10"]){
        _titelarray = [NSArray arrayWithObjects:@"号码",@"和值",nil];
    }
    else if ([_lotterytype isEqualToString:@"11"]){
        _titelarray = [NSArray arrayWithObjects:@"号码",@"大小",@"单双",@"总和/龙虎",nil];
    }
    else if ([_lotterytype isEqualToString:@"12"]){
        _titelarray = [NSArray arrayWithObjects:@"号码",@"特码",@"正码",nil];
    }

    
    else{
    }
        
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
        btselete.titleLabel.font=[UIFont mysystemFontOfSize:15];
        [_seleview addSubview:btselete];
        [_buttonarray addObject:btselete];
        [btselete addTarget:self action:@selector(seleteviewclickwithbutton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    [self Switchingperformancedatawithtype:@"0"];

}
-(void)Switchingperformancedatawithtype:(NSString *)type{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
  
    
    DLog(@"-=-=-------%@",_movementsstr);
    [dict setValue:type forKey:@"type"];//[必选]类型 0=号码 1=大小 2=单双 3=冠亚军和 4=1-5龙虎
    
    [[HttpManager manager] requestGetURL:_movementsstr withParams:dict withTarget:self withHud:YES withSuccessBlock:^(id responseObject) {
        DLog(@"-----= %@", responseObject)
        
        [self setviewlayoutwitharray:responseObject[@"data"][@"items"]andtype:type];
        
        
    } withFailureBlock:^(NSError *error) {
        //        [self presentSheet:@"网络异常"];
    }];
}
-(void)setviewlayoutwitharray:(NSArray*)array andtype:(NSString*)type{
    
    
    [_scrollview removeAllSubviews];
    int  _firstbaozi;
    _firstbaozi=0;
    int  _firstduizi;
    _firstduizi=0;

    NSArray*titlearr=[array objectAtIndex:0];
    
    CGFloat W = _seleview.width/titlearr.count;
    CGFloat H = IPhone4_5_6_6P(20, 20, 23, 23);
    for (int i = 0; i<array.count; i++) {
        NSArray*numarr=[array objectAtIndex:i];
        for (int j = 0; j<numarr.count; j++) {
            UILabel*lable = [[UILabel alloc]initWithFrame:CGRectMake((W)*j,i* H, W+1, H)];
            lable.text=[numarr objectAtIndex:j];
            if ([lable.text isEqualToString:@"大"]||[lable.text isEqualToString:@"双"]||[lable.text isEqualToString:@"龙"]||[lable.text isEqualToString:@"红波"]||[lable.text isEqualToString:@"极大"]||[lable.text isEqualToString:@"家禽"]) {
                lable.textColor=RedColor;
            }else if ([lable.text isEqualToString:@"小"]||[lable.text isEqualToString:@"单"]||[lable.text isEqualToString:@"虎"]||[lable.text isEqualToString:@"绿波"]||[lable.text isEqualToString:@"极小"]||[lable.text isEqualToString:@"野兽"]){
                lable.textColor=GreenColor;
                
            }else if ([lable.text isEqualToString:@"蓝波"]){
                lable.textColor=BlueColor;
            }
            else if ([lable.text isEqualToString:@"对子"]){
                if (_firstbaozi==0) {
                    lable.textColor= BlackTitleColor;
                }else{
                    lable.textColor=[UIColor colorWithHex:@"#ae7a47"];
                }
                _firstduizi=1;
            }else if ([lable.text isEqualToString:@"同花"]){
                lable.textColor=[UIColor colorWithHex:@"#339999"];
            }else if ([lable.text isEqualToString:@"顺子"]){
                lable.textColor=[UIColor colorWithHex:@"#996699"];
            }else if ([lable.text isEqualToString:@"同花顺"]){
                lable.textColor=[UIColor colorWithHex:@"#009900"];
            }else if ([lable.text isEqualToString:@"豹子"]){
                if (_firstbaozi==0) {
                    lable.textColor= BlackTitleColor;
                }else{
                    lable.textColor=[UIColor colorWithHex:@"#ba2636"];
                }
                _firstbaozi=1;
                
            }
            else{
                lable.textColor= BlackTitleColor;
            }
            
            if (i%2==0) {
                lable.backgroundColor=[UIColor whiteColor];
            }else{
                lable.backgroundColor=RGBCOLOR(255, 251, 251);
            }
            
            lable.textAlignment = NSTextAlignmentCenter;
            lable.font=[UIFont systemFontOfSize:MiddleFont];
            [_scrollview addSubview:lable];
        }
    }
}
-(void)seleteviewclickwithbutton:(UIButton*)button{
    
    for (UIButton * _button2 in _buttonarray) {
        _button2.backgroundColor=[UIColor whiteColor];
        [_button2 setTitleColor:BlackTitleColor forState:0];
    }
    button.backgroundColor=RedColor;
    [button setTitleColor:[UIColor whiteColor] forState:0];
    [self Switchingperformancedatawithtype:[NSString stringWithFormat:@"%li",button.tag]];
}



-(UIButton *)button
{
    if (!_button)
    {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(0, 0,200, 40);
        [_button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_button setTitleColor:BlackTitleColor forState:0];
        _button.titleLabel.font=[UIFont mysystemFontOfSize:18.0f];
        _button.backgroundColor=[UIColor clearColor];
        [_button setImage:[UIImage imageNamed:@"bet_pulldown"] forState:UIControlStateNormal];
        _button.adjustsImageWhenHighlighted=NO;
    }
    return _button;
}

-(void)buttonClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected == YES)
    {
        _list.hidden=NO;
        [_list showList];
    }else
    {
        [_list hiddenList];
    }
}
-(DropDownListView *)list
{
    if (!_list)
    {
        _list = [[DropDownListView alloc]initWithListDataSource:self.array rowHeight:44 view:_button tophight:0];
        _list.delegate = self;
        _list.hidden=YES;
    }
    return _list;
}

#pragma mark - 头部视图
//自定义导航栏按钮
- (void)addTopView {
    
    if (_TopView == nil) {
        _TopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    }
    _TopView.backgroundColor=[UIColor clearColor];
    self.navigationItem.titleView = _TopView;
    [_TopView addSubview:[self button]];
}
//改变文字图片的位置
-(void)dropDownListParame:(NSString *)aStr
{
    DLog(@"-=-=-    %@",aStr);

    [_button setTitle:aStr forState:UIControlStateNormal];
    _lotterytype= [NSString stringWithFormat:@"%li",[self.array indexOfObject:aStr]];
    _movementsstr=[_movenmentarray objectAtIndex:[_lotterytype intValue]];

    [self setviewlayoutwithtype:_lotterytype];

    //    交换文字与图片的位置
    CGFloat imageWidth = _button.imageView.bounds.size.width;
    CGFloat labelWidth = _button.titleLabel.bounds.size.width;
    _button.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);
    _button.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
    
    
}
//主滑动视图
-(UIScrollView*)scrollview{
    if (!_scrollview) {
        _scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(10,_seleview.bottom+10,_seleview.width, MSH-100)];
        _scrollview.backgroundColor=[UIColor clearColor];
        _scrollview.showsHorizontalScrollIndicator=NO;
        _scrollview.showsVerticalScrollIndicator=NO;
        _scrollview.delegate=self;
        _scrollview.contentSize = CGSizeMake(_seleview.width, MSH);
        
    }
    return _scrollview;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
