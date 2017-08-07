//
//  SYJNewsDeailController.m
//  SYJLottery
//
//  Created by 尚勇杰 on 2017/7/25.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJNewsDeailController.h"
#import "SYJNewsDetailCell.h"
#import "SYJNewsModel.h"
#import "SYJLoginController.h"
#import "ChatKeyBoard.h"
#import "SYJCommentModel.h"
#import "SYJCommentCell.h"

@interface SYJNewsDeailController ()<UITableViewDelegate,UITableViewDataSource,ChatKeyBoardDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *listArr;

@property (nonatomic, strong) UIButton *editComment;
@property (nonatomic, strong) UIButton *dianzanBtn;
@property (nonatomic, strong) UIButton *collectBtn;

@property (nonatomic, strong) ChatKeyBoard *chatKeyBoard;
@property (nonatomic, strong) SYJNewsModel *model;


@end

@implementation SYJNewsDeailController
- (NSMutableArray *)listArr{
    
    if (_listArr == nil) {
        _listArr = [NSMutableArray array];
    }
    
    return _listArr;
    
}

//键盘
-(ChatKeyBoard *)chatKeyBoard{
    if (_chatKeyBoard==nil) {
        _chatKeyBoard =[ChatKeyBoard keyBoardWithNavgationBarTranslucent:YES];
        _chatKeyBoard.delegate = self;
        _chatKeyBoard.keyBoardStyle = KeyBoardStyleComment;
        _chatKeyBoard.allowVoice = NO;
        _chatKeyBoard.allowMore = NO;
        _chatKeyBoard.allowSwitchBar = NO;
        _chatKeyBoard.allowFace = NO;
        _chatKeyBoard.placeHolder = @"评论";
        [self.view addSubview:_chatKeyBoard];
        [self.view bringSubviewToFront:_chatKeyBoard];
    }
    return _chatKeyBoard;
}


- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"all_return_icon"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(10, 10, 30, 30);
    [btn addTarget:self action:@selector(leftBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor whiteColor] title:@"新闻详情" font:16];
    
}

- (void)leftBtn{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSceenW, KSceenH - 108) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[SYJNewsDetailCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[SYJCommentCell class] forCellReuseIdentifier:@"cell1"];

    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getHttpData];
    }];
    
    [self creatView];
    [self getHttpData];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)creatView{
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    view.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0).heightIs(44);
    
    self.editComment = [UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:self.editComment];
    [self.editComment setImage:[UIImage imageNamed:@"发布"] forState:UIControlStateNormal];
    [self.editComment addTarget:self action:@selector(public:) forControlEvents:UIControlEventTouchUpInside];
    self.editComment.sd_layout.leftSpaceToView(view, 0).widthIs(KSceenW / 2).topSpaceToView(view, 0).bottomSpaceToView(view, 0);
    self.editComment.layer.masksToBounds = YES;
    self.editComment.layer.borderColor = Gray.CGColor;
    self.editComment.layer.borderWidth = 1.0;
    
    self.dianzanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:self.dianzanBtn];
    [self.dianzanBtn setImage:[UIImage imageNamed:@"点赞"] forState:UIControlStateNormal];
    [self.dianzanBtn addTarget:self action:@selector(dianzan:) forControlEvents:UIControlEventTouchUpInside];
    self.dianzanBtn.sd_layout.rightSpaceToView(view, 0).widthIs(KSceenW / 2).topSpaceToView(view, 0).bottomSpaceToView(view, 0);
    self.dianzanBtn.layer.masksToBounds = YES;
    self.dianzanBtn.layer.borderColor = Gray.CGColor;
    self.dianzanBtn.layer.borderWidth = 1.0;
    
}

//发布
- (void)public:(UIButton *)btn{
    
    [self.chatKeyBoard keyboardUpforComment];
    self.chatKeyBoard.placeHolder = @"输入您的评论吧~";
    
    
}


