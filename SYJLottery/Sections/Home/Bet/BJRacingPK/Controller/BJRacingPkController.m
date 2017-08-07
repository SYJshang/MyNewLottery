//
//  BJRacingPkController.m
//  longzhicai
//
//  Created by lili on 2017/4/6.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import "BJRacingPkController.h"
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
#import "BetDetailHeadModel.h"


#import "RankingModel.h"
#import "WebViewController.h"
#import "BetPanelModel.h"
#import "BetModel.h"
//#import "DepositViewController.h"
#import "BJMovementsView.h"
//#import "LoginViewController.h"
#import "WebViewController.h"

@interface BJRacingPkController ()<DropDownViewDelegate,BetFootViewDelegate,BetHeadViewDelegate,UIScrollViewDelegate,BetTypeHeadViewDelegate,SettlementViewDelegate,OptionalViewDelegate,QuickViewDelegate,BetDetailHeadViewDelegate,UITextFieldDelegate>
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
    
    int             _playType;              //玩法类型 0=两面盘 1=1-10名 2=冠亚军和
    NSMutableArray  *_betpanelarray;         //存放下注面板的数组
    
    int             _onegrouphght;              //第一组下注面板的高
    int             _tworouphght;               //第二组下注面板的高
    int             _thrgrouphght;              //第三组下注面板的高
    
    
    NSMutableArray  *_seleteoptionarray;         //存放选中的自选下注的数组
    NSMutableArray  *_seletequickarray;         //存放选中的快捷下注的数组
    
    UILabel          *_lbfootsett;              //底部结算lable
    
    int             _isRotaryheader;              //是否封盘 0  否  1是
    int             _ispop;                       //是否是POP操作 0  否  1是
    int             _isrun;                       //是否倒计时在运行 0  否  1是
    
    
    NSString        * _isweb;                   //是否web下注
    NSString        * _weburl;              //web url
    

}
@property (nonatomic, strong) DropDownListView      *list;                  //下拉选择菜单
@property (nonatomic, strong) NSArray               *array;                 //玩法数组
@property (nonatomic, strong) UIButton              *button;                //导航栏标题
@property (nonatomic, strong) BetDetailHeadView     *headview;              //顶部彩票信息视图
@property (nonatomic, strong) BetFootView           *footview;              //底部视图
@property (nonatomic, strong) BJMovementsView         *movementsview;       //走势视图
@property (nonatomic, strong) RankingView           *rangkingview;          //冷热排行
@property (nonatomic, strong) UIScrollView          *scrollview;            //主滑动视图
@property (nonatomic, strong) BetHeadView           *betheadview;           //上期开奖结果
@property (nonatomic, strong) SettlementView        *settlementview;        //结算视图

@property (nonatomic, strong) BetDetailHeadModel    *headmodel;             //当前和上一期信息

@property (nonatomic,weak) NSTimer *timer;

@end

@implementation BJRacingPkController
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
        
        _playType       =0;
        _betpanelarray  = [NSMutableArray array];
        
        
        _seleteoptionarray = [NSMutableArray array];
        _seletequickarray = [NSMutableArray array];
        
        _isRotaryheader=0;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MyConfig currentConfig].isback=@"2";
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MyConfig currentConfig].isback=@"0";
    if ([_cometype isEqualToString:@"1"]) {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }else{
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
    NSArray *viewControllers = self.navigationController.viewControllers;//获取当前的视图控制其
    if (viewControllers.count > 1 && [viewControllers objectAtIndex:viewControllers.count-2] == self) {
        _ispop=0;
        [self.navigationController setNavigationBarHidden:NO animated:animated];
        //当前视图控制器在栈中，故为push操作
    } else if ([viewControllers indexOfObject:self] == NSNotFound) {
        //当前视图控制器不在栈中，故为pop操作
        _ispop=1;
    }
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    
    [SVProgressHUD dismiss];
}
-(void)viewDidDisappear:(BOOL)animated{
    
    DLog(@"-=---------%i",_ispop);
    if (_ispop==1) {
        [self.timer invalidate];
        self.timer = nil;
        [_headview endtime];
        _isrun=0;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = [NSArray arrayWithObjects:@"两面盘",@"1-10名",@"冠亚军和",nil];
    [self addTopView];
    [self dropDownListParame:[self.array objectAtIndex:0]];
    [self.view addSubview:self.headview];
    [self.view addSubview:self.scrollview];
    [self.view addSubview:self.footview];
    [self.view addSubview:self.list];
    [self.view addSubview:self.movementsview];
    [self.view addSubview:self.rangkingview];
    [self.view addSubview:self.settlementview];
    _isrun=1;
    
    [self getcurrentTimedata];
    [self  getrankingdata];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(getcurrentTimedata) userInfo:nil repeats:YES];
    //            //把定时器放到子线程
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:UITrackingRunLoopMode];
    
    
    //监听当键将已经收起时
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isbackrefresh) name:@"bjNotifica" object:nil];
    
    [SVProgressHUD showWithStatus:@"loading..."];
    
}
//倒计时结束开始请求开奖结果
-(void)Thecountdowntotheend{
    [_timer setFireDate:[NSDate distantPast]];//运行
    
    //    [self getcurrentTimedata];
}
-(void)isbackrefresh{
    [self getcurrentTimedata];
}

