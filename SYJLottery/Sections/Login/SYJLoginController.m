//
//  SYJLoginController.m
//  SYJLottery
//
//  Created by 尚勇杰 on 2017/7/20.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJLoginController.h"
#import "WSLoginView.h"
#import "SYJRegisterController.h"
#import "SYJForgetController.h"

@interface SYJLoginController ()

@property (nonatomic, strong) UITextField *userName;
@property (nonatomic, strong) UITextField *password;

@end



@implementation SYJLoginController

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
    // Do any additional setup after loading the view.
}

- (void)leftBtn{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"all_return_icon"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(10, 10, 24, 24);
    [btn addTarget:self action:@selector(leftBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor whiteColor] title:@"登录" font:16];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WSLoginView *wsLoginV = [[WSLoginView alloc]initWithFrame:CGRectMake(0, 0,KSceenW, KSceenH)];
    wsLoginV.titleLabel.text = @"登录";
    wsLoginV.titleLabel.textColor = [UIColor grayColor];
    wsLoginV.hideEyesType = NOEyesHide;
    [self.view addSubview:wsLoginV];
    
    [wsLoginV setClickBlock:^(NSString *textField1Text, NSString *textField2Text) {
        
        textField1Text = @"18860233121";
        textField2Text = @"1995shang";
        
        if (textField1Text.length < 1 || textField2Text.length < 1) {
            [SVProgressHUD showErrorWithStatus:@"帐户或密码不能为空。输入后请再试一次!"];
            return ;
        }
        
        [SVProgressHUD showWithStatus:@"loading..."];
        
        
        
        NSDictionary *parame = @{
                                 @"phoneNumber": textField1Text,
                                 @"password":textField2Text
                                 };
        
        [SYJHttpHelper Post:[NSString stringWithFormat:@"https://www.h1055.com/user/login.do"] parameters:parame success:^(id responseObject) {
            
            [SVProgressHUD dismiss];
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"%@",dict);
            
            [[NSUserDefaults standardUserDefaults] setObject:dict[@"result"] forKey:@"userInfo"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            if (![[dict objectForKey:@"errorcode"]  isEqualToString:@"0"]) {
                NSString *errStr = [dict objectForKey:@"error"];
                [SVProgressHUD dismiss];
                [SVProgressHUD showErrorWithStatus:errStr];
                
            }else{
                [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                [self.navigationController popViewControllerAnimated:YES];
//                [[gobalConfig getInstance] setUserName:dict[@"result"][@"username"]];
//                [[gobalConfig getInstance] setPhonenumber:dict[@"result"][@"phonenumber"]];
//                [[gobalConfig getInstance]setIsLogin:YES];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    
//                    [self switchToRootViewController:0];
//                });
            }
            
            
        } failure:^(NSError *error) {
            
            [SVProgressHUD showErrorWithStatus:@"登陆失败"];
            
            
        }];
        
    }];
    
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [forgetBtn setTitle:@"登录有问题? 点这!" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:[UIColor colorWithWhite:0.9 alpha:1.0] forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(forgetPassBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [wsLoginV addSubview:forgetBtn];
    forgetBtn.sd_layout.centerXEqualToView(wsLoginV).bottomSpaceToView(wsLoginV, 240).heightIs(15).widthIs(240);
    
    UIButton *joinUs = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [joinUs setTitle:@"Join us?" forState:UIControlStateNormal];
    [joinUs setTitleColor:[UIColor colorWithWhite:0.85 alpha:1.0] forState:UIControlStateNormal];
    [joinUs addTarget:self action:@selector(registerBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    joinUs.titleLabel.font = [UIFont systemFontOfSize:24];
    [wsLoginV addSubview:joinUs];
    joinUs.sd_layout.centerXEqualToView(wsLoginV).bottomSpaceToView(wsLoginV, 80).heightIs(80).widthIs(150);

    // Do any additional setup after loading the view.
}

- (void)registerBtnAction:(id)sender{
    SYJRegisterController *registerController = [[SYJRegisterController alloc] init];
    [self.navigationController pushViewController:registerController animated:YES];
    
}

- (void)forgetPassBtnAction:(id)sender{
    SYJForgetController  *forgotViewController = [[SYJForgetController alloc] init] ;
    [self.navigationController pushViewController:forgotViewController animated:YES];
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
