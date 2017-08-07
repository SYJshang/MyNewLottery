//
//  SYJForumCollectController.m
//  SYJLottery
//
//  Created by 尚勇杰 on 2017/7/25.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJForumCollectController.h"
#import "SYJForumCollectModel.h"
#import "SYJForumCollectCell.h"
#import "SYJForumDetailController.h"

@interface SYJForumCollectController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *listArr;

@end

@implementation SYJForumCollectController

- (NSMutableArray *)listArr{
    
    if (_listArr == nil) {
        _listArr = [NSMutableArray array];
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
    
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor whiteColor] title:@"收藏" font:16];
    
}

- (void)leftBtn{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSceenW, KSceenH - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[SYJForumCollectCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getHttpData];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    [SVProgressHUD showWithStatus:@"loading..."];
    
    [self getHttpData];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)getHttpData{
    NSDictionary *userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSDictionary *parame = @{@"userId":userInfo[@"userId"]};
    [SYJHttpHelper Post:@"https://www.h1055.com/forum/findFourmCollect.do" parameters:parame success:^(id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        SYJLog(@"%@",dict);
        if ([dict[@"errorcode"] isEqualToString:@"0"]) {
            
            self.listArr = [SYJForumCollectModel
                            mj_objectArrayWithKeyValuesArray:dict[@"result"]];
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
    
    return 130;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SYJForumCollectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.model = self.listArr[indexPath.row];
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SYJForumCollectModel *model = self.listArr[indexPath.row];
    SYJForumDetailController *vc = [[SYJForumDetailController alloc]init];
    vc.forumId = model.forumId;
    [self.navigationController pushViewController:vc animated:YES];
    //    kTipAlert(@"<%ld> selected...", indexPath.row);
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
