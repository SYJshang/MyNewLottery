//
//  SYJEditController.m
//  SYJLottery
//
//  Created by 尚勇杰 on 2017/7/24.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJEditController.h"
#import "SYJLoginController.h"

@interface SYJEditController ()<UITextFieldDelegate,UITextViewDelegate>{
    NSString *titleStr;
    NSString *contentStr;
}


@property (nonatomic, strong) UITextField *textF;
@property (nonatomic, strong) UITextView *textView;

@end

@implementation SYJEditController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"all_return_icon"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(10, 10, 24, 24);
    [btn addTarget:self action:@selector(leftBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"发布" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn1.frame = CGRectMake(10, 10, 50, 24);
    [btn1 addTarget:self action:@selector(changePublic) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn1];
    
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor whiteColor] title:@"发布帖子" font:16];
    
}

- (void)leftBtn{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)changePublic{
    
    [SVProgressHUD showWithStatus:@"正在发布..."];
    
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    if (!dict[@"userId"]) {
        [SVProgressHUD showInfoWithStatus:@"未登录"];
        [self.navigationController pushViewController:[SYJLoginController new] animated:YES];
    }else{
        NSDictionary *parame = @{@"userId":dict[@"userId"],
                                 @"title":titleStr,
                                 @"content":contentStr};
        [SYJHttpHelper Post:@"https://www.h1055.com/forum/saveUserForum.do" parameters:parame success:^(id responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            SYJLog(@"%@",dict);
            if ([dict[@"errorcode"] isEqualToString:@"0"]) {
               
                [SVProgressHUD showSuccessWithStatus:@"发表成功!"];
                
            }else{
                [SVProgressHUD showSuccessWithStatus:dict[@"error"]];
                
            }
        } failure:^(NSError *error) {
            [SVProgressHUD dismiss];
            
        }];
        
 
    }
    

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.textF = [[UITextField alloc]init];
    self.textF.borderStyle = UITextBorderStyleRoundedRect;
    [self.textF addTarget:self action:@selector(changetext:) forControlEvents:UIControlEventEditingChanged];
    self.textF.placeholder = @"标题";
    self.textF.font = [UIFont systemFontOfSize:17.0];
    [self.view addSubview:self.textF];
    self.textF.sd_layout.leftSpaceToView(self.view, 5).rightSpaceToView(self.view, 5).topSpaceToView(self.view, 10).heightIs(40);
    
    self.textView = [[UITextView alloc]init];
    self.textView.font = fontSize(scaleWithSize(18));
    self.textView.delegate = self;
    [self.view addSubview:self.textView];
    
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.font = fontSize(scaleWithSize(18));
    placeHolderLabel.text = @"内容（必填）";
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    [placeHolderLabel sizeToFit];
    [self.textView addSubview:placeHolderLabel];
    
    [self.textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    self.textView.sd_layout.leftSpaceToView(self.view, 5).rightSpaceToView(self.view, 5).topSpaceToView(self.textF, 0).heightIs(120);
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.cornerRadius = 3;
    self.textView.layer.borderColor = Gray.CGColor;
    self.textView.layer.borderWidth = 1.0;
    // Do any additional setup after loading the view.
}

- (void)changetext:(UITextField *)text{
    
    titleStr = text.text;
    
}

- (void)textViewDidChange:(UITextView *)textView{
    contentStr =  textView.text;
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