#pragma mark - 获取当前期的信息
-(void)getcurrentTimedata{
    if (![[MyConfig currentConfig].isback isEqualToString:@"2"]&&_isrun==0) {
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:[MyConfig currentConfig].userU forKey:@"u"];//[可选]用户key
    [dict setValue:@"1" forKey:@"device"];//设备类型 1=IOS 2=安卓
    [dict setValue:[NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"] forKey:@"ver"];//版本号
    [[HttpManager manager] requestGetURL:HTTP_bjPk10_currentTime withParams:dict withTarget:self withHud:NO withSuccessBlock:^(id responseObject) {
        DLog(@"-----= %@", responseObject)
        
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            NSDictionary *data = responseObject[@"data"];
            NSDictionary *obj = data[@"obj"];
            NSString*openstr=data[@"obj"][@"openTime"];
            int opentime=[openstr intValue];
            _isweb=data[@"obj"][@"isWeb"];
            _weburl=data[@"obj"][@"webUrl"];
            

            _headmodel = [BetDetailHeadModel mj_objectWithKeyValues:obj];
            _headview.Model=_headmodel;
            _betheadview.Model=_headmodel;
            [MyConfig currentConfig].money = data[@"obj"][@"money"];
            
            if (_headmodel.openResult.count>0) {
                [_timer setFireDate:[NSDate distantFuture]];//停止
                [NSTimer scheduledTimerWithTimeInterval:opentime target:self selector:@selector(getcurrentTimedata) userInfo:nil repeats:NO];
                _isrun=0;
                
            }else{
                if (_isrun==1) {
                }else{
                    _isrun=1;
                    [_timer setFireDate:[NSDate distantPast]];//运行
                }
            }
            if ([_headmodel.betTime isEqualToString:@"0"]) {
                
                if (_isRotaryheader==0) {
                    _isRotaryheader=1;
                    [self presentSheet:@"本期已封盘，请等待下一期"];
                    if (_betpanelarray.count>0) {
                        [self setViewlayout];
                    }
                }
                
            }else{
                if (_isRotaryheader==1) {
                    _isRotaryheader=0;
                    if (_betpanelarray.count>0) {
                        [self setViewlayout];
                    }
                }
            }
        }
        
        [SVProgressHUD dismiss];

    } withFailureBlock:^(NSError *error) {
        [self presentSheet:NetErrorMsg];
        [SVProgressHUD dismiss];
    }];
    
}
#pragma mark - 获取冷热排行
-(void)getrankingdata{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:[MyConfig currentConfig].userU forKey:@"u"];//[可选]用户key
    [[HttpManager manager] requestGetURL:HTTP_bjPk10_hotRanking withParams:dict withTarget:self withHud:YES withSuccessBlock:^(id responseObject) {
        DLog(@"-----= %@", responseObject)
        
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            NSArray * items = responseObject[@"data"][@"items"];
            NSMutableArray *array = [NSMutableArray array];
            array = [RankingModel mj_objectArrayWithKeyValuesArray:items];
            _rangkingview.dataArray=array;
            
        }
        [SVProgressHUD dismiss];

    } withFailureBlock:^(NSError *error) {
        [self presentSheet:NetErrorMsg];
        [SVProgressHUD dismiss];

    }];
}

#pragma mark - 获取投注面板信息
-(void)getbetPaneldata{
    [_betpanelarray removeAllObjects];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:[NSString stringWithFormat:@"%i",_playType] forKey:@"playType"];//[必选]玩法类型 0=两面盘 1=1-10名 2=冠亚军和
    
    [[HttpManager manager] requestGetURL:HTTP_bjPk10_betPanel withParams:dict withTarget:self withHud:YES withSuccessBlock:^(id responseObject) {
        DLog(@"-----= %@", responseObject)
        
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            NSArray * items = responseObject[@"data"][@"betItems"];
            NSMutableArray *array = [NSMutableArray array];
            array = [BetPanelModel mj_objectArrayWithKeyValuesArray:items];
            _betpanelarray=array;
            
            if (_betpanelarray.count>0) {
                [self setViewlayout];
            }
            
        }
        [SVProgressHUD dismiss];

    } withFailureBlock:^(NSError *error) {
        [self presentSheet:NetErrorMsg];
        [SVProgressHUD dismiss];

    }];
}

