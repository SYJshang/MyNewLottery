//
//  BetDetailController.m
//  longzhicai
//
//  Created by lili on 2017/3/27.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import "BetDetailController.h"
#import "BetDetailHeadView.h"
#import "DropDownListView.h"
#import "BetFootView.h"
#import "MovementsView.h"
#import "RankingView.h"
#import "BetHeadView.h"
#import "BetTypeHeadView.h"
#import "QuickView.h"
#import "OptionalView.h"
#import "SettlementView.h"
@interface BetDetailController ()<DropDownViewDelegate,BetFootViewDelegate,BetHeadViewDelegate,UIScrollViewDelegate,BetTypeHeadViewDelegate,SettlementViewDelegate>
{
    UIView          *_TopView;               //导航栏
    UIView          *_optionalone;          //自选下注第一组view
    UIView          *_quickone;             //快捷下注第一组view
    UIView          *_optionaltwo;          //自选下注第二组view
    UIView          *_quicktwo;             //快捷下注第二组view
    UIView          *_optionalthr;          //自选下注第三组view
    UIView          *_quickthr;             //快捷下注第三组view
    
    BetTypeHeadView *_onehead;              //第一组下注类型
    BetTypeHeadView *_twohead;              //第二组下注类型
    BetTypeHeadView *_thrhead;              //第三组下注类型
    
    NSMutableArray  *_optionalarray1;       //存放自选下注的第一组view的数组
    NSMutableArray  *_optionalarray2;       //存放自选下注的第二组view的数组
    NSMutableArray  *_optionalarray3;       //存放自选下注的第三组view的数组
    
    NSMutableArray  *_quickarray1;          //存放快捷下注的第一组view的数组
    NSMutableArray  *_quickarray2;          //存放快捷下注的第二组view的数组
    NSMutableArray  *_quickarray3;          //存放快捷下注的第三组view的数组
    int             _bettype;               //选择的下注方式1自主下注2快捷下注
   
    BetTypeHeadView *_twohead2;              //
    BetTypeHeadView *_thrhead2;              //


}

@property (nonatomic, strong) DropDownListView      *list;                  //下拉选择菜单
@property (nonatomic, strong) NSArray               *array;
@property (nonatomic, strong) UIButton              *button;                //导航栏标题
@property (nonatomic, strong) BetDetailHeadView     *headview;              //顶部彩票信息视图
@property (nonatomic, strong) BetFootView           *footview;              //底部视图
@property (nonatomic, strong) MovementsView         *movementsview;         //走势视图
@property (nonatomic, strong) RankingView           *rangkingview;          //冷热排行
@property (nonatomic, strong) UIScrollView          *scrollview;            //主滑动视图
@property (nonatomic, strong) BetHeadView           *betheadview;           //上期开奖结果
@property (nonatomic, strong) SettlementView         *settlementview;       //结算视图
@end

