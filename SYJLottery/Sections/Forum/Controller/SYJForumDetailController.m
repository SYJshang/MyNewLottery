
//
//  SYJForumDetailController.m
//  SYJLottery
//
//  Created by 尚勇杰 on 2017/7/24.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJForumDetailController.h"
#import "SYJForumModle.h"
#import "SYJCommentCell.h"
#import "SYJCommentModel.h"
#import "SYJForumDetailCell.h"
#import "ChatKeyBoard.h"
#import "SYJLoginController.h"

@interface SYJForumDetailController ()<UITableViewDelegate,UITableViewDataSource,ChatKeyBoardDelegate,ChatKeyBoardDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *listArr;

@property (nonatomic, strong) SYJForumModle *model;

@property (nonatomic, strong) UIButton *editComment;

@property (nonatomic, strong) UIButton *dianzanBtn;
@property (nonatomic, strong) ChatKeyBoard *chatKeyBoard;


@end

@implementation SYJForumDetailController

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
        _chatKeyBoard.dataSource = self;
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
    
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor whiteColor] title:@"论坛详情" font:16];
    
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
    self.tableView.estimatedRowHeight =100;
    [self.tableView registerClass:[SYJCommentCell class] forCellReuseIdentifier:@"commentCell"];
    [self.tableView registerClass:[SYJForumDetailCell class] forCellReuseIdentifier:@"forumCell"];


    
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

        if (self.model.isCollection == 0) {
            
            NSDictionary *parame = @{@"userId":dict[@"userId"],
                                     @"forumId":self.model.forumId};
            [SYJHttpHelper Post:@"https://www.h1055.com/forum/saveForumThumbs.do" parameters:parame success:^(id responseObject) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                SYJLog(@"%@",dict);
                if ([dict[@"errorcode"] isEqualToString:@"0"]) {
                    [self.dianzanBtn setImage:[UIImage imageNamed:@"点赞1"] forState:UIControlStateNormal];
                    self.model.isCollection = 2;
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
                                     @"forumId":self.model.forumId};
            [SYJHttpHelper Post:@"https://www.h1055.com/forum/deleteForumThumbs.do" parameters:parame success:^(id responseObject) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                SYJLog(@"%@",dict);
                if ([dict[@"errorcode"] isEqualToString:@"0"]) {
                    [self.dianzanBtn setImage:[UIImage imageNamed:@"点赞"] forState:UIControlStateNormal];
                    [SVProgressHUD showSuccessWithStatus:@"取消收藏成功!"];
                    self.model.isCollection = 0;
                    
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

    NSDictionary *parame = @{@"forumId":self.forumId};
    [SYJHttpHelper Post:@"https://www.h1055.com/forum/forumsDetail.do" parameters:parame success:^(id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        SYJLog(@"%@",dict);
        if ([dict[@"errorcode"] isEqualToString:@"0"]) {
            
            self.model = [SYJForumModle mj_objectWithKeyValues:dict[@"result"]];
            self.listArr = [SYJCommentModel mj_objectArrayWithKeyValuesArray:dict[@"discussList"]];
            
            if (self.model.isThumb == 0) {
                [self.dianzanBtn setImage:[UIImage imageNamed:@"点赞"] forState:UIControlStateNormal];

            }else{
                [self.dianzanBtn setImage:[UIImage imageNamed:@"点赞1"] forState:UIControlStateNormal];
 
            }
            
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
            
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
        
        return [self.tableView cellHeightForIndexPath:indexPath model:self.model keyPath:@"model" cellClass:[SYJForumDetailCell class] contentViewWidth:KSceenW];
//        return [self.tableView cellHeightForIndexPath:indexPath cellContentViewWidth:KSceenW tableView:self.tableView];
        
       
    }else{

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
        SYJForumDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"forumCell"];
        [cell.favoriteBtn addTarget:self action:@selector(collection:) forControlEvents:UIControlEventTouchUpInside];
        cell.model = self.model;

        return cell;
  
    }else{
        SYJCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
        cell.model = self.listArr[indexPath.row];
        return cell;
        
    }
    
}

- (void)collection:(UIButton *)btn{
    
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    
    [SVProgressHUD showWithStatus:@"loading..."];
    SYJForumDetailCell *myCell = (SYJForumDetailCell *)[[btn superview] superview];
    //表示Button添加在了Cell中。
    //如果将Button添加在myCell.contentView 中，
    //myCell = (myTableViewCell *)[[aButton superView] superView];
        
    if (self.model.isCollection == 0) {
        
        NSDictionary *parame = @{@"userId":dict[@"userId"],
                                 @"forumId":self.model.forumId};
        [SYJHttpHelper Post:@"https://www.h1055.com/forum/saveForumCollection.do" parameters:parame success:^(id responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            SYJLog(@"%@",dict);
            if ([dict[@"errorcode"] isEqualToString:@"0"]) {
                [myCell.favoriteBtn setImage:[UIImage imageNamed:@"collect1"] forState:UIControlStateNormal];
                self.model.isCollection = 2;
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
                                 @"forumId":self.model.forumId};
        [SYJHttpHelper Post:@"https://www.h1055.com/forum/delForumCollect.do" parameters:parame success:^(id responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            SYJLog(@"%@",dict);
            if ([dict[@"errorcode"] isEqualToString:@"0"]) {
                [myCell.favoriteBtn setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
                [SVProgressHUD showSuccessWithStatus:@"取消收藏成功!"];
                self.model.isCollection = 0;
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
    
    [self.view endEditing:NO];
    [self.chatKeyBoard keyboardDownForComment];
    
    //    kTipAlert(@"<%ld> selected...", indexPath.row);
}


#pragma mark - 键盘代理数据源
- (void)chatKeyBoardSendText:(NSString *)text{
   
    SYJLog(@"%@",text);
    NSDictionary *userinfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    
    if (!userinfo[@"userId"]) {
        
        [SVProgressHUD showInfoWithStatus:@"未登录"];
        [self.navigationController pushViewController:[SYJLoginController new] animated:YES];

        
    }else{
        NSDictionary *parame = @{@"forumId":self.forumId,
                                 @"content":text,
                                 @"userId":userinfo[@"userId"],
                                 };
        [SYJHttpHelper Post:@"https://www.h1055.com/forum/addForumDiscuss.do" parameters:parame success:^(id responseObject) {
            
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
