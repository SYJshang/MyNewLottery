//
//  HomeViewController.m
//  longzhicai
//
//  Created by 夏云飞 on 2017/2/4.
//  Copyright © 2017年 xyf. All rights reserved.
//
#import "HomeViewController.h"
#import "LoopCollectionCell.h"
#import "FounctionCollectionCell.h"
#import "ClassifyViewCell.h"
#import "MyHeaderView.h"
#import "MyHeaderTwoView.h"
#import "MyFooterView.h"
#import "TopTiaoViewCell.h"
#import "ShufflingModel.h"
#import "GameListModel.h"
#import "WebViewController.h"
//#import "DepositViewController.h"
#import "MovementsController.h"
#import "LotteryRoomController.h"

#import "ThreeColorController.h"
#import "BJRacingPkController.h"
#import "LuckTwentyEightController.h"
#import "CQTimeColorController.h"
#import "PCBallsController.h"
#import "GDHappyTenController.h"
#import "NoticeView.h"
#import "XJTimeColorController.h"
#import "TJTimeColorController.h"
#import "HappyPokerController.h"
#import "GDPickController.h"
#import "JSThreeController.h"
#import "GXHappyTenController.h"
#import "SixLotteryController.h"
//#import "NoNetView.h"
#import "TestViewController.h"
#import "WebViewController.h"


@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,loopCollectionDelegate,NoticeViewDelegate>
{
    NSMutableArray          *_categoryArray;    // 轮播
    NSMutableArray          *_gamelistArray;    // 游戏列表
    NSMutableArray          *_latestArray;      // 最新中奖
    NSMutableArray          *_noticeArray;      // 广告

    NSString                *_isshow;           //是否隐藏 1是不显示 0是显示
    
    NSString                *_prourl;           //常见问题url
    NSString                *_youhuiurl;        //优惠url
    NSString                *_lunbourl;        //轮播url
    NSString                *_guangbourl;        //广告url

    
}
@property (nonatomic, strong) UICollectionView     *collectioView; // 主视图
//@property (nonatomic, strong) NoNetView     *nonetview; //没网显示的视图



@end

@implementation HomeViewController
-(instancetype)init {
    self = [super init];
    if (self) {
        self.isNeedBackItem = NO;
        _categoryArray = [NSMutableArray array];
        _gamelistArray = [NSMutableArray array];
        _latestArray   = [NSMutableArray array];
        _noticeArray   = [NSMutableArray array];

    }
    return self;
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
//    [SVProgressHUD dismiss];
    
    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];

//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [SVProgressHUD dismiss];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

}


- (void)viewDidLoad {
    [super viewDidLoad];
//    _gamelistArray = [NSMutableArray arrayWithArray:[MyConfig currentConfig].GameArray];
    
//    ShufflingModel*model = [[ShufflingModel alloc]init];
//    model.img=@"";
//    [_categoryArray addObject:model];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"loading..."];

    
    
//    缓存游戏列表
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString*gamelist=[userDefaultes stringForKey:@"gamelistArray"];
    if (!IsStrEmpty(gamelist)) {
        NSDictionary*dict=[self dictionaryWithJsonString:gamelist];
        NSArray * items = dict[@"gamelist"];
        NSMutableArray *array = [NSMutableArray array];
        array = [GameListModel mj_objectArrayWithKeyValuesArray:items];
        _gamelistArray = array;
        
        
    }
    
    NSMutableArray *arr = [[userDefaultes objectForKey:@"categoryArray"] mutableCopy];
    if (arr.count > 0) {
        _categoryArray = arr;
    }
//    if (!IsStrEmpty(category)) {
//        NSDictionary*dict=[self dictionaryWithJsonString:category];
//        NSArray * items = dict[@"items"];
//        NSMutableArray *array = [NSMutableArray array];
//        array = [ShufflingModel mj_objectArrayWithKeyValuesArray:items];
//        _categoryArray = array;        
//        
//    }

    
    
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    if ([currentVersion isEqualToString:@"1.0.0"]) {
        [self loadConfigData];
    }else{
        [MyConfig currentConfig].show = @"1";
        _isshow=[MyConfig currentConfig].show;
        [self.view addSubview:self.collectioView];
        [self getCategoryData];
//        [self.view addSubview:self.nonetview];
    }
    
    

    
    

}