-(void)setViewlayout{
    
    [SVProgressHUD dismiss];

    [_scrollview removeSubview:_onehead];
    [_scrollview removeSubview:_thrhead];
    [_scrollview removeSubview:_twohead];
    [_scrollview removeSubview:_optionaltwo];
    [_scrollview removeSubview:_optionalone];
    [_scrollview removeSubview:_optionalthr];
    [_scrollview removeSubview:_quickone];
    [_scrollview removeSubview:_quicktwo];
    [_scrollview removeSubview:_quickthr];
    
    [_optionalarray1 removeAllObjects];
    [_optionalarray2 removeAllObjects];
    [_optionalarray3 removeAllObjects];
    [_quickarray1 removeAllObjects];
    [_quickarray2 removeAllObjects];
    [_quickarray3 removeAllObjects];
    
    [_seletequickarray removeAllObjects];
    [_seleteoptionarray removeAllObjects];
    
    
    if (_playType==0||_playType==1) {//两面盘  1-10球
        _onehead=[[BetTypeHeadView alloc]initWithFrame:CGRectMake(0,_betheadview.bottom, MSW, BetHeadHight)];
        _onehead.delegate=self;
        _onehead.viewtag=1;
        _onehead.titleArray=@[@"冠军",@"亚军",@"第3名",@"第4名"];
        [_scrollview addSubview:_onehead];
        
        _twohead=[[BetTypeHeadView alloc]initWithFrame:CGRectMake(0, _onehead.bottom, MSW, BetHeadHight)];
        _twohead.titleArray=@[@"第5名",@"第6名",@"第7名",@"8名"];
        _twohead.delegate=self;
        _twohead.viewtag=2;
        [_scrollview addSubview:_twohead];
        
        _thrhead=[[BetTypeHeadView alloc]initWithFrame:CGRectMake(0, _twohead.bottom, MSW, BetHeadHight)];
        _thrhead.titleArray=@[@"第9名",@"第10名"];
        _thrhead.delegate=self;
        _thrhead.viewtag=3;
        [_scrollview addSubview:_thrhead];
        
        //        计算三组view的高度
        if (_betpanelarray.count>0) {
            BetPanelModel*model=[_betpanelarray objectAtIndex:0];
            BetPanelModel*model2=[_betpanelarray objectAtIndex:4];
            BetPanelModel*model3=[_betpanelarray objectAtIndex:7];
            _onegrouphght=(int)model.optionItems.count*50+10;
            _tworouphght=(int)model2.optionItems.count*50+10;
            _thrgrouphght=(int)model3.optionItems.count*50+10;
            
        }
        //*******************自选下注*******************//
        _optionalone=[[UIView alloc]init];
        _optionalone.size=CGSizeMake(MSW, _onegrouphght);
        [_scrollview addSubview:_optionalone];
        
        
        //*******************快捷下注*******************//
        _quickone=[[UIView alloc]init];
        _quickone.size=CGSizeMake(MSW, _onegrouphght);
        [_scrollview addSubview:_quickone];
        
        
        CGFloat W = MSW/4;
        CGFloat H = 50;
        //第一组下注view的布局
        for (int i=0; i<4; i++) {
            BetPanelModel*onemodel=[_betpanelarray objectAtIndex:i%4];
            NSMutableArray *array = [NSMutableArray array];
            array = [BetModel mj_objectArrayWithKeyValuesArray:onemodel.optionItems];
            
            for (int j = 0; j<onemodel.optionItems.count; j++) {
                OptionalView*option = [[OptionalView alloc]initWithFrame:CGRectMake((W)*(i%4),j * (H), W, H)];
                option.isRotaryheader=_isRotaryheader;
                option.delegate=self;
                option.Model=[array objectAtIndex:j];
                [_optionalarray1 addObject:option];
                [_optionalone addSubview:option];
                
                
                QuickView*quick = [[QuickView alloc]initWithFrame:CGRectMake((W)*(i%4),j * (H), W, H)];
                quick.delegate=self;
                quick.isRotaryheader=_isRotaryheader;
                quick.Model=[array objectAtIndex:j];
                [_quickarray1 addObject:quick];
                [_quickone addSubview:quick];
                
            }
        }
        
        
        
        //第二组下注view的布局
        
        _optionaltwo=[[UIView alloc]init];
        _optionaltwo.size=CGSizeMake(MSW, _tworouphght);
        [_scrollview addSubview:_optionaltwo];
        
        _quicktwo=[[UIView alloc]init];
        _quicktwo.size=CGSizeMake(MSW, _tworouphght);
        [_scrollview addSubview:_quicktwo];
        
        for (int i=4; i<8; i++) {
            BetPanelModel*onemodel=[_betpanelarray objectAtIndex:i%4+4];
            NSMutableArray *array = [NSMutableArray array];
            array = [BetModel mj_objectArrayWithKeyValuesArray:onemodel.optionItems];
            for (int j = 0; j<onemodel.optionItems.count; j++) {
                OptionalView*option = [[OptionalView alloc]initWithFrame:CGRectMake((W)*(i%4),j * (H), W, H)];
                option.isRotaryheader=_isRotaryheader;
                option.Model=[array objectAtIndex:j];
                [_optionalarray2 addObject:option];
                [_optionaltwo addSubview:option];
                option.delegate=self;
                
                QuickView*quick = [[QuickView alloc]initWithFrame:CGRectMake((W)*(i%4),j * (H), W, H)];
                quick.delegate=self;
                quick.isRotaryheader=_isRotaryheader;
                quick.Model=[array objectAtIndex:j];
                [_quickarray2 addObject:quick];
                [_quicktwo addSubview:quick];
            }
        }
        
        
        //第三组下注view的布局
        _optionalthr=[[UIView alloc]init];
        _optionalthr.size=CGSizeMake(MSW, _thrgrouphght);
        [_scrollview addSubview:_optionalthr];
        
        
        _quickthr=[[UIView alloc]init];
        _quickthr.size=CGSizeMake(MSW, _thrgrouphght);
        [_scrollview addSubview:_quickthr];
        
        for (int i=8; i<10; i++) {
            BetPanelModel*onemodel=[_betpanelarray objectAtIndex:i%4+8];
            NSMutableArray *array = [NSMutableArray array];
            array = [BetModel mj_objectArrayWithKeyValuesArray:onemodel.optionItems];
            for (int j = 0; j<onemodel.optionItems.count; j++) {
                OptionalView*option = [[OptionalView alloc]initWithFrame:CGRectMake((W)*(i%4),j * (H), W, H)];
                option.isRotaryheader=_isRotaryheader;
                option.Model=[array objectAtIndex:j];
                [_optionalarray3 addObject:option];
                [_optionalthr addSubview:option];
                
                option.delegate=self;
                
                QuickView*quick = [[QuickView alloc]initWithFrame:CGRectMake((W)*(i%4),j * (H), W, H)];
                quick.isRotaryheader=_isRotaryheader;
                
                quick.Model=[array objectAtIndex:j];
                quick.delegate=self;
                [_quickarray3 addObject:quick];
                [_quickthr addSubview:quick];
                
            }
        }
        
        
        
    }else{
        _onehead=[[BetTypeHeadView alloc]initWithFrame:CGRectMake(0,_betheadview.bottom, MSW, BetHeadHight)];
        _onehead.delegate=self;
        _onehead.viewtag=1;
        _onehead.titleArray=@[@"冠亚军和"];
        [_scrollview addSubview:_onehead];
        
        
        BetPanelModel*onemodel=[_betpanelarray objectAtIndex:0];
        NSMutableArray *array = [NSMutableArray array];
        array = [BetModel mj_objectArrayWithKeyValuesArray:onemodel.optionItems];
        _onegrouphght=(int)((onemodel.optionItems.count-1)/4+1)*50+10;
        _tworouphght=0;
        _thrgrouphght=0;
        _optionaltwo.size=CGSizeMake(MSW, _tworouphght);
        _optionalthr.size=CGSizeMake(MSW, _thrgrouphght);
        //*******************自选下注*******************//
        _optionalone=[[UIView alloc]init];
        _optionalone.size=CGSizeMake(MSW, _onegrouphght);
        [_scrollview addSubview:_optionalone];
        
        
        //*******************快捷下注*******************//
        _quickone=[[UIView alloc]init];
        _quickone.size=CGSizeMake(MSW, _onegrouphght);
        [_scrollview addSubview:_quickone];
        
        
        CGFloat W = MSW/4;
        CGFloat H = 50;
        //第一组下注view的布局
        for (int j = 0; j<onemodel.optionItems.count; j++) {
            OptionalView*option = [[OptionalView alloc]initWithFrame:CGRectMake((W)*(j%4),(j/4) * (H), W, H)];
            option.isRotaryheader=_isRotaryheader;
            
            option.Model=[array objectAtIndex:j];
            [_optionalarray1 addObject:option];
            [_optionalone addSubview:option];
            option.delegate=self;
            
            
            
            QuickView*quick = [[QuickView alloc]initWithFrame:CGRectMake((W)*(j%4),(j/4) * (H), W, H)];
            quick.isRotaryheader=_isRotaryheader;
            quick.Model=[array objectAtIndex:j];
            [_quickarray1 addObject:quick];
            [_quickone addSubview:quick];
            quick.delegate=self;
            
        }
        
        
    }
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
    
    [self setviewfrem];
    [self seletebettypewithindex:_bettype];
    
}
//设置整个view的布局
-(void)setviewfrem{
    _onehead.frame=CGRectMake(0, _betheadview.bottom, MSW, BetHeadHight);
    _optionalone.frame=CGRectMake(0, _onehead.bottom, MSW, _optionalone.frame.size.height);
    _quickone.frame=_optionalone.frame;
    if (_playType==2) {
        _twohead.frame=CGRectMake(0, _onehead.bottom+_optionalone.height, MSW, 0);
    }else{
        _twohead.frame=CGRectMake(0, _onehead.bottom+_optionalone.height, MSW, BetHeadHight);
        
    }
    _optionaltwo.frame=CGRectMake(0, _twohead.bottom, MSW, _optionaltwo.frame.size.height);
    _quicktwo.frame=_optionaltwo.frame;
    if (_playType==2) {
        _thrhead.frame=CGRectMake(0,_twohead.bottom+_optionaltwo.height, MSW, 0);
    }else{
        _thrhead.frame=CGRectMake(0,_twohead.bottom+_optionaltwo.height, MSW, BetHeadHight);
        
    }
    _optionalthr.frame=CGRectMake(0, _thrhead.bottom, MSW, _optionalthr.frame.size.height);
    _quickthr.frame=_optionalthr.frame;
    _scrollview.contentSize = CGSizeMake(MSW,_betheadview.height+_onehead.height+_twohead.height+_thrhead.height+_optionalone.height+_optionaltwo.height+_optionalthr.height);
}
#pragma mark - 点击第几组是否展开
-(void)clickviewwithtag:(int)tag isopen:(BOOL)isopen{
    [_optionalone endEditing:YES];
    [_optionaltwo endEditing:YES];
    [_optionalthr endEditing:YES];
    
    if (tag==1) {
        if (isopen==YES) {
            _optionalone.size=CGSizeMake(MSW, _onegrouphght);
        }else{
            _optionalone.size=CGSizeMake(MSW, 0);
            
        }
    }else if (tag==2){
        if (isopen==YES) {
            _optionaltwo.size=CGSizeMake(MSW, _tworouphght);
            
        }else{
            _optionaltwo.size=CGSizeMake(MSW, 0);
        }
        
    }else{
        if (isopen==YES) {
            _optionalthr.size=CGSizeMake(MSW, _thrgrouphght);
            
        }else{
            _optionalthr.size=CGSizeMake(MSW, 0);
            
        }
    }
    
    [self setviewfrem];
}
#pragma mark - 点击规则
-(void)clickrules{
    [[HttpManager manager] requestGetURL:HTTP_bjPk10_rules withParams:nil withTarget:self withHud:YES withSuccessBlock:^(id responseObject) {
        DLog(@"-----= %@", responseObject)
        
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            NSString * link = responseObject[@"data"][@"link"];
            WebViewController *webVC = [[WebViewController alloc] init];
            webVC.hidesBottomBarWhenPushed = YES;
            webVC.urlstr=link;
            //            webVC.title=@"规则";
            [self.navigationController pushViewController:webVC animated:YES];
        }
    } withFailureBlock:^(NSError *error) {
    }];
    
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
        _scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, _headview.bottom, MSW, MSH-64-_headview.height-49)];
        _scrollview.backgroundColor=[UIColor whiteColor];
        _scrollview.showsHorizontalScrollIndicator=NO;
        _scrollview.showsVerticalScrollIndicator=NO;
        _scrollview.delegate=self;
        _scrollview.contentSize = CGSizeMake(MSW, MSH-200);
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
        NSDictionary* style = @{@"body" :
                                    @[[UIFont systemFontOfSize:IPhone4_5_6_6P(14, 14, 15, 15)],
                                      BlackTitleColor],
                                @"u": @[[UIFont systemFontOfSize:IPhone4_5_6_6P(14, 14, 15, 15)],RedColor,
                                        
                                        ],@"v": @[[UIFont systemFontOfSize:IPhone4_5_6_6P(14, 14, 15, 15)],BlackTitleColor,
                                                  
                                                  ]};
        _headview.lblottery.attributedText = [[NSString stringWithFormat:@"北京赛车PK10<u> A </u><v>000000期</v>"] attributedStringWithStyleBook:style];
        _headview.delegate=self;
    }
    return _headview;
}
//底部视图
-(BetFootView*)footview{
    if (!_footview) {
        _footview=[[BetFootView alloc]initWithFrame:CGRectMake(0, MSH-49, MSW, 49)];
        _footview.delegate=self;
        
        _lbfootsett=[[UILabel alloc]initWithFrame:CGRectMake(0, MSH-49-20, MSW, 20)];
        _lbfootsett.backgroundColor=RGBCOLOR(250, 248, 217);
        _lbfootsett.font=[UIFont mysystemFontOfSize:11];
        [self.view addSubview:_lbfootsett];
        _lbfootsett.hidden=YES;
    }
    return _footview;
}
//走势
-(BJMovementsView*)movementsview{
    if (!_movementsview)
    {
        _movementsview=[[BJMovementsView alloc]initWithRightdistance:80];
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
        _betheadview=[[BetHeadView alloc]initWithFrame:CGRectMake(0,0, MSW, 120)];//145
        _betheadview.backgroundColor=[UIColor whiteColor];
        _betheadview.delegate=self;
        _betheadview.lotterytype=@"1";
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
        if (_seleteoptionarray.count>0) {
            _scrollview.frame=CGRectMake(0, _headview.bottom, MSW, MSH-64-_headview.height-_footview.height-20);
            _lbfootsett.hidden=NO;
            
        }else{
            _scrollview.frame=CGRectMake(0, _headview.bottom, MSW, MSH-64-_headview.height-_footview.height);
            _lbfootsett.hidden=YES;
            
        }
        
    }else{
        _quickone.hidden    =NO;
        _quicktwo.hidden    =NO;
        _quickthr.hidden    =NO;
        _optionalone.hidden =YES;
        _optionaltwo.hidden =YES;
        _optionalthr.hidden =YES;
        _bettype            =2;
        _scrollview.frame=CGRectMake(0, _headview.bottom, MSW, MSH-64-_headview.height-_footview.height);
        _lbfootsett.hidden=YES;
        
        [_optionalone endEditing:YES];
        [_optionaltwo endEditing:YES];
        [_optionalthr endEditing:YES];
        
    }
}
#pragma mark - 点击开奖视频
-(void)clicklotteryvideo{
    DLog(@"-=-=-  开奖视频");
}
#pragma mark - 底部三个按钮点击事件
-(void)clickwithbuttontag:(int)tag{
    
    if (tag==101) {
        if (_seletequickarray.count>0||_seleteoptionarray.count>0) {
            [self setViewlayout];
        }
    }else if (tag==102){
        [_movementsview showView];
    }else if (tag==103){
        [_rangkingview showView];
    }
    else{
        
        
        NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
        
        if (!dict[@"userId"]) {
            
            [SVProgressHUD showInfoWithStatus:@"未登录，请登录过后再来购买！"];
            
        }else{
            [SVProgressHUD showInfoWithStatus:@"积分等级不够,暂不能积分购买,以为您加入收藏成功！"];
            
            if (_bettype==1) {//选择自主下注
                if (_seleteoptionarray.count>0) {
                    [_settlementview setviewlayoutwithbetarray:_seleteoptionarray AndBettype:@"1"];
                    _settlementview.lbtotal.attributedText=_lbfootsett.attributedText;
                    _settlementview.money=_headmodel.money;
                    
                    
                    NSData *dataArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"modelArr"];
                    NSMutableArray *userDefaultsArr = [NSKeyedUnarchiver unarchiveObjectWithData:dataArr];
                    
                    if (userDefaultsArr) {
                        [userDefaultsArr addObjectsFromArray:_seleteoptionarray];
                        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userDefaultsArr];
                        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"modelArr"];
                    }else{
                        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_seleteoptionarray];
                        [[NSUserDefaults standardUserDefaults] setObject:(NSArray *)data forKey:@"modelArr"];
                        
                    }
                }else{
                    [self presentSheet:@"请选择要下注的内容"];
                    
                }
            }
            else
            {//选择快捷下注
                if (_seletequickarray.count > 0) {
                    
                    [_settlementview setviewlayoutwithbetarray:_seletequickarray AndBettype:@"2"];
                    _settlementview.money=_headmodel.money;
                    
                    NSData *dataArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"modelArr"];
                    NSMutableArray *userDefaultsArr = [NSKeyedUnarchiver unarchiveObjectWithData:dataArr];
                    
                    if (userDefaultsArr) {
                        [userDefaultsArr addObjectsFromArray:_seleteoptionarray];
                        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userDefaultsArr];
                        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"modelArr"];
                    }else{
                        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_seletequickarray];
                        [[NSUserDefaults standardUserDefaults] setObject:(NSArray *)data forKey:@"modelArr"];
                        
                    }
                    
                    
                }else{
                    [self presentSheet:@"请选择要下注的内容"];
                    
                }
            }
        }
    }
}

