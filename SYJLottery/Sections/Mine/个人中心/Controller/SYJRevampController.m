//
//  SYJRevampController.m
//  SYJLottery
//
//  Created by 尚勇杰 on 2017/7/21.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJRevampController.h"
#import "SYJTextFiedCell.h"

@interface SYJRevampController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    
    NSString *str1;
    NSString *str2;
    NSString *str3;
    NSString *str4;
    
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listArr;

@end

@implementation SYJRevampController

- (NSMutableArray *)listArr{
    
    if (_listArr == nil) {
        _listArr = [NSMutableArray arrayWithObjects:@"老密码",@"新密码",@"用户签名",@"用户昵称",nil];
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
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"提交" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn1.frame = CGRectMake(10, 10, 50, 24);
    [btn1 addTarget:self action:@selector(changeUserInfo) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn1];
    
    
}

- (void)leftBtn{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = Gray;
    
    [self.tableView registerClass:[SYJTextFiedCell class] forCellReuseIdentifier:@"cell"];
    // Do any additional setup after loading the view.
}


#pragma mark - table view dataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    _listArr = [NSMutableArray arrayWithObjects:@"昵称",@"用户签名",@"总积分",@"中奖积分",@"花费积分",@"中奖次数",@"盈利率",@"连红数"];
    NSArray *placeArr = @[@"请输入用户旧密码",@"请输入用户新密码",@"请输入用户用户签名",@"请输入用户昵称"];
    
    SYJTextFiedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.nameLab.text = self.listArr[indexPath.section];
    cell.textFiled.placeholder = placeArr[indexPath.section];
    cell.textFiled.tag = 1 + indexPath.section;
    [cell.textFiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

#pragma mark - textFiled delegate

- (void)textFieldDidChange:(UITextField *)textField{
    
    if (textField.tag == 1) {
        str1 = textField.text;
    }else if (textField.tag == 2){
        str2 = textField.text;
    }else if (textField.tag == 3){
        str3 = textField.text;
    }else if (textField.tag == 4){
        str4 = textField.text;
    }


    SYJLog(@"%@ %@ %@ %@",str1,str2,str3,str4);
}


#pragma mark - 提交
- (void)changeUserInfo{
    NSDictionary *userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSDictionary *paramer = @{@"userId":userInfo[@"userId"],
                              @"oldpassword":str1,
                              @"password":str2,
                              @"userSign":str3,
                              @"username":str4};
    [SYJHttpHelper Post:@"https://www.h1055.com/user/changeUserInfo.do" parameters:paramer success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        SYJLog(@"%@",dict);
        if ([dict[@"errorcode"] isEqualToString:@"0"]) {
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];

        }else{
            [SVProgressHUD showErrorWithStatus:dict[@"error"]];
        }
        
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"修改失败"];

        
    }];
    
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