#pragma mark -    //加载配置控制显示
- (void)loadConfigData {
    
    
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    NSDictionary *params = @{@"device":@"1",   //设备类型 1是iOS 2是安卓
                             @"ver":currentVersion,
                             @"u":[MyConfig currentConfig].userU
                             };
    [[HttpManager manager]requestPostURL:HTTP_baseData_loadConfig withParams:params withTarget:self withHud:YES withSuccessBlock:^(id responseObject) {
        NSDictionary *dic = responseObject;
        DLog(@"加载配置----%@----%@",responseObject,responseObject[@"msg"]);
        if ([EncodeFormDic(dic, @"code") isEqualToString:@"200"]) {
            
            [MyConfig currentConfig].show = dic[@"data"][@"show"];
//            [MyConfig currentConfig].show = @"0";
            _isshow=[MyConfig currentConfig].show;
            [self.view addSubview:self.collectioView];
//            [self.view addSubview:self.nonetview];

            [self getCategoryData];
        }
    } withFailureBlock:^(NSError *error) {
        [MyConfig currentConfig].show =@"1";
        _isshow=[MyConfig currentConfig].show;
        [self.view addSubview:self.collectioView];
//        [self.view addSubview:self.nonetview];

        [self getCategoryData];
        
    }];
}


-(UICollectionView *)collectioView
{
    if (_collectioView == nil)
    {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        _collectioView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectioView.alwaysBounceVertical = YES;
        _collectioView.delegate = self;
        _collectioView.dataSource = self;
        _collectioView.scrollEnabled = YES;
        _collectioView.backgroundColor = [UIColor whiteColor];
        _collectioView.showsHorizontalScrollIndicator = false;
        _collectioView.showsVerticalScrollIndicator = false;
        _collectioView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        // 轮播
        [_collectioView registerClass:[LoopCollectionCell class] forCellWithReuseIdentifier:@"loopViewCell"];
        // 四大类
        [_collectioView registerClass:[FounctionCollectionCell class] forCellWithReuseIdentifier:@"founctionCell"];
    
        //彩种
        [_collectioView registerClass:[ClassifyViewCell class]forCellWithReuseIdentifier:@"ClassifyViewCell"];
        //跑马灯显示
        [_collectioView registerClass:[TopTiaoViewCell class]forCellWithReuseIdentifier:@"TopTiaoViewCell"];
        
        //注册页眉内容彩种
        [_collectioView registerClass:[MyHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SectionHeaderDataView"];
        
 [_collectioView registerClass:[NoticeView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"NoticeView"];
    
        [_collectioView registerClass:[MyHeaderTwoView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SectionHeaderDataTwoView"];
        
        //注册页脚内容
        [_collectioView registerClass:[MyFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"SectionFooterDataView"];
        [self addRefreshView];
        
    }
    return _collectioView;
}
- (void)addRefreshView
{
    __weak __typeof(self) weakSelf = self;
    _collectioView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getCategoryData];
    }];
    
}
#pragma mark -请求轮播图数据
- (void)getCategoryData {
    

    
    if (_categoryArray.count > 0) {
        [_categoryArray removeAllObjects];
    }
    
    NSDictionary * dicts = @{@"pageNo":@"0",
                            @"pageSize":@"4"};
    
    [SYJHttpHelper Post:@"https://www.h1055.com/banner/bannerInfo.do" parameters:dicts success:^(id responseObject) {
        
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        SYJLog(@"%@",data);
        if ([data[@"errorcode"] isEqualToString:@"0"]) {
            
            NSArray *arr = data[@"result"];
            for (int i = 0; i < arr.count ; i++) {
                NSDictionary *dict = arr[i];
                [_categoryArray addObject:dict[@"imgUrl"]];
            }
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:_categoryArray forKey:@"categoryArray"];


            
            [self getgamelistdata];
//            [self getnoticeData];
            
        }
        
    } failure:^(NSError *error) {
        
        [self presentSheet:NetErrorMsg];
        [_collectioView.mj_header endRefreshing];
        [SVProgressHUD dismiss];
        
    }];
    
//    NSDictionary * dict = @{@"adType":@"1"};
//    [[HttpManager manager] requestGetURL:HTTP_home_advert withParams:dict withTarget:self withHud:YES withSuccessBlock:^(id responseObject) {
//        DLog(@"-----= %@", responseObject)
//        
//        if ([responseObject[@"code"] isEqualToString:@"200"]) {
//            NSArray * items = responseObject[@"data"][@"items"];
//            NSMutableArray *array = [NSMutableArray array];
//            array = [ShufflingModel mj_objectArrayWithKeyValuesArray:items];
//            _categoryArray = array;
//            
//            
//
////        _nonetview.hidden=YES;
//
//        
//    } withFailureBlock:^(NSError *error) {
//        
////        _nonetview.hidden=NO;
//
//       
//    }];
    
}

#pragma mark -首页通知
- (void)getnoticeData {
    
    [_noticeArray removeAllObjects];
    [[HttpManager manager] requestGetURL:HTTP_baseData_notice withParams:nil withTarget:self withHud:YES withSuccessBlock:^(id responseObject) {
        DLog(@"-----= %@", responseObject)
        
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            NSArray * items = responseObject[@"data"][@"items"];
            NSMutableArray *array = [NSMutableArray array];
            array = [ShufflingModel mj_objectArrayWithKeyValuesArray:items];
            _noticeArray = array;
            
        }
                [_collectioView reloadData];
//                [_collectioView.mj_header endRefreshing];
        
    } withFailureBlock:^(NSError *error) {
        [self presentSheet:NetErrorMsg];
        [_collectioView.mj_header endRefreshing];
    }];
    
}

#pragma mark -请求游戏列表
-(void)getgamelistdata{

    [_gamelistArray removeAllObjects];
    [[HttpManager manager] requestGetURL:HTTP_home_gameColumn withParams:nil withTarget:self withHud:YES withSuccessBlock:^(id responseObject) {
        DLog(@"-----= %@", responseObject)
        
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            NSArray * items = responseObject[@"data"][@"gamelist"];
            NSMutableArray *array = [NSMutableArray array];
            array = [GameListModel mj_objectArrayWithKeyValuesArray:items];
            _gamelistArray = array;
           
            NSDictionary*data=responseObject[@"data"];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:[self dictionaryToJson:data] forKey:@"gamelistArray"];
            

        }
        [self getlatestwinnersdata];
    } withFailureBlock:^(NSError *error) {
        [_collectioView.mj_header endRefreshing];
        [SVProgressHUD dismiss];
    }];
}
#pragma mark -请求最新中奖
-(void)getlatestwinnersdata{
    
    [_latestArray removeAllObjects];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"1" forKey:@"device"];//设备类型 1=IOS 2=安卓
    [dict setValue:[NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"] forKey:@"ver"];//版本号
    
    [[HttpManager manager] requestGetURL:HTTP_home_winList withParams:dict withTarget:self withHud:YES withSuccessBlock:^(id responseObject) {
        DLog(@"-----= %@", responseObject)
        
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            NSArray * items = responseObject[@"data"][@"winlist"];
            for(int i = 0; i < items.count; i++){
                NSString*str;
                str=[items objectAtIndex:i];
                [_latestArray addObject:str];
            }
//            _latestArray = [NSMutableArray arrayWithArray:items];
        }
        
//        DLog(@"-=-=----  %@",[_latestArray objectAtIndex:0]);
        
        [SVProgressHUD dismiss];
        [_collectioView reloadData];
        [_collectioView.mj_header endRefreshing];
    } withFailureBlock:^(NSError *error) {
        [self presentSheet:NetErrorMsg];
        [_collectioView.mj_header endRefreshing];
    }];
    
}

