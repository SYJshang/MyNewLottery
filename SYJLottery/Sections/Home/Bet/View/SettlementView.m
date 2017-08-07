//
//  SettlementView.m
//  longzhicai
//
//  Created by lili on 2017/4/1.
//  Copyright © 2017年 wkw. All rights reserved.
//

#import "SettlementView.h"
#import "PlaceholderTextView.h"
#import "UIColor+Addition.h"

@interface SettlementView ()
{
    UIView      *_grayview;         //输入框
    UIView      *_moneyview;        //黄色view
    UILabel     *_lbtotal;          //结算
    UILabel     *_lbpay;            //支付的lable
    UIView      *_whitefootview;    //取消／ 确定
    NSString    *_moneystr;         //输入的钱数
}

@property(nonatomic,strong)UIView               *bgView;
@property(nonatomic,strong)UIView               *whiteview;
@property(nonatomic,strong) UIButton            *btblack;
@property (nonatomic, strong) UIScrollView      *scrollview; 
@end

@implementation SettlementView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:CGRectMake(0, 0, MSW, MSH)];
    if (self) {
        
        self.backgroundColor = BgColor;
        
        [self createUI];
    }
    return self;
}

#pragma mark - 创建视图
- (void)createUI
{
    [self addSubview:self.bgView];
    [self addSubview:self.whiteview];
    self.bgView.hidden=YES;
    self.whiteview.hidden=YES;
    _grayview=[[UIView alloc]initWithFrame:CGRectMake(10,55, _whiteview.width-20, 30)];
    _grayview.backgroundColor=NavColor;
    _grayview.layer.cornerRadius = 5;
//    _grayview.backgroundColor=RedColor;
    _grayview.layer.masksToBounds = YES;
    [_whiteview addSubview:_grayview];
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, 40)];
    view.backgroundColor=RGBCOLOR(232, 232, 232);
    UIButton*bt=[[UIButton alloc]initWithFrame:CGRectMake(MSW-70, 0, 70, 40)];
    [bt setTitle:@"完成" forState:UIControlStateNormal];
    bt.titleLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:17];
    [bt setTitleColor:BlackTitleColor forState:0];
    [bt addTarget:self action:@selector(handleSingleTapFrom) forControlEvents:UIControlEventTouchDown ];
    [view addSubview:bt];

    _tfmoney=[[UITextField alloc]initWithFrame:CGRectMake(10, 0,_grayview.width-60, 30)];
    _tfmoney.font = [UIFont systemFontOfSize:13];
    _tfmoney.placeholder = [MyConfig currentConfig].tips;