#pragma mark - 去下注
-(void)clickbetwithmoney:(NSString *)money{
    DLog(@"总共：%@元",money);
    __block NSString *settlementString;
    NSMutableArray *settlementArray = [NSMutableArray array]; //结算array
    
    
    if (_bettype==1) {
        //解析数据对象
        [_seleteoptionarray enumerateObjectsUsingBlock:^(BetModel *obj, NSUInteger idx, BOOL *stop) {
            settlementString =  [NSString stringWithFormat:@"{\"id\":%@,\"p\":%@}",obj.optionId,obj.count];
            [settlementArray addObject:settlementString];
            DLog(@"str:---------%@",settlementString);
        }];
        
    }else{
        [_seletequickarray enumerateObjectsUsingBlock:^(BetModel *obj, NSUInteger idx, BOOL *stop) {
            settlementString =  [NSString stringWithFormat:@"{\"id\":%@,\"p\":%@}",obj.optionId,_settlementview.tfmoney.text];
            [settlementArray addObject:settlementString];
            DLog(@"str:---------%@",settlementString);
        }];
        if ([money isEqualToString:@"0"]) {
            [self presentSheet:@"单个金额必须大于1"];
            return;
        }
    }
    
    NSString *string = [NSString stringWithFormat:@"[%@]",[settlementArray componentsJoinedByString:@","]];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:[MyConfig currentConfig].userU forKey:@"u"];//[可选]用户key
    [dict setValue:_headmodel.room forKey:@"room"];//[可选]房间号，默认room=A
    [dict setValue:_headmodel.sessionNo forKey:@"sessionNo"];//[必选]当前期号
    [dict setValue:string forKey:@"optionArray"];//[必选]投注数组，[{optionId:投注项id,betPoints:投注金额}]
    DLog(@"-=-=-----%@-----%@ -------zonggong  %@-------%@",[MyConfig currentConfig].userU,_headmodel.room,_settlementview.totalmoney,string);
    
    if (_bettype==2&&IsStrEmpty(_settlementview.tfmoney.text)) {
        [self presentSheet:[MyConfig currentConfig].tips];
        return;
    }
    
    if ([_isweb isEqualToString:@"1"]) {
        [self setViewlayout];
        [_settlementview hiddenView];
        
        NSString *strUrl = [_weburl stringByReplacingOccurrencesOfString:@"t=" withString:@"t=1"];
        NSString*paramsstr=[Des keyValueStringWithDict:dict];//参数字典转换成字符串
        NSString*DesStr= [Des encryptUseDES:paramsstr key:DESKEY];//先进行转码后进行加密
        NSString *strUrl2 = [strUrl stringByReplacingOccurrencesOfString:@"m=" withString:[NSString stringWithFormat:@"m=%@",[Des encodeString:DesStr]]];
        
        [ [ UIApplication sharedApplication]openURL:[NSURL URLWithString:strUrl2]];
        
        
    }else{

    
    [[HttpManager manager] requestGetURL:HTTP_bjPk10_bet withParams:dict withTarget:self withHud:YES withSuccessBlock:^(id responseObject) {
        DLog(@"-----= %@=-----%@", responseObject,responseObject[@"msg"]);
        
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            
            [self getcurrentTimedata];
            [self setViewlayout];
            [_settlementview hiddenView];
        }
        else if ([responseObject[@"code"] isEqualToString:@"201"])
        {
            if([responseObject[@"msg"] rangeOfString:@"不足"].location !=NSNotFound)//_roaldSearchText
            {
                //延迟0.5秒执行跳转
                [self performSelector:@selector(Gotoprepaidphone) withObject:nil afterDelay:0.5f];
                [_settlementview hiddenView];
            }
        }
        
        [self presentSheet:responseObject[@"msg"]];
        
    } withFailureBlock:^(NSError *error) {
        [self presentSheet:NetErrorMsg];
    }];
    
    }
}
-(void)Gotoprepaidphone{
//    DepositViewController * deposit = [[DepositViewController alloc] init];
//    deposit.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:deposit animated:YES];
}

