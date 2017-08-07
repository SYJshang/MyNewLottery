
//
//  CommonViewController.m
//  PlanTo
//
//  Created by  zhang jian on 14-3-23.
//  Copyright (c) 2014年 DoubleCat. All rights reserved.
//

#import "TPKeyboardAvoidingTableView.h"
#import "CommonViewController.h"
#import "MBProgressHUD.h"
//#import "NavViewController.h"
//#import "LoginViewController.h"
#define HTTP_TIMEOUT            3
#define kServerBusyErrorMsg     @"请求失败"


@interface CommonViewController(){
    
}
@property (strong, nonatomic) NSMutableArray *snChildControllers;
@property (unsafe_unretained, nonatomic) CommonViewController *snParentController;
@property (strong, nonatomic) UIView *leftViewNoIcon;
@property (strong, nonatomic) UIView *leftView;
@property (strong, nonatomic) UIImageView *leftIcon;
@property (strong, nonatomic) UILabel *leftTitleLbl;
@property (strong, nonatomic) UITapGestureRecognizer *leftTap;

@end

@implementation CommonViewController

@synthesize  tableView = _tableView;

@synthesize  groupTableView = _groupTableView;

@synthesize tpTableView = _tpTableView;

@synthesize  dlgTimer = _dlgTimer;

@synthesize isNeedBackItem = _isNeedBackItem;

@synthesize rightBtnItem = _rightBtnItem;


+ (id)controller
{
    return [[self alloc] init];
}

- (id)init{
    
    self = [super init];
    
    if (self) {
        self.title = @"";
        self.isSearchLeftItem = YES;
        self.isNeedBackItem = YES;
        self.isNeedBackIcon = YES;
        self.hasNav = YES;
        self.iOS7FullScreenLayout = NO;
        self.isSearchLeftItem = NO;
        
        CGRect rect = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
        
        mywidth = rect.size.width;
        myheight = rect.size.height;
        
    }
    return self;
}

- (void)setIOS7FullScreenLayout:(BOOL)iOS7FullScreenLayout
{
    _iOS7FullScreenLayout = iOS7FullScreenLayout;
    if (IOS7_OR_LATER)
    {
        if (_iOS7FullScreenLayout)
        {
            self.edgesForExtendedLayout = UIRectEdgeAll;
            self.extendedLayoutIncludesOpaqueBars = NO;
            self.automaticallyAdjustsScrollViewInsets = YES;
        }
        else
        {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars = NO;
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
}

- (void)HttpRelease
{
    
}


- (void)dealloc
{
    TT_RELEASE_SAFELY(_rightBtnItem);
    
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
    TT_RELEASE_SAFELY(_tableView);
    
    _groupTableView.dataSource = nil;
    _groupTableView.delegate = nil;
    TT_RELEASE_SAFELY(_groupTableView);
    
    _tpTableView.dataSource = nil;
    _tpTableView.delegate = nil;
    TT_RELEASE_SAFELY(_tpTableView);
    
    [_dlgTimer invalidate];
    TT_RELEASE_SAFELY(_dlgTimer);
    
    TT_RELEASE_SAFELY(_pageInTime);
    
    TT_RELEASE_SAFELY(_specialViewTitle);
    
    [self HttpRelease];
}

- (void)showRightSideView
{
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
//    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    
    
    
    //    self.navigationItem.leftBarButtonItem = nil;
    //    self.navigationItem.hidesBackButton = YES;
    //    self.navigationItem.leftBarButtonItems = nil;
//    隐藏导航栏UINavigationBar黑线
//    [[UINavigationBar appearance]  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    if (self.isNeedBackItem) {
        [self addLeftItem];
    }
}
- (void)addLeftTitle:(BOOL)isHasLeftBtn WithTitle:(NSString*)string WithController:(id)controller
{
    if(isHasLeftBtn == YES)
    {
        if(!IsStrEmpty(self.title))
        {
            
            UILabel *lbl = [[UILabel alloc] init];
            if(string.length > 7)
            {
                lbl.frame = CGRectMake(0, 0, 110, 20);
                
            }
            else
            {
                lbl.frame = CGRectMake(0, 0, 50, 20);
                
            }
            lbl.text = string;
            lbl.textColor = [UIColor whiteColor];
            lbl.textAlignment = NSTextAlignmentLeft;
            lbl.userInteractionEnabled = YES;
            lbl.backgroundColor = [UIColor clearColor];
            lbl.font = [UIFont systemFontOfSize:15];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backForePage)];
            [lbl addGestureRecognizer:tap];
            
            UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:lbl];
            
            
            UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_back"]];
            imageV.contentMode = UIViewContentModeScaleAspectFit;
            imageV.frame = CGRectMake(0, 0, 10, 10);
            UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backForePage)];
            [imageV addGestureRecognizer:tap2];
            
            UIBarButtonItem *left1 = [[UIBarButtonItem alloc] initWithCustomView:imageV];
            
            
            self.navigationItem.leftBarButtonItems = @[left1,left];
            
        }
        else
        {
            UILabel *lbl = [[UILabel alloc] init];
            lbl.frame = CGRectMake(0, 0, 200, 20);
            lbl.text = string;
            lbl.textColor = [UIColor whiteColor];
            lbl.font = [UIFont systemFontOfSize:15];
            lbl.textAlignment = NSTextAlignmentLeft;
            lbl.userInteractionEnabled = YES;
            lbl.backgroundColor = [UIColor clearColor];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backForePage)];
            [lbl sizeToFit];
            [lbl addGestureRecognizer:tap];
            
            UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:lbl];
            
            
            UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_back"]];
            imageV.frame = CGRectMake(0, 0, 10, 15);
            UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backForePage)];
            [imageV addGestureRecognizer:tap2];
            
            UIBarButtonItem *left1 = [[UIBarButtonItem alloc] initWithCustomView:imageV];
            
            
            self.navigationItem.leftBarButtonItems = @[left1,left];
            
        }
        
    }
    else
    {
        UILabel *lbl = [[UILabel alloc] init];
        lbl.frame = CGRectMake(0, 0, 200, 20);
        lbl.text = string;
        lbl.textColor = [UIColor whiteColor];
        lbl.userInteractionEnabled = YES;
        
        
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:lbl];
        self.navigationItem.leftBarButtonItem = left;
    
    }
    
    
}

