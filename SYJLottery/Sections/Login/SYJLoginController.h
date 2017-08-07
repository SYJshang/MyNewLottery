//
//  SYJLoginController.h
//  SYJLottery
//
//  Created by 尚勇杰 on 2017/7/20.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJBaseViewController.h"

@interface SYJLoginController : SYJBaseViewController<UITextFieldDelegate>{
    UIButton *loginTitleBtn;
    UIButton *loginAccountBtn;
    
    UITextField *userField;
    UITextField *passField;
    UITextField *imageCode;
    
    UIView  *moveLine;
    UIView *verifyLine;
    UIView *imageLine;
    UIView *buttomLine;
    
    UIButton *verifyButton;
    UIButton *forgetPassButton;
    UIButton *registerButton;
    UIButton *imageButton;
    UIButton *loginButton;
    
    NSString *VerificationCodeKey;
    
    NSTimer *time;
    
}

@property (nonatomic, assign)    int   jumpNum;

@property (nonatomic, strong)    UIButton *showPswBtn;


@end