#pragma mark - 创建 UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 4;
}

//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if (section == 0)
    {
        return 1;
    }
    else if (section == 1)
    {
        _isshow = @"1";
        if ([_isshow isEqualToString:@"1"]) {
            return 3;
        }else{
        return 4;
        }
    }
    else if (section == 2)
    {
        return _gamelistArray.count;
    }
    else if (section == 3)
    {
        return 1;
    }
    
    return 0;
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        //轮播
        return CGSizeMake(MSW, MSW/2.0);
    }
    else if (indexPath.section == 1)
    {
        // 四大类
        _isshow = @"1";
        if ([_isshow isEqualToString:@"1"]) {
            return CGSizeMake(MSW/3-1,70);
        }
        else{
        
            return CGSizeMake(MSW/4-0.5,70);
        }
    }
    else if (indexPath.section==2)
    {
        // 彩种
        return CGSizeMake(MSW/2 , 80);
    }
    else if (indexPath.section==3)
    {
        // 跑马灯
        return CGSizeMake(MSW, 135);
    }
    
    return CGSizeMake(0, 0);
}

//返回头headerView的大小(页眉)
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0 )
    {
        return CGSizeMake(0, 0);
    }
    else if (section == 1 )
    {
        return CGSizeMake(MSW, 50);
    }
    else if (section == 2 )
    {
        return CGSizeMake(MSW, 35);
    }
    else if (section == 3 )
    {
        return CGSizeMake(MSW, 35);
    }
    
    return CGSizeMake(0, 0);
}
//设定页脚的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 1)
    {
        return CGSizeMake(0, 10);
    }
    else if (section == 2)
    {
        return CGSizeMake(0, 10);
    }
    return CGSizeMake(0, 0);
}