@implementation BetDetailController
- (instancetype)init {
    self = [super init];
    if (self) {
        self.isNeedBackItem = NO;
        
        _optionalarray1 = [NSMutableArray array];
        _optionalarray2 = [NSMutableArray array];
        _optionalarray3 = [NSMutableArray array];

        _quickarray1    = [NSMutableArray array];
        _quickarray2    = [NSMutableArray array];
        _quickarray3    = [NSMutableArray array];
        _bettype        =1;

    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = [NSArray arrayWithObjects:@"两面盘",@"特码",@"PC蛋蛋",nil];
    [self addTopView];
    [self dropDownListParame:[self.array objectAtIndex:0]];
    [self.view addSubview:self.headview];
    [self.view addSubview:self.scrollview];
    [self.view addSubview:self.footview];
    [self.view addSubview:self.list];
    [self.view addSubview:self.movementsview];
    [self.view addSubview:self.rangkingview];
    [self.view addSubview:self.settlementview];

    [self initUI];

}
-(void)initUI{
    
    
    _onehead=[[BetTypeHeadView alloc]initWithFrame:CGRectMake(0,_betheadview.bottom, MSW, 40)];
    _onehead.delegate=self;
    _onehead.viewtag=1;
    _onehead.titleArray=@[@"综合／龙湖",@"第一球",@"第三球"];
    [_scrollview addSubview:_onehead];
    
    _twohead=[[BetTypeHeadView alloc]initWithFrame:CGRectMake(0, _onehead.bottom, MSW, 40)];
    _twohead.titleArray=@[@"第一球",@"第一球",@"第三球",@"第四期"];
    _twohead.delegate=self;
    _twohead.viewtag=2;
    [_scrollview addSubview:_twohead];
    
    _thrhead=[[BetTypeHeadView alloc]initWithFrame:CGRectMake(0, _twohead.bottom, MSW, 40)];
    _thrhead.titleArray=@[@"第五球",@"第六球",@"第七球",@"第八期"];
    _thrhead.delegate=self;
    _thrhead.viewtag=3;
    [_scrollview addSubview:_thrhead];
    //*******************自选下注*******************//
    _optionalone=[[UIView alloc]init];
//    _optionalone.backgroundColor=[UIColor redColor];
    _optionalone.size=CGSizeMake(MSW, 110);
    [_scrollview addSubview:_optionalone];

    CGFloat W = MSW/4;
    CGFloat H = 50;
    for (int i = 0; i<8; i++) {
        OptionalView*option = [[OptionalView alloc]initWithFrame:CGRectMake((W)*(i%4),(i/4) * (H), W, H)];
        [_optionalarray1 addObject:option];
        [_optionalone addSubview:option];
    }

    
    _optionaltwo=[[UIView alloc]init];
    _optionaltwo.size=CGSizeMake(MSW, 110);
    [_scrollview addSubview:_optionaltwo];
        for (int i = 0; i<8; i++) {
            OptionalView*option = [[OptionalView alloc]initWithFrame:CGRectMake((W)*(i%4),(i/4) * (H), W, H)];
            
            [_optionaltwo addSubview:option];
    }
    _optionalthr=[[UIView alloc]init];
    _optionalthr.backgroundColor=[UIColor redColor];
    _optionalthr.size=CGSizeMake(MSW, 500);
    [_scrollview addSubview:_optionalthr];
    //*******************快捷下注*******************//
    _quickone=[[UIView alloc]init];
//    _quickone.backgroundColor=[UIColor greenColor];
    _quickone.size=CGSizeMake(MSW, 110);
    [_scrollview addSubview:_quickone];
    
    for (int i = 0; i<8; i++) {
        QuickView*quick = [[QuickView alloc]initWithFrame:CGRectMake((W)*(i%4),(i/4) * (H), W, H)];
        
        [_quickarray1 addObject:quick];
        [_quickone addSubview:quick];
    }
    
    _quicktwo=[[UIView alloc]init];
    _quicktwo.size=CGSizeMake(MSW, 150);
    [_scrollview addSubview:_quicktwo];
    
    for (int i = 0; i<8; i++) {
        QuickView*quick = [[QuickView alloc]initWithFrame:CGRectMake((W)*(i%4),(i/4) * (H), W, H)];
        
        [_quicktwo addSubview:quick];
    }

    
    _quickthr=[[UIView alloc]init];
    _quickthr.backgroundColor=[UIColor greenColor];
    _quickthr.size=CGSizeMake(MSW, 500);
    [_scrollview addSubview:_quickthr];

    _quickthr.hidden=YES;
    _quicktwo.hidden=YES;
    _quickone.hidden=YES;
    
   //父控件frame改变 子控件被切除
    _quickone.clipsToBounds = YES;
    _quicktwo.clipsToBounds = YES;
    _quickthr.clipsToBounds = YES;
    _optionalone.clipsToBounds = YES;
    _optionaltwo.clipsToBounds = YES;
    _optionalthr.clipsToBounds=YES;
    
    
    _twohead2=[[BetTypeHeadView alloc]initWithFrame:CGRectMake(0,_optionalone.bottom, MSW, 40)];
    _twohead2.titleArray=@[@"第一球",@"第一球",@"第三球",@"第四期"];
    _twohead2.delegate=self;
    [self.scrollview addSubview:_twohead2];
    _twohead2.hidden=YES;

    
    [self setviewfrem];
}
//设置整个view的布局
-(void)setviewfrem{
    _onehead.frame=CGRectMake(0, _betheadview.bottom, MSW, 40);
    _optionalone.frame=CGRectMake(0, _onehead.bottom, MSW, _optionalone.frame.size.height);
    _quickone.frame=_optionalone.frame;
    _twohead.frame=CGRectMake(0, _onehead.bottom+_optionalone.height, MSW, 40);
    _optionaltwo.frame=CGRectMake(0, _twohead.bottom, MSW, _optionaltwo.frame.size.height);
    _quicktwo.frame=_optionaltwo.frame;
    _thrhead.frame=CGRectMake(0,_twohead.bottom+_optionaltwo.height, MSW, 40);
    _optionalthr.frame=CGRectMake(0, _thrhead.bottom, MSW, _optionalthr.frame.size.height);
    _quickthr.frame=_optionalthr.frame;
    _scrollview.contentSize = CGSizeMake(MSW,_betheadview.height+_onehead.height*3+_optionalone.height+_optionaltwo.height+_optionalthr.height);
}
#pragma mark - 点击第几组是否展开
-(void)clickviewwithtag:(int)tag isopen:(BOOL)isopen{
    NSString*str;
    if (isopen==YES) {
        str=@"展开";
        
    }else{
        str=@"没有展开";
    }
    
    if (tag==1) {
        if (isopen==YES) {
            _optionalone.size=CGSizeMake(MSW, 110);
        }else{
            _optionalone.size=CGSizeMake(MSW, 0);

        }
    }else if (tag==2){
        if (isopen==YES) {
            _optionaltwo.size=CGSizeMake(MSW, 110);

        }else{
            _optionaltwo.size=CGSizeMake(MSW, 0);
        }

    }else{
        if (isopen==YES) {
            _optionalthr.size=CGSizeMake(MSW, 500);
        
        }else{
            _optionalthr.size=CGSizeMake(MSW, 0);

        }
    }
    
    [self setviewfrem];
    DLog(@"-=-=------点击了%i个 状态是：%@",tag,str);
}
#pragma mark - 点击规则
-(void)clickrules{
    DLog(@"-=-=-  规则");
}
-(UIButton *)button
{
    if (!_button)
    {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(MSW/2-100, 24,200, 40);
        [_button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_button setTitleColor:BlackTitleColor forState:0];
        _button.titleLabel.font=[UIFont mysystemFontOfSize:18.0f];
        _button.backgroundColor=[UIColor clearColor];
        [_button setImage:[UIImage imageNamed:@"bet_pulldown"] forState:UIControlStateNormal];
        _button.adjustsImageWhenHighlighted=NO;
    }
    return _button;
}
#pragma mark - 顶部选择菜单
-(void)buttonClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected == YES)
    {
        [_list showList];
    }else
    {
        [_list hiddenList];
    }
}
//下注结算
-(SettlementView*)settlementview{
    
    if (!_settlementview) {
        _settlementview=[[SettlementView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
        _settlementview.hidden=YES;
        _settlementview.delegate=self;
    }
    return _settlementview;
}

//主滑动视图
-(UIScrollView*)scrollview{
    if (!_scrollview) {
        _scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, _headview.bottom, MSW, MSH-64-_headview.height-_footview.height-50)];
        _scrollview.backgroundColor=[UIColor whiteColor];
        _scrollview.showsHorizontalScrollIndicator=NO;
        _scrollview.showsVerticalScrollIndicator=NO;
        _scrollview.delegate=self;
        _scrollview.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 590);
        [_scrollview addSubview:self.betheadview];
        
    }
    return _scrollview;
}
//顶部选择菜单
-(DropDownListView *)list
{
    if (!_list)
    {
        _list = [[DropDownListView alloc]initWithListDataSource:self.array rowHeight:44 view:_button tophight:64];
        _list.delegate = self;
        _list.hidden=YES;
    }
    return _list;
}
//顶部视图
-(BetDetailHeadView*)headview{
    if (!_headview) {
        _headview=[[BetDetailHeadView alloc]initWithFrame:CGRectMake(0, 64, MSW, 60)];
    }
    return _headview;
}
//底部视图
-(BetFootView*)footview{
    if (!_footview) {
        _footview=[[BetFootView alloc]initWithFrame:CGRectMake(0, MSH-49, MSW, 49)];
        _footview.delegate=self;
    }
    return _footview;
}
//走势
-(MovementsView*)movementsview{
    if (!_movementsview)
    {
        _movementsview=[[MovementsView alloc]initWithRightdistance:80];
        _movementsview.hidden=YES;
    }
    return _movementsview;
}
//冷热排行
-(RankingView*)rangkingview{
    if (!_rangkingview) {
        
        _rangkingview=[[RankingView alloc]initWithRightdistance:80];
        _rangkingview.hidden=YES;
    }
    return _rangkingview;
}
//上期开奖结果
-(BetHeadView*)betheadview{
    if (!_betheadview) {
        _betheadview=[[BetHeadView alloc]initWithFrame:CGRectMake(0,0, MSW, 140)];
        _betheadview.backgroundColor=[UIColor whiteColor];
        _betheadview.delegate=self;
    }
    return _betheadview;
}
#pragma mark - 选择自主下注快捷下注
-(void)seletebettypewithindex:(int)index{
    DLog(@"-=------%i",index);
    if (index==1) {
        _quickone.hidden    =YES;
        _quicktwo.hidden    =YES;
        _quickthr.hidden    =YES;
        _optionalone.hidden =NO;
        _optionaltwo.hidden =NO;
        _optionalthr.hidden =NO;
        _bettype            =1;
    }else{
        _quickone.hidden    =NO;
        _quicktwo.hidden    =NO;
        _quickthr.hidden    =NO;
        _optionalone.hidden =YES;
        _optionaltwo.hidden =YES;
        _optionalthr.hidden =YES;
        _bettype            =2;

    }
}
#pragma mark - 点击开奖视频
-(void)clicklotteryvideo{
    DLog(@"-=-=-  开奖视频");
}
-(void)clickbetwithmoney:(NSString *)money{

    DLog(@"总共：%@元",money);

}
#pragma mark - 底部三个按钮点击事件
-(void)clickwithbuttontag:(int)tag{
    
    if (tag==101) {

    }else if (tag==102){
        [_movementsview showView];
    }else if (tag==103){
        [_rangkingview showView];
    }
    else{
        
        _settlementview.betArray=@[@"冠军单",@"亚军双",@"第四名小",@"亚军双",@"第四名小",@"亚军双",@"第四名小",@"亚军双",@"第四名小",@"第四名小"];
        [_settlementview showView];

        if (_bettype==1) {//选择自主下注
            for (int i = 0; i<_optionalarray1.count; i++) {
                
                OptionalView*option=[_optionalarray1 objectAtIndex:i];
                if (!IsStrEmpty(option.tfnumber.text)) {
                    DLog(@"-=选择了-=-=--%@",option.tfnumber.text);
                }
            }
        }
        else
        {//选择快捷下注
            for (int i = 0; i<_quickarray1.count; i++) {
                
                QuickView*quick=[_quickarray1 objectAtIndex:i];
                if (quick.isselete==YES) {
                    DLog(@"-选择了--%@",quick.lbnumber.text);
                }
            }

        
        }
        
    }
}
#pragma mark - 滚动视图监听事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    DLog(@"=-=--------%f--------%f",scrollView.contentOffset.y,_betheadview.height+_onehead.height+_optionalone.height+_twohead.height+_optionaltwo.height);
    if (scrollView.contentOffset.y>_betheadview.height+_onehead.height+_optionalone.height) {
        
        DLog(@"hhhhhhhhhhhhh");
        _twohead2.hidden=NO;
        _twohead2.frame=CGRectMake(0,scrollView.contentOffset.y, MSW,50);
        
        if (scrollView.contentOffset.y>_betheadview.height+_onehead.height+_optionalone.height+_optionaltwo.height) {
            
    _twohead2.frame=CGRectMake(0,(_betheadview.height+_onehead.height+_optionalone.height+_optionaltwo.height+_twohead.height+_thrhead.height-scrollView.contentOffset.y), MSW,50);
            
        }
    }
    else{
//        _twohead.frame=CGRectMake(0, _onehead.bottom+_optionalone.height, MSW, 40);

    }
}