//    _tfmoney.backgroundColor=RedColor;
    _tfmoney.keyboardType=UIKeyboardTypeNumberPad;
    [_tfmoney addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _tfmoney.delegate=self;
    _tfmoney.inputAccessoryView=view;
//    [_tfmoney setPlaceholderColor: [UIColor colorWithHex:@"#999999"]];
    _tfmoney.textColor =BlackTitleColor;
    [_grayview addSubview:_tfmoney];
    UILabel*lbmoney = [[UILabel alloc] initWithFrame:CGRectMake(_grayview.right-45,0,30, _grayview.height)];
    lbmoney.textColor =BlackTitleColor;
    lbmoney.text=[MyConfig currentConfig].unit;
    lbmoney.font = [UIFont mysystemFontOfSize:BigFont];
    lbmoney.textAlignment = NSTextAlignmentRight;
    [_grayview addSubview:lbmoney];

    _moneyview=[[UIView alloc]initWithFrame:CGRectMake(0, _grayview.bottom+10, _whiteview.width, 30)];
    _moneyview.clipsToBounds=YES;
    _moneyview.backgroundColor=RGBCOLOR(250, 248, 217);
    [_whiteview addSubview:_moneyview];
    _lbtotal=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, _moneyview.width-20, _moneyview.height)];
    _lbtotal.textColor =RedColor;
    _lbtotal.text=@"3注踪迹167元，奖金56789元，盈利567890-元哈哈哈哈哈哈哈哈哈哈";
    _lbtotal.font = [UIFont mysystemFontOfSize:SmallFont];
    _lbtotal.numberOfLines=0;
    [_moneyview addSubview:_lbtotal];
    
    _whitefootview=[[UIView alloc]initWithFrame:CGRectMake(0, _whiteview.height-80, _whiteview.width, 80)];
    [_whiteview addSubview:_whitefootview];
    
    UILabel *lbline=[[UILabel alloc]initWithFrame:CGRectMake(0, 40, _whiteview.width, 1)];
    lbline.backgroundColor=LineColor;
    [_whitefootview addSubview:lbline];
    UILabel *lbline2=[[UILabel alloc]initWithFrame:CGRectMake(_whiteview.width/2-0.5,40, 1, 40)];
    lbline2.backgroundColor=LineColor;
    [_whitefootview addSubview:lbline2];

    
   _lbpay = [[UILabel alloc] initWithFrame:CGRectMake(0,10,_whiteview.width,30)];
    _lbpay.textColor =BlackTitleColor;
    _lbpay.text=@"使用余额支付90元";
    _lbpay.font = [UIFont mysystemFontOfSize:BigFont];
    _lbpay.textAlignment = NSTextAlignmentCenter;
    [_whitefootview addSubview:_lbpay];
    
    UIButton*btcancel=[[UIButton alloc]initWithFrame:CGRectMake(0, 40, _whiteview.width/2, 40)];
    [btcancel setTitle:@"取消" forState:0];
    btcancel.tag=101;
    [btcancel addTarget:self action:@selector(seleteclick:) forControlEvents:UIControlEventTouchUpInside];
    btcancel.titleLabel.font=[UIFont mysystemFontOfSize:BigFont];
    [btcancel setTitleColor:RedColor forState:0];
    [_whitefootview addSubview:btcancel];

    UIButton*btbet=[[UIButton alloc]initWithFrame:CGRectMake(_whiteview.width/2, 40, _whiteview.width/2, 40)];
    [btbet setTitle:@"下注" forState:0];
    btbet.tag=102;
    [btbet addTarget:self action:@selector(seleteclick:) forControlEvents:UIControlEventTouchUpInside];
    btbet.titleLabel.font=[UIFont mysystemFontOfSize:BigFont];
    [btbet setTitleColor:RedColor forState:0];
    [_whitefootview addSubview:btbet];

    _moneyview.frame=CGRectMake(10, _grayview.bottom+10, _whiteview.width-20, 0);
}
-(void)handleSingleTapFrom{
    [_tfmoney resignFirstResponder];
}


-(void)setMoney:(NSString *)money{
    _money=money;
    _lbpay.text=[NSString stringWithFormat:@"使用余额支付（余额%@%@）",_money,[MyConfig currentConfig].unit];
}
//取消 ／下注
-(void)seleteclick:(UIButton*)sender{
    int  index=(int)sender.tag;
    if (index==101) {
        [self hiddenView];
    }else{
        [self.delegate clickbetwithmoney:_moneystr];
    }
}