//定义每个Section 的 四边间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    if (section==1) {
        return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
    }else{
    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
}
}
//每个section中不同的行之间的行间距（纵向间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    // 每一个CollectionViewCell的下部间距，最小距离
    return 0.0;
}

//每个item之间的间距 (横向间距)
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    // 每一个CollectionViewCell的左边间距距离，最小距离
    return 0.0;
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView =nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        if (indexPath.section == 2 )
        {
            MyHeaderView * sectionHeaderView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SectionHeaderDataView" forIndexPath:indexPath];
            sectionHeaderView.backgroundColor = [UIColor whiteColor];
            reusableView = sectionHeaderView;
            
        }else if (indexPath.section==1){
        
            NoticeView * sectionHeaderView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"NoticeView" forIndexPath:indexPath];
            sectionHeaderView.backgroundColor = [UIColor whiteColor];
            reusableView = sectionHeaderView;
            sectionHeaderView.delegate=self;
            sectionHeaderView.NoticeArray= @[@"欢迎使用,签到送积分哦~~~~~",@"升级积分等级，参与模拟积分购买彩票，赢取更多积分~"];

            
        }
        else if (indexPath.section == 3)
        {
            MyHeaderTwoView * sectionHeaderView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SectionHeaderDataTwoView" forIndexPath:indexPath];
            sectionHeaderView.backgroundColor = [UIColor whiteColor];
            reusableView = sectionHeaderView;
        }
    }
    else
    {
        if (kind == UICollectionElementKindSectionFooter)
        {
            if (indexPath.section == 1 || indexPath.section == 2)
            {
                MyFooterView * sectionFooterView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"SectionFooterDataView" forIndexPath:indexPath];
                sectionFooterView.backgroundColor = [UIColor groupTableViewBackgroundColor];
                reusableView = sectionFooterView;
                sectionFooterView.backgroundColor=[UIColor colorWithHex:@"#f1f1f1"];
            }
            
        }
    }
    
    return reusableView;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {  // 轮播
        LoopCollectionCell * cell =(LoopCollectionCell*) [collectionView dequeueReusableCellWithReuseIdentifier : @"loopViewCell" forIndexPath :indexPath];
        cell.delegate = self;
        
        if ( _categoryArray.count > 0 )
        {
            [cell cellWithArray:_categoryArray];
        }
        return cell;
    }
    else if (indexPath.section ==1)  // 4大类
    {
        FounctionCollectionCell * cell =(FounctionCollectionCell*) [collectionView dequeueReusableCellWithReuseIdentifier : @"founctionCell" forIndexPath :indexPath];
        
        _isshow = @"1";
        if ([_isshow isEqualToString:@"1"]) {
            if (indexPath.row==2){
                cell.rightview.hidden=NO;
                cell.leftview.hidden=YES;
                cell.menuImgV.image=[UIImage imageNamed:@"常见问题"];
                cell.titlelab.text=@"常见问题";
                
            }else if (indexPath.row==0){
                cell.rightview.hidden=YES;
                cell.leftview.hidden=NO;
                cell.menuImgV.image=[UIImage imageNamed:@"优惠活动"];
                cell.titlelab.text=@"活动";
            }
            else{
                cell.rightview.hidden=YES;
                cell.leftview.hidden=YES;
                cell.menuImgV.image=[UIImage imageNamed:@"走势"];
                cell.titlelab.text=@"走势";
                
            }
        }else{
            if (indexPath.row==0) {
                cell.leftview.hidden=NO;
                cell.rightview.hidden=YES;
                cell.menuImgV.image=[UIImage imageNamed:@"home_deposit"];
                cell.titlelab.text=@"存取款";
            }else if (indexPath.row==3){
                cell.rightview.hidden=NO;
                cell.leftview.hidden=YES;
                cell.menuImgV.image=[UIImage imageNamed:@"home_problems"];
                cell.titlelab.text=@"常见问题";
                
            }else if (indexPath.row==1){
                cell.rightview.hidden=YES;
                cell.leftview.hidden=YES;
                cell.menuImgV.image=[UIImage imageNamed:@"home_preferential"];
                cell.titlelab.text=@"优惠活动";
            }
            else{
                cell.rightview.hidden=YES;
                cell.leftview.hidden=YES;
                cell.menuImgV.image=[UIImage imageNamed:@"home_movements"];
                cell.titlelab.text=@"走势";
                
            }
        }
        
        
        
        return cell;
    }
    else if (indexPath.section == 2) // 彩种
    {
        static NSString * CellIdentifier = @"ClassifyViewCell";
        ClassifyViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        if (_gamelistArray.count>0) {
            GameListModel*model=[_gamelistArray objectAtIndex:indexPath.row];
            cell.gameModel=model;
        }
        
        return cell;
    }
    else if (indexPath.section == 3) // 跑马灯
    {
        
        TopTiaoViewCell * cell =(TopTiaoViewCell*) [collectionView dequeueReusableCellWithReuseIdentifier : @"TopTiaoViewCell" forIndexPath :indexPath];
        NSArray *Array = [_latestArray copy];
        cell.titlearray=Array;
        return cell;
    }
    
    return nil;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
