//
//  SYJForumController.m
//  SYJLottery
//
//  Created by 尚勇杰 on 2017/7/24.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJForumController.h"
#import "CPArenaTableViewCell.h"
#import "SYJForumModle.h"
#import "SYJEditController.h"
#import "SYJForumDetailController.h"

@interface SYJForumController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *listArr;

@property (nonatomic, assign) int count;

@end

@implementation SYJForumController

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
    
    self.count = 0;

    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"发布"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(10, 10, 36, 36);
    [btn addTarget:self action:@selector(leftBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor whiteColor] title:@"论坛" font:16];
    
}

- (void)leftBtn{
    
    [self.navigationController pushViewController:[SYJEditController new] animated:YES];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSceenW, KSceenH - 108) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self getHttpData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.count ++;
        [self getHttpData];
    }];
    
//    [self.tableView.mj_header beginRefreshing];

    
    [SVProgressHUD showWithStatus:@"loading..."];
    
    [self getHttpData];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)getHttpData{
    NSString *str = [NSString stringWithFormat:@"%d",self.count];
    NSDictionary *parame = @{@"pageNo":str,
                             @"pageSize":@"20"};
    [SYJHttpHelper Post:@"https://www.h1055.com/forum/forumList.do" parameters:parame success:^(id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        SYJLog(@"%@",dict);
        if ([dict[@"errorcode"] isEqualToString:@"0"]) {
            
            NSArray *arr = [SYJForumModle mj_objectArrayWithKeyValuesArray:dict[@"result"]];
            [self.listArr addObjectsFromArray:arr];
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
            [self.tableView.mj_header endRefreshing];
            if (arr.count < 20) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.tableView.mj_footer endRefreshing];
            }
            
        }else{
            [SVProgressHUD showSuccessWithStatus:dict[@"error"]];
            
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_footer endRefreshingWithNoMoreData];

        
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
    
    CPArenaTableViewCell *cell = [CPArenaTableViewCell cellWithTableView:tableView];
    cell.model = self.listArr[indexPath.row];
    [cell.favoriteBtn addTarget:self action:@selector(collection:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)collection:(UIButton *)btn{
    
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];

    [SVProgressHUD showWithStatus:@"loading..."];
    CPArenaTableViewCell *myCell = (CPArenaTableViewCell *)[[btn superview] superview];
    //表示Button添加在了Cell中。
    //如果将Button添加在myCell.contentView 中，
    //myCell = (myTableViewCell *)[[aButton superView] superView];
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:myCell];
    SYJForumModle *model = self.listArr[indexPath.row];
    if (model.isCollection == 0) {
        
        NSDictionary *parame = @{@"userId":dict[@"userId"],
                                 @"forumId":model.forumId};
        [SYJHttpHelper Post:@"https://www.h1055.com/forum/saveForumCollection.do" parameters:parame success:^(id responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            SYJLog(@"%@",dict);
            if ([dict[@"errorcode"] isEqualToString:@"0"]) {
                [myCell.favoriteBtn setImage:[UIImage imageNamed:@"collect1"] forState:UIControlStateNormal];
                model.isCollection = 2;
                [SVProgressHUD showSuccessWithStatus:@"收藏成功!"];
//                [self.tableView reloadData];
                
            }else{
                [SVProgressHUD showSuccessWithStatus:dict[@"error"]];
                
            }
        } failure:^(NSError *error) {
            [SVProgressHUD dismiss];
            
        }];

        
    }else{
       
        NSDictionary *parame = @{@"userId":dict[@"userId"],
                                 @"forumId":model.forumId};
        [SYJHttpHelper Post:@"https://www.h1055.com/forum/delForumCollect.do" parameters:parame success:^(id responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            SYJLog(@"%@",dict);
            if ([dict[@"errorcode"] isEqualToString:@"0"]) {
                [myCell.favoriteBtn setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
                [SVProgressHUD showSuccessWithStatus:@"取消收藏成功!"];
                model.isCollection = 0;
//                [self.tableView reloadData];
                
            }else{
                [SVProgressHUD showSuccessWithStatus:dict[@"error"]];
                
            }
        } failure:^(NSError *error) {
            [SVProgressHUD dismiss];
            
        }];

        
    }
    
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SYJForumModle *model = self.listArr[indexPath.row];
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