#pragma mark - 选择自选下注
-(void)seletebetmodelwithmodel:(BetModel *)model{
    
    DLog(@"=-=-------%@----%@",model.count,model.title);
    
    if (_seleteoptionarray.count==0) {
        if (!IsStrEmpty(model.count)) {
            [_seleteoptionarray addObject:model];
        }
    }else{
        
        int havadex;
        havadex=999;//默认值不可能达到的数字
        for (int i=0; i<_seleteoptionarray.count; i++) {
            BetModel*model2=[_seleteoptionarray objectAtIndex:i];
            if ([model.optionId isEqualToString:model2.optionId]) {
                havadex=i;
            }
        }
        if (havadex==999) {
            if (!IsStrEmpty(model.count)) {     //如果不为空就加进数组
                [_seleteoptionarray addObject:model];
            }
        }else{
            
            if (!IsStrEmpty(model.count)) {     //如果不为空就加进数组
                [_seleteoptionarray replaceObjectAtIndex:havadex withObject:model];
            }
            else{       //为空说明用户不选这一注要删掉
                [_seleteoptionarray removeObjectAtIndex:havadex];
            }
            
        }
    }
    
    
}
#pragma mark - 选择快捷下注
-(void)seletebetmodelwithmodel:(BetModel *)model Andisselete:(BOOL)isselete{
    
    if (_isRotaryheader==0) {
        if (isselete ==YES) {
            [_seletequickarray addObject:model];
            DLog(@"=-=-=选择了");
        }else{
            for (int i=0; i<_seletequickarray.count; i++) {
                BetModel*model2=[_seletequickarray objectAtIndex:i];
                if ([model.optionId isEqualToString:model2.optionId]) {
                    [_seletequickarray removeObjectAtIndex:i];
                }
            }
            
            DLog(@"-=-=----取消选择");
        }
        
    }else{
        [self presentSheet:@"本期已封盘，请等待下一期"];
    }
    
}
#pragma mark - 键盘已经收起
- (void)keyboardDidHide:(NSNotification *)notification
{
    
    DLog(@"-=-=------%li",_seleteoptionarray.count);
    
    if (_bettype==1) {
        if (_seleteoptionarray.count>0) {
            _scrollview.frame=CGRectMake(0, _headview.bottom, MSW, MSH-64-_headview.height-_footview.height-20);
            _lbfootsett.hidden=NO;
            NSDictionary* style = @{@"body" :
                                        @[
                                            BlackDescColor],
                                    @"u": @[RedColor,
                                            
                                            ]};
            int totalcount=0;
            float  jiangjin=0.00;
            for (int i=0; i<_seleteoptionarray.count; i++) {
                BetModel*model=[_seleteoptionarray objectAtIndex:i];
                
                totalcount=totalcount+[model.count intValue];
                jiangjin =jiangjin+[model.count floatValue]*[model.rate floatValue];
                
            }
            
            //            NSNumber *number = @(jiangjin);
            //            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            //            formatter.roundingMode = NSNumberFormatterRoundFloor;
            //            formatter.maximumFractionDigits = 2;
            //            NSString*yingli=[NSString stringWithFormat:@"%.2f", [[formatter stringFromNumber:number] floatValue]-totalcount];
            DLog(@"-=-----总共-%i----%f",totalcount,jiangjin);
            DLog(@"-=-==-=---%.2f",floor(jiangjin*100) / 100);
            
            NSString*yingli=[NSString stringWithFormat:@"%.2f",floor(jiangjin*100) / 100-totalcount];
            _lbfootsett.attributedText = [[NSString stringWithFormat:@"    %li注共<u>%i元</u>，若中奖，奖金%.2f元，盈利<u>%@元</u>",_seleteoptionarray.count,totalcount,floor(jiangjin*100) / 100,yingli] attributedStringWithStyleBook:style];
            
        }else{
            _scrollview.frame=CGRectMake(0, _headview.bottom, MSW, MSH-64-_headview.height-_footview.height);
            _lbfootsett.hidden=YES;
            
        }
    }
}
#pragma mark - 滚动视图监听事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    ////    DLog(@"=-=--------%f",scrollView.contentOffset.y);
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
#pragma mark - 选择玩法
-(void)dropDownListParame:(NSString *)aStr
{
    
    _playType=(int)[self.array indexOfObject:aStr];
    [self getbetPaneldata];
    [_button setTitle:[NSString stringWithFormat:@"玩法 %@",aStr] forState:UIControlStateNormal];
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