//    [MusicHelper showclickmusic];

    DLog(@"-=-=  %li----%li",indexPath.section,indexPath.row);
    if (indexPath.section==1) {
        if ([_isshow isEqualToString:@"1"]) {
            if (indexPath.row==0){
                [self getFavourableactivity];
            }else if (indexPath.row==1){
                MovementsController * Movements = [[MovementsController alloc] init];
                Movements.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:Movements animated:NO];
                
            }else{
//                [self getCommonproblems];
                TestViewController * Movements = [[TestViewController alloc] init];
                Movements.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:Movements animated:NO];
            }
        }
        else{
            if (indexPath.row==0) {
                if (IsStrEmpty([MyConfig currentConfig].userU)) {                            [self goToLogin];
                }else{
//                    DepositViewController * deposit = [[DepositViewController alloc] init];
//                    deposit.hidesBottomBarWhenPushed = YES;
//                    [self.navigationController pushViewController:deposit animated:YES];
                }
            }else if (indexPath.row==1){
                [self getFavourableactivity];
            }else if (indexPath.row==2){
                MovementsController * Movements = [[MovementsController alloc] init];
                Movements.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:Movements animated:YES];
                
            }else{
//                [self getCommonproblems];
                TestViewController * Movements = [[TestViewController alloc] init];
                Movements.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:Movements animated:YES];
            }
        
        }
        
        
 
        
    }else if (indexPath.section==2)
    {
        GameListModel *model;
        if (_gamelistArray) {
        
            model = _gamelistArray[indexPath.row];

        }
//  游戏类型， 0=三份彩 1=北京赛车 2=幸运28 3 = 重庆时时彩 4 = PC蛋蛋 5 = 广东快乐10分
        if ([model.type isEqualToString:@"0"]) {//0=三份彩
            
            ThreeColorController *setVC = [[ThreeColorController alloc] init];
            setVC.cometype=@"1";
            setVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:setVC animated:NO];
        }else if ([model.type isEqualToString:@"1"]){//1=北京赛车
            BJRacingPkController *setVC = [[BJRacingPkController alloc] init];
            setVC.cometype=@"1";
            setVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:setVC animated:NO];
            
        }else if ([model.type isEqualToString:@"2"]){//2=幸运28
            
            LuckTwentyEightController *setVC = [[LuckTwentyEightController alloc] init];
            setVC.cometype=@"1";
            setVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:setVC animated:NO];
        }else if ([model.type isEqualToString:@"3"]){//3=重庆时时彩
            
            CQTimeColorController *setVC = [[CQTimeColorController alloc] init];
            setVC.hidesBottomBarWhenPushed = YES;
            setVC.cometype=@"1";
            [self.navigationController pushViewController:setVC animated:NO];
            
        }else if ([model.type isEqualToString:@"4"]){//4=PC蛋蛋
            
            PCBallsController *setVC = [[PCBallsController alloc] init];
            setVC.hidesBottomBarWhenPushed = YES;
            setVC.cometype=@"1";
            [self.navigationController pushViewController:setVC animated:NO];
        }else if ([model.type isEqualToString:@"5"]){//广东快乐10分
            
            GDHappyTenController *setVC = [[GDHappyTenController alloc] init];
            setVC.hidesBottomBarWhenPushed = YES;
            setVC.cometype=@"1";
            [self.navigationController pushViewController:setVC animated:NO];
        }else if ([model.type isEqualToString:@"6"]){//广东快乐10分
            
            TJTimeColorController *setVC = [[TJTimeColorController alloc] init];
            setVC.hidesBottomBarWhenPushed = YES;
            setVC.cometype=@"1";
            [self.navigationController pushViewController:setVC animated:NO];
        }
        else if ([model.type isEqualToString:@"7"]){//广东快乐10分
            
            XJTimeColorController *setVC = [[XJTimeColorController alloc] init];
            setVC.hidesBottomBarWhenPushed = YES;
            setVC.cometype=@"1";
            [self.navigationController pushViewController:setVC animated:NO];
        }
        else if ([model.type isEqualToString:@"8"]){//广东快乐10分
            
            HappyPokerController *setVC = [[HappyPokerController alloc] init];
            setVC.hidesBottomBarWhenPushed = YES;
            setVC.cometype=@"1";
            [self.navigationController pushViewController:setVC animated:NO];
        }else if ([model.type isEqualToString:@"9"]){//广东11选5
            
            GDPickController *setVC = [[GDPickController alloc] init];
            setVC.hidesBottomBarWhenPushed = YES;
            setVC.cometype=@"1";
            [self.navigationController pushViewController:setVC animated:NO];
        }else if ([model.type isEqualToString:@"10"]){//江苏快三
            
            JSThreeController *setVC = [[JSThreeController alloc] init];
            setVC.hidesBottomBarWhenPushed = YES;
            setVC.cometype=@"1";
            [self.navigationController pushViewController:setVC animated:NO];
        }else if ([model.type isEqualToString:@"11"]){//广西快乐10
            
            GXHappyTenController *setVC = [[GXHappyTenController alloc] init];
            setVC.hidesBottomBarWhenPushed = YES;
            setVC.cometype=@"1";
            [self.navigationController pushViewController:setVC animated:NO];
        }else if ([model.type isEqualToString:@"12"]){//六合彩
            
            SixLotteryController *setVC = [[SixLotteryController alloc] init];
            setVC.hidesBottomBarWhenPushed = YES;
            setVC.cometype=@"1";
            [self.navigationController pushViewController:setVC animated:NO];
        }

        else{
            [self presentSheet:@"敬请期待！"];
        }
        
        
        

