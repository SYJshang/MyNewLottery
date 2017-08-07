//
//  HistoryLotteryController.m
//  longzhicai
//
//  Created by lili on 2017/3/23.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import "HistoryLotteryController.h"
#import "HistoryLotteryCell.h"
#import "LotteryRoomController.h"
#import "HistoryLotteryModel.h"

#import "ThreeColorController.h"
#import "BJRacingPkController.h"
#import "LuckTwentyEightController.h"
#import "CQTimeColorController.h"
#import "PCBallsController.h"
#import "GDHappyTenController.h"
#import "XJTimeColorController.h"
#import "TJTimeColorController.h"
#import "HappyPokerController.h"
#import "PCHistoryLotteryCell.h"
#import "BJHistoryLotteryCell.h"
#import "GDPickController.h"
#import "JSThreeController.h"
#import "GXHappyTenController.h"
#import "SixLotteryController.h"
#import "SixHistoryLotteryCell.h"


@interface HistoryLotteryController ()<UITableViewDelegate,UITableViewDataSource>
{
    int                   _pageIndex;           // 当前第几页
    BOOL                  _isNoMoreData;        // 是否还有更多数据
}
@property (nonatomic, strong) UITableView          *tableview;
@property (nonatomic, strong) NSMutableArray        *dataArray;


@end