- (void)addSearchLeftitem
{
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.frame = CGRectMake(0, 0, 30, 44);
    left.backgroundColor = [UIColor clearColor];
    [left addTarget:self action:@selector(backForePage) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_back"]];
    arrow.frame = CGRectMake(-10,(44 - 24) / 2.0, 21, 24);
    arrow.backgroundColor = [UIColor clearColor];
    
    [left addSubview:arrow];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:left];
}

- (void)addLeftItem
{
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.frame = CGRectMake(0, 0, 44, 44);
    left.backgroundColor = [UIColor clearColor];
    [left addTarget:self action:@selector(backForePage) forControlEvents:UIControlEventTouchUpInside];

    UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"all_return_icon"]];
    arrow.contentMode = UIViewContentModeScaleAspectFit;
    arrow.frame = CGRectMake(-6,(44 - 30) / 2.0, 21, 30);
    arrow.backgroundColor = [UIColor clearColor];
    
    UILabel *back = [[UILabel alloc] initWithFrame:CGRectMake(arrow.right, 7, 20, 30)];
    back.text = @"";
    back.textColor = [UIColor whiteColor];
    back.backgroundColor = [UIColor clearColor];
    [left addSubview:back];
    [left addSubview:arrow];
    if (self.isNeedBackIcon) {
        UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_ant_icon.png"]];
        icon.frame = CGRectMake(15, 5, 83.5, 32);
        icon.backgroundColor = [UIColor clearColor];
        [left addSubview:icon];
    }
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:left];
}