-(void)setviewlayoutwithbetarray:(NSArray *)betarray AndBettype:(NSString*)bettype;
{
    _bettype=bettype;
    if ([bettype isEqualToString:@"1"]) {
        _betArray=betarray;
        CGFloat W = (_whiteview.width-40)/3;
        CGFloat H = 30;
        [_scrollview removeAllSubviews];
        for (int i = 0; i<_betArray.count; i++) {
            UILabel*lable = [[UILabel alloc]initWithFrame:CGRectMake((W+10)*(i%3)+10,10 +(i/3) * (H+10), W, H)];
            BetModel*model=[_betArray objectAtIndex:i];
            lable.backgroundColor=RedColor;
            lable.text=[NSString stringWithFormat:@"%@%@",model.bettitle,model.title];
            lable.textColor=[UIColor whiteColor];
            lable.textAlignment = NSTextAlignmentCenter;
            lable.font=[UIFont systemFontOfSize:MiddleFont];
            [_scrollview addSubview:lable];
        }
        
        if (_betArray.count<=3) {
            _scrollview.frame=CGRectMake(0, 0, _whiteview.width,50);
            _scrollview.contentSize = CGSizeMake(_whiteview.width, 40);
            
        }else if (_betArray.count>3&&_betArray.count<=6){
            _scrollview.frame=CGRectMake(0, 0, _whiteview.width,90);
            _scrollview.contentSize = CGSizeMake(_whiteview.width, 80);
            
        }else{
            _scrollview.frame=CGRectMake(0, 0, _whiteview.width,130);
            if (_betArray.count%3==0) {
                _scrollview.contentSize = CGSizeMake(_whiteview.width,_betArray.count/3*40+10);
            }else{
                _scrollview.contentSize = CGSizeMake(_whiteview.width, (_betArray.count/3+1)*40+10);
            }
            
        }
        _grayview.hidden=YES;
        
        _whiteview.frame=CGRectMake(IPhone4_5_6_6P(30, 30, 30, 50) , 80, MSW-IPhone4_5_6_6P(60, 60, 60, 100), _scrollview.height+5+30+80);
        _moneyview.frame=CGRectMake(10,_scrollview.bottom+5, _whiteview.width-20, 30);
        _whitefootview.frame=CGRectMake(0, _whiteview.height-80, _whiteview.width, 80);

        
    }else{
        _grayview.hidden=NO;
        _betArray=betarray;
        CGFloat W = (_whiteview.width-40)/3;
        CGFloat H = 30;
        [_scrollview removeAllSubviews];
        for (int i = 0; i<_betArray.count; i++) {
            UILabel*lable = [[UILabel alloc]initWithFrame:CGRectMake((W+10)*(i%3)+10,10 +(i/3) * (H+10), W, H)];
            BetModel*model=[_betArray objectAtIndex:i];
            lable.backgroundColor=RedColor;
            lable.text=[NSString stringWithFormat:@"%@%@",model.bettitle,model.title];
            lable.textColor=[UIColor whiteColor];
            lable.textAlignment = NSTextAlignmentCenter;
            lable.font=[UIFont systemFontOfSize:MiddleFont];
            [_scrollview addSubview:lable];
        }
        
        if (_betArray.count<=3) {
            _scrollview.frame=CGRectMake(0, 0, _whiteview.width,50);
            _scrollview.contentSize = CGSizeMake(_whiteview.width, 40);
            
        }else if (_betArray.count>3&&_betArray.count<=6){
            _scrollview.frame=CGRectMake(0, 0, _whiteview.width,90);
            _scrollview.contentSize = CGSizeMake(_whiteview.width, 80);
            
        }else{
            _scrollview.frame=CGRectMake(0, 0, _whiteview.width,130);
            if (_betArray.count%3==0) {
                _scrollview.contentSize = CGSizeMake(_whiteview.width,_betArray.count/3*40+10);
            }else{
                _scrollview.contentSize = CGSizeMake(_whiteview.width, (_betArray.count/3+1)*40+10);
            }
            
        }
        
       

        [self setviewfrem];
    
    }

}

-(void)setBetnumber:(NSString *)betnumber{
    _betnumber=betnumber;
    

}

-(void)setIsguoguan:(NSString *)isguoguan{
    _isguoguan=isguoguan;

}

