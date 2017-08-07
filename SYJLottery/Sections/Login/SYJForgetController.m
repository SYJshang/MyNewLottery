//
//  SYJForgetController.m
//  SYJLottery
//
//  Created by 尚勇杰 on 2017/7/20.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJForgetController.h"

static int num = 60;

@interface SYJForgetController ()<UITextFieldDelegate>{
    UITextField *phoneField;
    UITextField *varifyField;
    NSTimer *time;
    
    UITextField *newPswField;
}

@property(nonatomic,strong)UIButton *showPswBtn;

@property(nonatomic,strong)NSString *strTime ;

@property (nonatomic, strong)   UIButton        *varify;



@end


@implementation SYJForgetController

@synthesize strTime;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addsubviews];
    if (_isChangePwd) {
        
        self.navigationItem.titleView = [UILabel titleWithColor:[UIColor whiteColor] title:@"更改密码" font:16];
        
    }else{
        self.navigationItem.titleView = [UILabel titleWithColor:[UIColor whiteColor] title:@"忘记密码" font:16];
        
    }
    self.navigationController.navigationBarHidden=NO;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"all_return_icon"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(10, 10, 24, 24);
    [btn addTarget:self action:@selector(leftBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];

    // Do any additional setup after loading the view.
}

- (void)leftBtn{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)addsubviews{
    
    
    for (int i=0; i<4; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, K_FRAME_NAVIGATION_BAR_HEIGHT+50*i, K_FRAME_BASE_WIDTH, 1)];
        [lineView setBackgroundColor:[UIColor lightGrayColor]];
        [lineView setAlpha:0.2f];
        [self.view addSubview:lineView];
    }
    
    phoneField = [[UITextField alloc] init];
    [phoneField setFrame:CGRectMake(20, K_FRAME_NAVIGATION_BAR_HEIGHT, K_FRAME_BASE_WIDTH-40, 50)];
    [phoneField setPlaceholder:@"手机号"];
    [phoneField setDelegate:self];
    [phoneField setReturnKeyType:UIReturnKeyDone];
    [self.view addSubview:phoneField];
    
    varifyField = [[UITextField alloc] init];
    [varifyField setFrame:CGRectMake(20, K_FRAME_NAVIGATION_BAR_HEIGHT+50, K_FRAME_BASE_WIDTH-40, 50)];
    [varifyField setPlaceholder:@"验证码"];
    [varifyField setDelegate:self];
    [varifyField setReturnKeyType:UIReturnKeyDone];
    [self.view addSubview:varifyField];
    //新密码
    newPswField = [[UITextField alloc] init];
    [newPswField setFrame:CGRectMake(20, K_FRAME_NAVIGATION_BAR_HEIGHT+100, K_FRAME_BASE_WIDTH-40, 50)];
    [newPswField setPlaceholder:@"新密码"];
    [newPswField setDelegate:self];
    [newPswField setReturnKeyType:UIReturnKeyDone];
    [self.view addSubview:newPswField];
    
    //    UIView *verifyLine = [[UIView alloc] initWithFrame:CGRectMake(K_FRAME_BASE_WIDTH-110, K_FRAME_NAVIGATION_BAR_HEIGHT+K_FRAME_HEAD_HEIGHT+77.5, 1, 35)];
    //    [verifyLine setBackgroundColor:[UIColor lightGrayColor]];
    //    [verifyLine setAlpha:0.2f];
    //    [self.view addSubview:verifyLine];
    
    UIButton *varifyBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [varifyBtn setFrame:CGRectMake(K_FRAME_BASE_WIDTH-100, K_FRAME_NAVIGATION_BAR_HEIGHT+60, 80, 30)];
    [varifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [varifyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    varifyBtn.layer.cornerRadius =5.0;
    varifyBtn.backgroundColor = RGBA(255, 125, 67, 1);
    [varifyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [varifyBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [varifyBtn addTarget:self action:@selector(varifyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:varifyBtn];
    self.varify = varifyBtn;
    
    
    
    
    
    //    显示安全输入按钮
    UIImage *NImage = [UIImage imageNamed:@"loginpage_btn_hide.png"];
    UIImage *SImage = [UIImage imageNamed: @"loginpage_btn_display.png"];
    CGFloat BtnY = K_FRAME_NAVIGATION_BAR_HEIGHT+100+(50-RectHeight(NImage)*2)/2;
    UIButton *showPswBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(K_FRAME_BASE_WIDTH-70, BtnY+5,RectWidth(NImage), RectHeight(NImage))];
    [showPswBtn1 setBackgroundImage:NImage forState:UIControlStateNormal];
    [showPswBtn1 setBackgroundImage:SImage forState:UIControlStateSelected];
    [showPswBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [showPswBtn1 addTarget:self action:@selector(setShowPswBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showPswBtn1];
    
    self.showPswBtn = showPswBtn1;
    
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [nextBtn setFrame:CGRectMake(15, K_FRAME_BASE_HEIGHT/2, K_FRAME_BASE_WIDTH-30, 40)];
    [nextBtn setBackgroundColor:K_COLOR_DAMINO_RED];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextBtn setTitle:@"提交" forState:UIControlStateNormal];
    nextBtn.layer.cornerRadius = 5.0;
    [nextBtn addTarget:self action:@selector(nextBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
    
}

//设置显示密码安全显示
-(void)setShowPswBtn{
    self.showPswBtn.selected =! self.showPswBtn.selected;
    newPswField.secureTextEntry = !newPswField.secureTextEntry;
}


#pragma mark -
#pragma mark button action
-(void)varifyBtnAction:(id)sender{
    if (phoneField.text.length == 11) {
        if ([Utils validateTelPhone:phoneField.text]) {
            [self.varify setUserInteractionEnabled:NO];
            time = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(sendValidCode) userInfo:nil repeats:YES];
        } else {
            [SVProgressHUD showErrorWithStatus:@"The phonenumber is wrong."];
        }
    } else {
        [SVProgressHUD showErrorWithStatus:@"The phonenumber is wrong."];
    }
}

- (void)sendValidCode {
    if (num == 60) {
        num--;
        //        NSString *url = [NSString stringWithFormat:@"%@/user/sendCode.do",URL];
        NSDictionary *parame = @{
                                 @"phoneNumber": phoneField.text
                                 
                                 };
        [SYJHttpHelper Post:@"https://www.h1055.com/user/sendCode.do" parameters:parame success:^(id responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            SYJLog(@"%@",dict);
            [SVProgressHUD showSuccessWithStatus:@"验证码发送成功！"];
            strTime = dict[@"result"][@"createtime"];
            
        } failure:^(NSError *error) {
            
            SYJLog(@"%@",error);
            
        }];
        
    } else if (num > 0) {
        num--;
        [self.varify setTitle:[NSString stringWithFormat:@"%d秒",num] forState:UIControlStateNormal];
    } else {
        [time invalidate];
        [self.varify setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.varify setUserInteractionEnabled:YES];
        num = 60;
    }
}



- (void)nextBtnAction:(id)sender{
    
    
    NSDictionary *parame = @{
                             @"phoneNumber":phoneField.text,
                             @"password":newPswField.text,
                             @"code":varifyField.text,
                             @"codeTime":strTime
                             };
    [SYJHttpHelper Post:@"https://www.h1055.com/user/forgetPwd.do" parameters:parame success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if ([dict[@"errorcode"] isEqualToString:@"0"]) {
            [SVProgressHUD showSuccessWithStatus:@"更改成功"];
            [self.navigationController  popViewControllerAnimated:YES];
 
        }else{
            [SVProgressHUD showSuccessWithStatus:dict[@"error"]];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"失败"];
    }];
    
    
    
    
}

#pragma mark -
#pragma mark textfield

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