#pragma mark - 自定义导航视图
//由于此控制器的某些功能会与悬浮球冲突所以自定义导航栏
- (void)addTopView {
    
    if (_TopView == nil) {
        _TopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MSW, 64)];
    }
    _TopView.backgroundColor=NavColor;
    [self.view addSubview:_TopView];
    [_TopView addSubview:[self button]];
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(MSW-64, 20, 44, 44);
    right.backgroundColor = [UIColor clearColor];
    [right setTitle:@"规则" forState:0];
    right.titleLabel.font=[UIFont mysystemFontOfSize:BigFont];
    [right setTitleColor:[UIColor blackColor] forState:0];
    [right addTarget:self action:@selector(clickrules) forControlEvents:UIControlEventTouchUpInside];
    [_TopView addSubview:right];
    
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.frame = CGRectMake(10, 20, 44, 44);
    left.backgroundColor = [UIColor clearColor];
    [left addTarget:self action:@selector(backForePage) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"all_return_icon"]];
    arrow.contentMode = UIViewContentModeScaleAspectFit;
    arrow.frame = CGRectMake(0,(44 - 30) / 2.0, 21, 30);
    arrow.backgroundColor = [UIColor clearColor];
    [left addSubview:arrow];
    [_TopView addSubview:left];
}
//改变button内文字图片的位置
-(void)dropDownListParame:(NSString *)aStr
{    [_button setTitle:aStr forState:UIControlStateNormal];
    //    交换文字与图片的位置
    CGFloat imageWidth = _button.imageView.bounds.size.width;
    CGFloat labelWidth = _button.titleLabel.bounds.size.width;
    _button.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);
    _button.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
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