@implementation HistoryLotteryController
- (instancetype)init {
    self = [super init];
    if (self) {
        self.isNeedBackItem = YES;
        self.dataArray = [NSMutableArray array];

    }
    return self;
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [SVProgressHUD dismiss];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"历史开奖";
    [self.view addSubview:[self tableView]];
    [self addRightItem];
    [self addRefreshView];
    [self getistoryLotterydata];
}
#pragma mark -addRightItem
- (void)addRightItem
{    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0, 0, 44, 44);
    right.backgroundColor = [UIColor clearColor];
    [right setTitle:@"下注" forState:0];
    right.titleLabel.font=[UIFont systemFontOfSize:BigFont];
    [right setTitleColor:[UIColor blackColor] forState:0];
    [right addTarget:self action:@selector(betclick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
}
-(void)betclick{
    //  游戏类型， 0=三份彩 1=北京赛车 2=幸运28 3=重庆时时彩 4=PC蛋蛋 5=广东快乐10分
    if ([_lotterytype isEqualToString:@"0"]) {//0=三份彩
        
        ThreeColorController *setVC = [[ThreeColorController alloc] init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
    }else if ([_lotterytype isEqualToString:@"1"]){//1=北京赛车
        BJRacingPkController *setVC = [[BJRacingPkController alloc] init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
        
    }else if ([_lotterytype isEqualToString:@"2"]){//2=幸运28
        
        LuckTwentyEightController *setVC = [[LuckTwentyEightController alloc] init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
    }else if ([_lotterytype isEqualToString:@"3"]){//3=重庆时时彩
        
        CQTimeColorController *setVC = [[CQTimeColorController alloc] init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
        
    }else if ([_lotterytype isEqualToString:@"4"]){//4=PC蛋蛋
        
        PCBallsController *setVC = [[PCBallsController alloc] init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
    }else if ([_lotterytype isEqualToString:@"5"]){//广东快乐10分
        
        GDHappyTenController *setVC = [[GDHappyTenController alloc] init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
    }else if ([_lotterytype isEqualToString:@"6"]){//天津
        
        TJTimeColorController*setVC = [[TJTimeColorController alloc] init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
    }else if ([_lotterytype isEqualToString:@"7"]){//新疆
        
        XJTimeColorController*setVC = [[XJTimeColorController alloc] init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
    }

    else   if ([_lotterytype isEqualToString:@"8"]){//快乐扑克
        HappyPokerController *setVC = [[HappyPokerController alloc] init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
        
    }else   if ([_lotterytype isEqualToString:@"9"]){//广东11选5
        GDPickController *setVC = [[GDPickController alloc] init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
        
    }
    else   if ([_lotterytype isEqualToString:@"10"]){//江苏快三
        JSThreeController *setVC = [[JSThreeController alloc] init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
        
    }    else   if ([_lotterytype isEqualToString:@"11"]){//广西快乐10
        GXHappyTenController *setVC = [[GXHappyTenController alloc] init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
        
    }    else   if ([_lotterytype isEqualToString:@"12"]){//广西快乐10
        SixLotteryController *setVC = [[SixLotteryController alloc] init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
        
    }



    
    else{
    
    }

    
//    LotteryRoomController *setVC = [[LotteryRoomController alloc] init];
//    setVC.hidesBottomBarWhenPushed = YES;
//    setVC.lotterytype=_lotterytype;
//    [self.navigationController pushViewController:setVC animated:YES];
}
- (UITableView *)tableView {
    if (!_tableview) {
        CGRect frame = [self visibleBoundsShowNav:YES showTabBar:NO];
        _tableview = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tableview.backgroundColor = [UIColor clearColor];
        [_tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.showsVerticalScrollIndicator = true;
        _tableview.showsHorizontalScrollIndicator = false;
        _tableview.hidden = NO;
    }
    return _tableview;
}
- (void)addRefreshView {
    
    // 选手
    __weak __typeof(self) weakSelf = self;
    _tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageIndex = 0;

                [weakSelf getistoryLotterydata];
    }];
    _tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _pageIndex ++;
        [weakSelf getistoryLotterydata];
    }];

}

#pragma mark - 获取开奖数据
-(void)getistoryLotterydata{
    
    NSString*_interfacestr;
    
    [SVProgressHUD showWithStatus:@"loading..."];
    DLog(@"-=------%@",_lotterytype);
    if ([_lotterytype isEqualToString:@"0"]) {//三分彩
        _interfacestr=HTTP_bj3_openList;
    }else if ([_lotterytype isEqualToString:@"1"])//北京赛车
    {
        _interfacestr=HTTP_bjPk10_openList;
    }else if ([_lotterytype isEqualToString:@"2"])//幸运28
    {
       
        _interfacestr=HTTP_xjpLu28_openList;
    }
    else if ([_lotterytype isEqualToString:@"3"])//重庆时时彩
    {
        _interfacestr=HTTP_cqSSc_openList;
    }
    else if ([_lotterytype isEqualToString:@"4"])//pc蛋蛋
    {
        _interfacestr=HTTP_bjLu28_openList;
    }
    else  if ([_lotterytype isEqualToString:@"5"]){                                           //广东快乐十分
        _interfacestr=HTTP_gdk10_openList;
    } else if ([_lotterytype isEqualToString:@"6"])//天津
    {
        _interfacestr=HTTP_tjSsc_openList;
    }
    
    else if ([_lotterytype isEqualToString:@"7"]){
        _interfacestr=HTTP_xjSsc_openList;
    }
    else if ([_lotterytype isEqualToString:@"8"]){
        _interfacestr=HTTP_poker_openList;
    }
    else if ([_lotterytype isEqualToString:@"9"]){
        _interfacestr=HTTP_gdPick11_openList;
    }
    else if ([_lotterytype isEqualToString:@"10"]){
        _interfacestr=HTTP_jsK3_openList;
    }
    else if ([_lotterytype isEqualToString:@"11"]){
        _interfacestr=HTTP_gxK10_openList;
    }else if ([_lotterytype isEqualToString:@"12"]){
        _interfacestr=HTTP_markSix_openList;
    }else{
    }



    
    NSDictionary *params = @{@"pageIndex":[NSString stringWithFormat:@"%d", _pageIndex]};
    [[HttpManager manager] requestGetURL:_interfacestr withParams:params withTarget:self withHud:YES withSuccessBlock:^(id responseObject) {
        NSDictionary *dic = responseObject;
        DLog(@"-=-----%@",responseObject);
        if ([EncodeFormDic(dic, @"code") isEqualToString:@"200"]) {
            NSDictionary *data = dic[@"data"];
            NSString *totalStr = data[@"total"];
            NSArray *items = data[@"items"];
            NSMutableArray *array = [NSMutableArray array];
            array = [HistoryLotteryModel mj_objectArrayWithKeyValuesArray:items];
            if (_pageIndex == 0) {
                _dataArray = array;
            }else {
                [_dataArray addObjectsFromArray:array];
            }
            if (_dataArray.count >= [totalStr floatValue]) {
                _isNoMoreData = YES;
            }else {
                _isNoMoreData = NO;
            }

            [self.tableView reloadData];
            [self.tableview.mj_header endRefreshing];
            if (_isNoMoreData) {
                [self.tableview.mj_footer endRefreshingWithNoMoreData];
            }else {
                [self.tableview.mj_footer endRefreshing];
            }
            
        
        }
        
        [SVProgressHUD dismiss];
        
    } withFailureBlock:^(NSError *error) {
        [self presentSheet:NetErrorMsg];
        [self.tableview.mj_header endRefreshing];
        [SVProgressHUD dismiss];

        
    }];
}
#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 143;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([_lotterytype isEqualToString:@"2"]||[_lotterytype isEqualToString:@"4"]||[_lotterytype isEqualToString:@"8"]||[_lotterytype isEqualToString:@"10"]||[_lotterytype isEqualToString:@"9"]) {
        static NSString *cellID = @"PCHistoryLotteryCell";
        PCHistoryLotteryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[PCHistoryLotteryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.contentView.backgroundColor = RGBCOLOR(240, 241, 242);
        }
        
        cell.typestr=_lotterytype;
        if (_dataArray.count>0) {
            cell.historylotteryModel = [_dataArray objectAtIndex:indexPath.row];
        }
        return cell;
    }else if ([_lotterytype isEqualToString:@"12"]){
    
        static NSString *cellID = @"SixHistoryLotteryCell";
        SixHistoryLotteryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[SixHistoryLotteryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.contentView.backgroundColor = RGBCOLOR(240, 241, 242);
        }
        
        cell.typestr=_lotterytype;
        if (_dataArray.count>0) {
            cell.historylotteryModel=[_dataArray objectAtIndex:indexPath.row];
        }

        return cell;
    }else{
        
        static NSString *cellID = @"BJHistoryLotteryCell";
        BJHistoryLotteryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[BJHistoryLotteryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.contentView.backgroundColor = RGBCOLOR(240, 241, 242);
        }
        
        cell.typestr=_lotterytype;
        if (_dataArray.count>0) {
            cell.historylotteryModel=[_dataArray objectAtIndex:indexPath.row];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
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