//设置view的布局
-(void)setviewfrem{
   
    DLog(@"-=-----=--%@",_betnumber);
    
    
    
    _grayview.frame=CGRectMake(10,_scrollview.bottom+5, _whiteview.width-20, 30);
    
    if ([ _tfmoney.text isEqualToString:@""]) {
        
        _moneyview.frame=CGRectMake(10, _grayview.bottom+10, _whiteview.width-20, 0);
        
        
    }else{
        _moneyview.frame=CGRectMake(10, _grayview.bottom+10, _whiteview.width-20, 30);
        
        
        
        NSDictionary* style = @{@"body" :
                                    @[
                                        BlackDescColor],
                                @"u": @[RedColor,
                                        
                                        ]};
        //            _betArray.count*[_tfmoney.text intValue];
//        DLog(@"-=-----%f---总共-%i------%.2f",jiangjin,totalcount,floor(jiangjin*100) / 100);
        
        if (IsStrEmpty(_betnumber)) {
            
            int totalcount=0;
            float  jiangjin=0.00;
            for (int i=0; i<_betArray.count; i++) {
                BetModel*model=[_betArray objectAtIndex:i];
                
                float  rate;
                if ([model.rate isEqualToString:@"25/50"]) {
                    rate=25;
                }else if ([model.rate isEqualToString:@"20/110"])
                {
                    rate=20;
                }else{
                    rate=[model.rate floatValue];
                    
                }
                
                totalcount=totalcount+[model.count intValue];
                jiangjin =jiangjin+[_tfmoney.text floatValue]*rate;
                
            }

            _totalmoney=[NSString stringWithFormat:@"%li",_betArray.count*[_tfmoney.text intValue]];
            
            _lbtotal.attributedText = [[NSString stringWithFormat:@"%li注共<u>%li元</u>，若中奖，奖金%.2f元，盈利<u>%.2f元</u>",_betArray.count,_betArray.count*[_tfmoney.text intValue],floor(jiangjin*100) / 100,floor(jiangjin*100) / 100-_betArray.count*[_tfmoney.text intValue]] attributedStringWithStyleBook:style];
        }else{
            
            int totalcount=0;
            float  jiangjin=0.00;
            
            float  guoguanrate=1.00;//过关的赔率

            for (int i=0; i<_betArray.count; i++) {
                BetModel*model=[_betArray objectAtIndex:i];
                
                float  rate;
                if ([model.rate isEqualToString:@"25/50"]) {
                    rate=25;
                }else if ([model.rate isEqualToString:@"20/110"])
                {
                    rate=20;
                }else{
                    rate=[model.rate floatValue];
                    
                }
                
                guoguanrate=guoguanrate*rate;
                totalcount=totalcount+[model.count intValue];
            jiangjin =[_betnumber intValue]*[_tfmoney.text floatValue]*rate;
        }

            if ([_isguoguan isEqualToString:@"1"]) {
                
                DLog(@"-=-=----%f",guoguanrate);
                jiangjin =[_betnumber intValue]*[_tfmoney.text floatValue]*guoguanrate;
            }
            
            

            _totalmoney=[NSString stringWithFormat:@"%li",_betArray.count*[_tfmoney.text intValue]];
            
            _lbtotal.attributedText = [[NSString stringWithFormat:@"%li注共<u>%li元</u>，若中奖，奖金%.2f元，盈利<u>%.2f元</u>",_betArray.count,_betArray.count*[_tfmoney.text intValue],floor(jiangjin*100) / 100,floor(jiangjin*100) / 100-_betArray.count*[_tfmoney.text intValue]] attributedStringWithStyleBook:style];

            
            

        
        }
        
    }
    _whitefootview.frame=CGRectMake(0,_scrollview.height+5+_grayview.height+_moneyview.height, _whiteview.width, 80);
    _whiteview.frame=CGRectMake(IPhone4_5_6_6P(30, 30, 30, 50) , 80, MSW-IPhone4_5_6_6P(60, 60, 60, 100), _scrollview.height+5+_grayview.height+_moneyview.height+_whitefootview.height);


}


- (void) textFieldDidChange:(UITextField *)sender {
    
    DLog(@"textChangeAction : %@",sender.text);
    if ([_tfmoney.text intValue]>10000) {
        _tfmoney.text=@"10000";
    }

    _moneystr=sender.text;
//    if ([sender.text isEqualToString:@""]) {
//        _moneyview.frame=CGRectMake(0, _grayview.bottom+10, _whiteview.width, 0);
//    }else{
//        _moneyview.frame=CGRectMake(0, _grayview.bottom+10, _whiteview.width, 30);
//        NSDictionary* style = @{@"body" :
//                                    @[
//                                        BlackDescColor],
//                                @"u": @[RedColor,
//                                        
//                                        ]};
//        int totalcount=0;
//        float  jiangjin=0.00;
//        for (int i=0; i<_betArray.count; i++) {
//            BetModel*model=[_betArray objectAtIndex:i];
//            
//            totalcount=totalcount+[model.count intValue];
//            jiangjin =jiangjin+[_tfmoney.text floatValue]*[model.rate floatValue];
//            
//        }
//        //            _betArray.count*[_tfmoney.text intValue];
//        DLog(@"-=-----总共-%i",totalcount);
//        _lbtotal.attributedText = [[NSString stringWithFormat:@"%li注共<u>%li元</u>，若中奖，奖金%.2f元，盈利<u>%.2f元</u>",_betArray.count,_betArray.count*[_tfmoney.text intValue],jiangjin,jiangjin-_betArray.count*[_tfmoney.text intValue]] attributedStringWithStyleBook:style];
//    }
   
    [self setviewfrem];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField == _tfmoney) {
        if (string.length == 0)return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 5) {
            return NO;
        }
    }
    return YES;
}
-(UIView *)bgView
{
    if (!_bgView)
    {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
        _bgView.backgroundColor = [UIColor clearColor] ;
        _btblack=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
        _btblack.backgroundColor=[UIColor blackColor];
        [_bgView addSubview:_btblack];
        [_btblack addTarget:self action:@selector(hiddenView) forControlEvents:UIControlEventTouchUpInside];
        self.btblack.alpha=0.3;
        
    }
    return _bgView;
}

