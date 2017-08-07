//
//  LotteryController.m
//  longzhicai
//
//  Created by lili on 2017/3/22.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import "LotteryController.h"
#import "LotteryViewCell.h"
#import "HistoryLotteryController.h"
#import "LotteryModel.h"
//#import "NoNetView.h"

@interface LotteryController ()<UITableViewDelegate,UITableViewDataSource>
{

}
@property (nonatomic, strong) UITableView           *tableview;
@property (nonatomic, strong) NSMutableArray        *dataArray;
@property (nonatomic, strong) NSArray               *titlearr;

//@property (nonatomic, strong) NoNetView     *nonetview; //没网显示的视图

@end

@implementation LotteryController
-(instancetype)init {
    self = [super init];
    if (self) {
     
        self.dataArray = [NSMutableArray array];
        self.isNeedBackItem = NO;
    }
    return self;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self getLotterydata];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"开奖结果";
    [self.view addSubview:[self tableView]];
    [self addRefreshView];
    [self getLotterydata];
//    [self.view addSubview:self.nonetview];
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
#pragma mark - 获取开奖数据
-(void)getLotterydata{
    
    [SVProgressHUD showWithStatus:@"loading..."];
//    NSDictionary *params = @{@"pageIndex":[NSString stringWithFormat:@"3"]};
    [[HttpManager manager] requestGetURL:HTTP_baseData_latestList withParams:nil withTarget:self withHud:YES withSuccessBlock:^(id responseObject) {
        NSDictionary *dic = responseObject;
        
        DLog(@"-=-----%@",responseObject);
        if ([EncodeFormDic(dic, @"code") isEqualToString:@"200"]) {
            NSDictionary *data = dic[@"data"];
            NSArray *items = data[@"items"];
            NSMutableArray *array = [NSMutableArray array];
            array = [LotteryModel mj_objectArrayWithKeyValuesArray:items];
            _dataArray = array;

            [SVProgressHUD dismiss];
            [self.tableView reloadData];
            [self.tableview.mj_header endRefreshing];
        }
//        _nonetview.hidden=YES;

    } withFailureBlock:^(NSError *error) {
//        _nonetview.hidden=NO;

        [self presentSheet:NetErrorMsg];
        [self.tableview.mj_header endRefreshing];

    }];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return IPhone4_5_6_6P(83, 83, 93, 98);
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"LotteryViewCell";
    LotteryViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[LotteryViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.contentView.backgroundColor = RGBCOLOR(240, 241, 242);
    }
//    _titlearr=@[@"三分彩",@"北京赛车PK10",@"幸运28",@"重庆时时彩",@"pc蛋蛋",@"广东快乐十分"];
//    cell.typestr=[_titlearr objectAtIndex:indexPath.row];

    if (_dataArray.count>0) {
        LotteryModel*model=[_dataArray objectAtIndex:indexPath.row];
        cell.Model=model;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LotteryModel *model = [_dataArray objectAtIndex:indexPath.row];
    [MyConfig currentConfig].bettype = model.type;

    HistoryLotteryController *setVC = [[HistoryLotteryController alloc] init];
    setVC.hidesBottomBarWhenPushed = YES;
    setVC.lotterytype=model.type;
    [self.navigationController pushViewController:setVC animated:YES];
    
}
//-(NoNetView*)nonetview{
//    if (!_nonetview)
//    {
//        _nonetview=[[NoNetView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
//        _nonetview.hidden=YES;
//        _nonetview.delegate=self;
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
