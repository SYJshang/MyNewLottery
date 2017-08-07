//
//  SYJSettingController.m
//  SYJLottery
//
//  Created by 尚勇杰 on 2017/7/21.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJSettingController.h"
#import "SYJSettinfCell.h"
#import "YJCache.h"
#import "SYJRevampController.h"

@interface SYJSettingController ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UIImage *img;



@end

@implementation SYJSettingController

- (NSMutableArray *)listArr{
    
    if (_listArr == nil) {
        _listArr = [NSMutableArray arrayWithObjects:@"修改用户信息",@"修改头像",@"清理缓存",@"版本信息",@"关于我们",@"退出登录",nil];
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
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = Gray;
    
    [self.tableView registerClass:[SYJSettinfCell class] forCellReuseIdentifier:@"cell"];

    
    
    
    // Do any additional setup after loading the view.
}

#pragma mark - table view dataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    _listArr = [NSMutableArray arrayWithObjects:@"昵称",@"用户签名",@"总积分",@"中奖积分",@"花费积分",@"中奖次数",@"盈利率",@"连红数"];
    NSArray *imgArr = @[@"修改",@"修改头像",@"清理缓存",@"版本",@"关于我们",@"退出"];
    
    SYJSettinfCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.nameLab.text = self.listArr[indexPath.section];
    cell.img.image = [UIImage imageNamed:imgArr[indexPath.section]];
    if (indexPath.section == 1) {
        self.icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"头像"]];
        [cell.contentView addSubview:self.icon];
        self.icon.sd_layout.rightSpaceToView(cell.accowImg, 10).centerYEqualToView(cell.contentView).heightIs(50).widthIs(50);
        self.icon.sd_cornerRadius = @25;

        
    }
    
    if (self.img) {
        
        self.icon.image = self.img;
//        [self.icon sd_setImageWithURL:[NSURL URLWithString:dict[@"imgPath"]] placeholderImage:[UIImage imageNamed:@"头像"]];
    }else{
        NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
        [self.icon sd_setImageWithURL:[NSURL URLWithString:dict[@"imgPath"]] placeholderImage:[UIImage imageNamed:@"头像"]];
    }
    


    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
        switch (indexPath.section) {
                case 0:
                [self.navigationController pushViewController:[SYJRevampController new] animated:YES];
                break;
                case 1:{
                    
                    TZImagePickerController *imagePicker = [[TZImagePickerController alloc]initWithMaxImagesCount:1 delegate:self];
                    [imagePicker setDidFinishPickingPhotosHandle:^(NSArray *imageArray, NSArray *array, BOOL isSelectOriginalPhoto){
                        
                        UIImage *image = [imageArray firstObject];
                        self.img = image;
                        [self choosePicture];
                        [self.tableView reloadData];
                        
                    }];
                    [self presentViewController:imagePicker animated:YES completion:nil];
                    break;
                }
                case 2:{
                    
                    float cache = [YJCache filePath];
                    NSString *str = [NSString stringWithFormat:@"清理了%.2f Mb 缓存",cache];
                    [SVProgressHUD showInfoWithStatus:str];
                }
                
                break;
                case 3:{
                    [SVProgressHUD showInfoWithStatus:@"当前版本:2.6.7"];
 
                }
                
                break;
                case 4:
                [SVProgressHUD showInfoWithStatus:@"请拨打电话客服了解详细信息\n021-85856929"];

                break;
                
                case 5:
                [self exitLogin];
                break;
                
            default:
                break;
        }

    
}

- (void)exitLogin{
    
    
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    [parame setObject:dict[@"userId"] forKey:@"userId"];
    [SYJHttpHelper Post:@"https://www.h1055.com/user/logoutById.do" parameters:parame success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        SYJLog(@"%@",dict);
        if ([dict[@"errorcode"] isEqualToString:@"0"]) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userInfo"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        [SVProgressHUD showSuccessWithStatus:dict[@"error"]];
        
        
        
    } failure:^(NSError *error) {
        [SVProgressHUD showSuccessWithStatus:@"失败"];
        SYJLog(@"%@",error);
        
    }];
    
}



- (void)choosePicture{
    
    NSData *data = UIImageJPEGRepresentation(self.img, 0.7f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:0];
    
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    [parame setObject:encodedImageStr forKey:@"file"];
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    [parame setObject:dict[@"userId"] forKey:@"userId"];
    
    
    
    [SVProgressHUD showWithStatus:@"正在上传..."];
    
    [SYJHttpHelper Post:@"https://www.h1055.com/user/uploadFile.do" parameters:parame success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        SYJLog(@"%@",dict);

        [SVProgressHUD showSuccessWithStatus:dict[@"error"]];
        
        
        
    } failure:^(NSError *error) {
        [SVProgressHUD showSuccessWithStatus:@"失败"];
        SYJLog(@"%@",error);
        
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