-(UIView *)whiteview
{
    if (!_whiteview)
    {
        _whiteview = [[UIView alloc]initWithFrame:CGRectMake(IPhone4_5_6_6P(30, 30, 30, 50) , 80, MSW-IPhone4_5_6_6P(60, 60, 60, 100), MSH-200)];
        _whiteview.backgroundColor=[UIColor whiteColor];
        [_whiteview addSubview:self.scrollview];
        _whiteview.layer.cornerRadius = 5;
        _whiteview.layer.masksToBounds = YES;
        

    }
    return _whiteview;
}
//主滑动视图
-(UIScrollView*)scrollview{
    if (!_scrollview) {
        _scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _whiteview.width,50)];
        _scrollview.backgroundColor=[UIColor clearColor];
        _scrollview.showsHorizontalScrollIndicator=NO;
        _scrollview.showsVerticalScrollIndicator=NO;
        _scrollview.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 40);
    }
    return _scrollview;
}

/**
 *   显示列表
 */
-(void)showView
{
    self.bgView.hidden=NO;
    self.whiteview.alpha=0;
    [UIView animateWithDuration:0.2f animations:^{
        self.bgView.alpha = 1;
        self.btblack.alpha=0.3;
        self.whiteview.alpha=1;
        self.whiteview.hidden=NO;
        self.hidden=NO;
}completion:^(BOOL finished) {
        
    }];
}
/**
 *  隐藏
 */
-(void)hiddenView
{
    
    [_tfmoney resignFirstResponder];
    _tfmoney.text=@"";
    [UIView animateWithDuration:0.2f animations:^{
        self.bgView.alpha = 0;
        self.btblack.alpha=0;
        self.whiteview.alpha=0;
        
    } completion:^(BOOL finished) {
        _bgView.hidden=YES;
        self.hidden=YES;
        
        
    }];
}


//
//-(void)setBetArray:(NSArray *)betArray{
//    _betArray=betArray;
//    CGFloat W = (_whiteview.width-20)/3;
//    CGFloat H = 30;
//    [_scrollview removeAllSubviews];
//    for (int i = 0; i<_betArray.count; i++) {
//        UILabel*lable = [[UILabel alloc]initWithFrame:CGRectMake((W+5)*(i%3)+5,10 +(i/3) * (H+10), W, H)];
//        BetModel*model=[betArray objectAtIndex:i];
//        lable.backgroundColor=RedColor;
//        lable.text=[NSString stringWithFormat:@"%@%@",model.bettitle,model.title];
//        lable.textColor=[UIColor whiteColor];
//        lable.textAlignment = NSTextAlignmentCenter;
//        lable.font=[UIFont systemFontOfSize:MiddleFont];
//        [_scrollview addSubview:lable];
//    }
//
//    if (_betArray.count<=3) {
//        _scrollview.frame=CGRectMake(0, 0, _whiteview.width,50);
//        _scrollview.contentSize = CGSizeMake(_whiteview.width, 40);
//
//    }else if (_betArray.count>3&&_betArray.count<=6){
//        _scrollview.frame=CGRectMake(0, 0, _whiteview.width,90);
//        _scrollview.contentSize = CGSizeMake(_whiteview.width, 80);
//
//    }else{
//        _scrollview.frame=CGRectMake(0, 0, _whiteview.width,130);
//        if (_betArray.count%3==0) {
//            _scrollview.contentSize = CGSizeMake(_whiteview.width,_betArray.count/3*40+10);
//        }else{
//            _scrollview.contentSize = CGSizeMake(_whiteview.width, (_betArray.count/3+1)*40+10);
//        }
//
//
//    }
//    [self setviewfrem];
//}



@end