//点赞
- (void)dianzan:(UIButton *)btn{
    
    
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    if (!dict[@"userId"]) {
        [SVProgressHUD showInfoWithStatus:@"未登录"];
        [self.navigationController pushViewController:[SYJLoginController new] animated:YES];
    }else{
        [SVProgressHUD showWithStatus:@"loading..."];
        
        if (self.model.isHit == 0) {
            
            NSDictionary *parame = @{@"userId":dict[@"userId"],
                                     @"newsId":self.model.newsId};
            [SYJHttpHelper Post:@"https://www.h1055.com/news/givethumbs.do" parameters:parame success:^(id responseObject) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                SYJLog(@"%@",dict);
                if ([dict[@"errorcode"] isEqualToString:@"0"]) {
                    [self.dianzanBtn setImage:[UIImage imageNamed:@"点赞1"] forState:UIControlStateNormal];
                    self.model.isHit = 1;
                    [SVProgressHUD showSuccessWithStatus:@"点赞成功!"];
                    //                [self.tableView reloadData];
                    
                }else{
                    [SVProgressHUD showSuccessWithStatus:dict[@"error"]];
                    
                }
            } failure:^(NSError *error) {
                [SVProgressHUD dismiss];
                
            }];
            
            
        }else{
            
            NSDictionary *parame = @{@"userId":dict[@"userId"],
                                     @"newsId":self.model.newsId};
            [SYJHttpHelper Post:@"https://www.h1055.com/news/deleteNewsThumbs.do" parameters:parame success:^(id responseObject) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                SYJLog(@"%@",dict);
                if ([dict[@"errorcode"] isEqualToString:@"0"]) {
                    [self.dianzanBtn setImage:[UIImage imageNamed:@"点赞"] forState:UIControlStateNormal];
                    [SVProgressHUD showSuccessWithStatus:@"取消收藏成功!"];
                    self.model.isHit = 0;
                    
                }else{
                    [SVProgressHUD showSuccessWithStatus:dict[@"error"]];
                    
                }
            } failure:^(NSError *error) {
                [SVProgressHUD dismiss];
                
            }];
            
            
        }
        
        
        
    }
    
    
}



- (void)getHttpData{
    [SVProgressHUD showWithStatus:@"loading..."];
    NSDictionary *parame = @{@"newsId":self.newsId};
    [SYJHttpHelper Post:@"https://www.h1055.com/news/newsDetail.do" parameters:parame success:^(id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        SYJLog(@"%@",dict);
        if ([dict[@"errorcode"] isEqualToString:@"0"]) {
            
            self.model = [SYJNewsModel mj_objectWithKeyValues:dict[@"result"]];
            self.listArr = [SYJCommentModel mj_objectArrayWithKeyValuesArray:dict[@"discussList"]];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0;
    }else{
        
        return 30;
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSString *str = [NSString stringWithFormat:@"评论(%ld)",self.listArr.count];
    return str;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
//        return [self.tableView cellHeightForIndexPath:indexPath model:self.model keyPath:@"models" cellClass:[SYJNewsDetailCell class] contentViewWidth:KSceenW];
            return [self.tableView cellHeightForIndexPath:indexPath cellContentViewWidth:KSceenW tableView:self.tableView];
        
        
    }else{
        
//        return [self.tableView cellHeightForIndexPath:indexPath model:self.model keyPath:@"model" cellClass:[SYJCommentCell class] contentViewWidth:KSceenW];
        return [self.tableView cellHeightForIndexPath:indexPath cellContentViewWidth:KSceenW tableView:self.tableView];

        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        return self.listArr.count;
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SYJNewsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.models = self.model;
        return cell;

    }else{
        SYJCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        cell.model = self.listArr[indexPath.row];
        return cell;

        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark - 键盘代理数据源
- (void)chatKeyBoardSendText:(NSString *)text{
    
    SYJLog(@"%@",text);
    NSString *str = [self base64EncodeString:text];
    NSDictionary *userinfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    
    if (!userinfo[@"userId"]) {
        
        [SVProgressHUD showInfoWithStatus:@"未登录"];
        [self.navigationController pushViewController:[SYJLoginController new] animated:YES];
        
        
    }else{
        NSDictionary *parame = @{@"newsId":self.model.newsId,
                                 @"content":str,
                                 @"userId":userinfo[@"userId"],
                                 };
        [SYJHttpHelper Post:@"https://www.h1055.com/discuss/addDiscuss.do" parameters:parame success:^(id responseObject) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            SYJLog(@"%@",dict);
            if ([dict[@"errorcode"] isEqualToString:@"0"]) {
                [SVProgressHUD showSuccessWithStatus:@"发表成功"];
                
            }else{
                [SVProgressHUD showInfoWithStatus:dict[@"error"]];
                
            }
            
        } failure:^(NSError *error) {
            
        }];
        
        
    }
}

- (NSString *)base64DecodeString:(NSString *)string

{
    
    //1.将base64编码后的字符串『解码』为二进制数据
    
    NSData *data = [[NSData alloc]initWithBase64EncodedString:string options:0];
    
    //2.把二进制数据转换为字符串返回
    
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
}

- (NSString *)base64EncodeString:(NSString *)string

{
    
    //1.先把字符串转换为二进制数据
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    
    
    //2.对二进制数据进行base64编码，返回编码后的字符串
    
    return [data base64EncodedStringWithOptions:0];
    
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