//        LotteryRoomController *LotteryVC = [[LotteryRoomController alloc] init];
//        LotteryVC.hidesBottomBarWhenPushed = YES;
//        LotteryVC.lotterytype=model.type;
//        [self.navigationController pushViewController:LotteryVC animated:YES];
    }else if (indexPath.section==3){
    
    
    }
    
}
#pragma mark - 轮播代理事件 Click Event
-(void)touchLoopAdverEvent:(NSInteger)index
{
//    ShufflingModel*model=[_categoryArray objectAtIndex:index];
//    if ([model.type isEqualToString:@"2"]) {
//        
//        if (!IsStrEmpty(model.link)) {
////            TopupWebviewController *webVC = [[TopupWebviewController alloc] init];
////            webVC.hidesBottomBarWhenPushed = YES;
////            webVC.urlstr=model.link;
////            [self.navigationController pushViewController:webVC animated:YES];
//        }
//    }
    
}
#pragma mark - 广告轮播
-(void)clicknotieindex:(NSInteger)index{
    


}

#pragma mark - 请求常见问题
-(void)getCommonproblems{
    [[HttpManager manager] requestGetURL:HTTP_baseData_question withParams:nil withTarget:self withHud:NO withSuccessBlock:^(id responseObject) {
        
        
        DLog(@"-=-=-=%@",responseObject);
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
       NSString* _linkStr = responseObject[@"data"][@"link"];
            _prourl=_linkStr;
//            TopupWebviewController *webVC = [[TopupWebviewController alloc] init];
//            webVC.hidesBottomBarWhenPushed = YES;
//            webVC.urlstr=_linkStr;
//            webVC.title=@"常见问题";
//            [self.navigationController pushViewController:webVC animated:YES];
        }
    } withFailureBlock:^(NSError *error) {
        [_collectioView.mj_header endRefreshing];
//        TopupWebviewController *webVC = [[TopupWebviewController alloc] init];
//        webVC.hidesBottomBarWhenPushed = YES;
//        webVC.urlstr=_prourl;
//        webVC.title=@"常见问题";
//        [self.navigationController pushViewController:webVC animated:YES];

    }];
}
#pragma mark - 请求优惠活动
-(void)getFavourableactivity{
    [[HttpManager manager] requestGetURL:HTTP_baseData_activitie withParams:nil withTarget:self withHud:NO withSuccessBlock:^(id responseObject) {
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            NSString* _linkStr = responseObject[@"data"][@"link"];
            
            _youhuiurl=_linkStr;
            WebViewController *webVC = [[WebViewController alloc] init];
            webVC.hidesBottomBarWhenPushed = YES;
            webVC.urlstr=_linkStr;
//            webVC.title=@"优惠活动";
            [self.navigationController pushViewController:webVC animated:YES];
        }
    } withFailureBlock:^(NSError *error) {
//        TopupWebviewController *webVC = [[TopupWebviewController alloc] init];
//        webVC.hidesBottomBarWhenPushed = YES;
//        webVC.urlstr=_youhuiurl;
//        webVC.title=@"优惠活动";
//        [self.navigationController pushViewController:webVC animated:YES];

        [_collectioView.mj_header endRefreshing];
    }];
}

//-(NoNetView*)nonetview{
//    if (!_nonetview)
//    {
//        _nonetview=[[NoNetView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
//        _nonetview.hidden=YES;
//        _nonetview.navtype=@"0";
//        _nonetview.delegate=self;
//    }
//    return _nonetview;
//}
-(void)clickReload{
    [self getCategoryData];
}

//字典转json格式字符串：
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
//json格式字符串转字典：

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
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
