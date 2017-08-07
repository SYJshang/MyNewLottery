//
//  BetHallController.m
//  longzhicai
//
//  Created by lili on 2017/3/22.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import "BetHallController.h"
#import "BetHallViewCell.h"
#import "LotteryRoomController.h"
#import "GameListModel.h"
#import "LotteryModel.h"

#import "ThreeColorController.h"
#import "BJRacingPkController.h"
#import "LuckTwentyEightController.h"
#import "CQTimeColorController.h"
#import "PCBallsController.h"
#import "GDHappyTenController.h"
#import "XJTimeColorController.h"
#import "TJTimeColorController.h"
#import "HappyPokerController.h"
#import "GDPickController.h"
#import "JSThreeController.h"
#import "GXHappyTenController.h"
#import "SixLotteryController.h"
//#import "NoNetView.h"

@interface BetHallController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView           *tableview;
@property (nonatomic, strong) NSMutableArray        *dataArray;
//@property (nonatomic, strong) NoNetView     *nonetview; //没网显示的视图

@end

@implementation BetHallController
-(instancetype)init {
    self = [super init];
    if (self) {
        self.isNeedBackItem = NO;
        self.dataArray = [NSMutableArray array];

    }
    return self;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self getLotterydata];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"下注大厅";
    [self.view addSubview:[self tableView]];
    [self addRefreshView];
    [self getLotterydata];
//    [self.view addSubview:self.nonetview];
}
#pragma mark - 获取开奖数据
-(void)getLotterydata{
    NSDictionary *params = @{@"pageIndex":[NSString stringWithFormat:@"3"]};
    [[HttpManager manager] requestGetURL:HTTP_baseData_latestList withParams:params withTarget:self withHud:YES withSuccessBlock:^(id responseObject) {
        NSDictionary *dic = responseObject;
        
        DLog(@"-=-----%@",responseObject);
        if ([EncodeFormDic(dic, @"code") isEqualToString:@"200"]) {
            NSDictionary *data = dic[@"data"];
            NSArray *items = data[@"items"];
            NSMutableArray *array = [NSMutableArray array];
            array = [LotteryModel mj_objectArrayWithKeyValuesArray:items];
            _dataArray = array;
//            _nonetview.hidden=YES;

            [self.tableView reloadData];
            [self.tableview.mj_header endRefreshing];
        }
    } withFailureBlock:^(NSError *error) {
//        _nonetview.hidden=NO;

        [self presentSheet:NetErrorMsg];
        [self.tableview.mj_header endRefreshing];
        
    }];
}


- (UITableView *)tableView {
    if (!_tableview) {
        CGRect frame = [self visibleBoundsShowNav:YES showTabBar:YES];
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
        [weakSelf getLotterydata];
    }];
    
    
}
#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        return IPhone4_5_6_6P(88 , 88, 98, 98);
 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        static NSString *cellID = @"BetHallViewCell";
        BetHallViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[BetHallViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.contentView.backgroundColor = RGBCOLOR(240, 241, 242);
        }

    LotteryModel*model=[_dataArray objectAtIndex:indexPath.row];
    cell.Model=model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LotteryModel*model=[_dataArray objectAtIndex:indexPath.row];
    
    //  游戏类型， 0=三份彩 1=北京赛车 2=幸运28 3=重庆时时彩 4=PC蛋蛋 5=广东快乐10分
    if ([model.type isEqualToString:@"0"]) {//0=三份彩
        
        ThreeColorController *setVC = [[ThreeColorController alloc] init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
    }else if ([model.type isEqualToString:@"1"]){//1=北京赛车
        BJRacingPkController *setVC = [[BJRacingPkController alloc] init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
        
    }else if ([model.type isEqualToString:@"2"]){//2=幸运28
        
        LuckTwentyEightController *setVC = [[LuckTwentyEightController alloc] init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
    }else if ([model.type isEqualToString:@"3"]){//3=重庆时时彩
        
        CQTimeColorController *setVC = [[CQTimeColorController alloc] init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
        
    }else if ([model.type isEqualToString:@"4"]){//4=PC蛋蛋
        
        PCBallsController *setVC = [[PCBallsController alloc] init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
    }else if ([model.type isEqualToString:@"5"]){//广东快乐10分
        
        GDHappyTenController *setVC = [[GDHappyTenController alloc] init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
    }else if ([model.type isEqualToString:@"6"]){//广东快乐10分
        
        TJTimeColorController *setVC = [[TJTimeColorController alloc] init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
    }
    else if ([model.type isEqualToString:@"7"]){//广东快乐10分
        
        XJTimeColorController *setVC = [[XJTimeColorController alloc] init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
    }
    else if ([model.type isEqualToString:@"8"]){//广东快乐10分
        
        HappyPokerController *setVC = [[HappyPokerController alloc] init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
    }else if ([model.type isEqualToString:@"9"]){//广东11选5
        
        GDPickController *setVC = [[GDPickController alloc] init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
    }
    else if ([model.type isEqualToString:@"10"]){//江苏快三
        
        JSThreeController *setVC = [[JSThreeController alloc] init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
    } else if ([model.type isEqualToString:@"11"]){//广西快乐十分
        
        GXHappyTenController *setVC = [[GXHappyTenController alloc] init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
    } else if ([model.type isEqualToString:@"12"]){//六合彩
        
        SixLotteryController *setVC = [[SixLotteryController alloc] init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
    }


    else{
    
    
    }


    
//    LotteryRoomController *setVC = [[LotteryRoomController alloc] init];
//    setVC.hidesBottomBarWhenPushed = YES;
//    setVC.lotterytype=model.type;
//    [self.navigationController pushViewController:setVC animated:YES];
}


//-(NoNetView*)nonetview{
//    if (!_nonetview)
//    {
//        _nonetview=[[NoNetView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
//        _nonetview.hidden=YES;
//        _nonetview.delegate=self;
//        
//        _nonetview.navtype=@"1";
//        
//    }
//    return _nonetview;
//}
-(void)clickReload{
    [self getLotterydata];
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
