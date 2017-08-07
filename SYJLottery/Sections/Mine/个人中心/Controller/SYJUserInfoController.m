//
//  SYJUserInfoController.m
//  SYJLottery
//
//  Created by 尚勇杰 on 2017/7/21.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJUserInfoController.h"
#import "SYJUserInfoModel.h"
#import "SYJUsreInfoCell.h"

@interface SYJUserInfoController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SYJUserInfoModel *model;
@property (nonatomic, strong) NSMutableArray *listArr;


@end

@implementation SYJUserInfoController

- (NSMutableArray *)listArr{
    
    if (_listArr == nil) {
        _listArr = [NSMutableArray arrayWithObjects:@"昵称",@"用户签名",@"总积分",@"中奖积分",@"花费积分",@"中奖次数",@"盈利率",@"连红数",nil];
    }
    
    return _listArr;
    
}



- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"all_return_icon"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(10, 10, 24, 24);
    [btn addTarget:self action:@selector(leftBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor whiteColor] title:@"个人信息详情" font:16];
    
}

- (void)leftBtn{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[SYJUsreInfoCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getHttpData];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    [SVProgressHUD showWithStatus:@"loading..."];
    
    if (self.userID) {
        [self getHttpData];
    }
    
    
    // Do any additional setup after loading the view.
}

- (void)getHttpData{
    
    NSDictionary *parame = @{@"userId":self.userID};
    [SYJHttpHelper Post:@"https://www.h1055.com/user/getUserInfo.do" parameters:parame success:^(id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        SYJLog(@"%@",dict);
        if ([dict[@"errorcode"] isEqualToString:@"0"]) {
            
            self.model = [SYJUserInfoModel mj_objectWithKeyValues:dict[@"result"]];
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
            [self.tableView.mj_header endRefreshing];
            
        }else{
            [SVProgressHUD showSuccessWithStatus:dict[@"error"]];
            
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        
    }];
    
    
}

#pragma mark - table view dataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    _listArr = [NSMutableArray arrayWithObjects:@"昵称",@"用户签名",@"总积分",@"中奖积分",@"花费积分",@"中奖次数",@"盈利率",@"连红数"];

    SYJUsreInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.nameLab.text = self.listArr[indexPath.row];
    if (self.model) {
        NSMutableArray *arr = [NSMutableArray arrayWithObjects:self.model.username,self.model.userSign,self.model.score,self.model.inCount,self.model.payCount,self.model.winCount,@"0",self.model.redCount,nil];
        cell.descLab.text = arr[indexPath.row];
    }
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
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