- (void)backForePage
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)loadView
{
    [super loadView];
    [self.view setExclusiveTouch:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = BgColor;
    _tableView.backgroundColor = BgColor;
    _groupTableView.backgroundColor = BgColor;
    _tpTableView.backgroundColor = BgColor;
}

- (void)goToLogin
{
    dispatch_async(dispatch_get_main_queue(), ^{

        
//        LoginViewController *VC = [[LoginViewController alloc] init];
//        VC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:VC animated:YES];
    });
}

- (void)setDlgTimer:(NSTimerHelper *)dlgTimer
{
    if (dlgTimer != _dlgTimer) {
        TT_INVALIDATE_TIMER(_dlgTimer);
        _dlgTimer = dlgTimer;
    }
}

- (void)displayOverFlowActivityView:(NSString*)indiTitle
{
    
    [self.view showHUDIndicatorViewAtCenter:indiTitle];
    
    self.dlgTimer = [NSTimerHelper scheduledTimerWithTimeInterval:HTTP_TIMEOUT*1.5
                                                           target:self
                                                         selector:@selector(timeOutRemoveHUDView)
                                                         userInfo:nil
                                                          repeats:NO];
    
    return;
    
}

- (void)displayOverFlowActivityView:(NSString *)indiTitle maxShowTime:(CGFloat)time
{
    [self.view showHUDIndicatorViewAtCenter:indiTitle];
    
    if (time > 0.0f) {
        self.dlgTimer = [NSTimerHelper scheduledTimerWithTimeInterval:time*1.5
                                                               target:self
                                                             selector:@selector(timeOutRemoveHUDView)
                                                             userInfo:nil
                                                              repeats:NO];
    }else{
        self.dlgTimer = nil;
    }
    
    return;
}


- (void)displayOverFlowActivityView{
    
    [self.view showHUDIndicatorViewAtCenter:L(@"加载中")];
    
    self.dlgTimer = [NSTimerHelper scheduledTimerWithTimeInterval:HTTP_TIMEOUT*1.5
                                                           target:self
                                                         selector:@selector(timeOutRemoveHUDView)
                                                         userInfo:nil
                                                          repeats:NO];
    
    return;
    
}

- (void)displayOverFlowActivityView:(NSString*)indiTitle yOffset:(CGFloat)y{
    
    [self.view showHUDIndicatorViewAtCenter:indiTitle yOffset:y];
    
    self.dlgTimer = [NSTimerHelper scheduledTimerWithTimeInterval:HTTP_TIMEOUT*1.5
                                                           target:self
                                                         selector:@selector(timeOutRemoveHUDView)
                                                         userInfo:nil
                                                          repeats:NO];
    
    return;
    
}

- (void)successRemoveHUDView
{
    [self.view hideHUDIndicatorViewAtCenter];
}

- (void)timeOutRemoveHUDView
{
    [self.view hideHUDIndicatorViewAtCenter];
}


- (void)timerOutRemoveOverFlowActivityView
{
    
    [self.view hideActivityViewAtCenter ];
    
    return;
    
    
}

- (void)removeOverFlowActivityView
{
    [self.view hideHUDIndicatorViewAtCenter];
    
    TT_INVALIDATE_TIMER(_dlgTimer);
    
}

- (void)presentSheet:(NSString*)indiTitle{
    
    if (!indiTitle.length)
    {
//        indiTitle = kServerBusyErrorMsg;
    } else {
        [self.view showTipViewAtCenter:indiTitle];
    }
    
}


- (void)presentSheet:(NSString*)indiTitle posY:(CGFloat)y{
    
    if (!indiTitle.length)
    {
        indiTitle = kServerBusyErrorMsg;
    }
    [self.view showTipViewAtCenter:indiTitle posY:y];
    
}

- (void)presentSheetOnNav:(NSString *)indiTitle
{
    [self.navigationController.view showTipViewAtCenter:indiTitle];
}


//添加可展示两行的sheet
- (void)presentSheet:(NSString *)indiTitle subMessage:(NSString *)msg
{
    [self.view showTipViewAtCenter:indiTitle message:msg];
}

- (void)presentSheet:(NSString *)indiTitle subMessage:(NSString *)msg posY:(CGFloat)y
{
    [self.view showTipViewAtCenter:indiTitle message:msg posY:y];
}

- (void)presentCustomDlg:(NSString *)indiTitle
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:indiTitle delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}


- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
}

- (UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        [_tableView setIndicatorStyle:UIScrollViewIndicatorStyleDefault];
        _tableView.scrollEnabled = YES;
        _tableView.userInteractionEnabled = YES;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.backgroundView = nil;
        _tableView.sectionHeaderHeight = 0.f;
        _tableView.sectionFooterHeight = 0.f;
        _tableView.showsHorizontalScrollIndicator = false;
        _tableView.showsVerticalScrollIndicator = true;
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = view;
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


- (TPKeyboardAvoidingTableView *)tpTableView
{
    if(!_tpTableView)
    {
        _tpTableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tpTableView.delegate =self;
        [_tpTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
        _tpTableView.scrollEnabled = YES;
        _tpTableView.userInteractionEnabled = YES;
        _tpTableView.backgroundColor = [UIColor clearColor];
        _tpTableView.backgroundView = nil;
        _tpTableView.sectionHeaderHeight = 0.f;
        _tpTableView.sectionFooterHeight = 0.f;
        _tpTableView.dataSource =self;
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        _tpTableView.tableFooterView = view;
        
        [self.view addSubview:_tpTableView];
    }
    return _tpTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    DLog(@"Commmon didReceiveMemoryWarning \n");
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)presentModalViewController:(UIViewController *)modalViewController animated:(BOOL)animated
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
        [super presentViewController:modalViewController animated:animated completion:NULL];
    }else{
        [super presentModalViewController:modalViewController animated:animated];
    }
}


#pragma mark -
#pragma mark utils

- (CGRect)visibleBoundsShowNav:(BOOL)hasNav showTabBar:(BOOL)hasTabBar
{
    if (IOS7_OR_LATER && self.isIOS7FullScreenLayout)
    {
        //全屏布局
        CGRect frame = [[UIScreen mainScreen] bounds];
        return frame;
    }
    else
    {
        CGRect frame = [[UIScreen mainScreen] bounds];
        frame.size.height -= 20;
        if (hasNav) {
            frame.size.height -= 44;
        }
        if (hasTabBar) {
            frame.size.height -= 48;
        }
        return frame;
    }
}

#pragma mark ----------------------------- ios7 兼容

#ifdef __IPHONE_7_0

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

#endif



@end
