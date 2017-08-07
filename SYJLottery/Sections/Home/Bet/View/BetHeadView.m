//
//  BetHeadView.m
//  longzhicai
//
//  Created by lili on 2017/3/29.
//  Copyright © 2017年 wkw. All rights reserved.
//

#import "BetHeadView.h"
#define LABLESIZE    IPhone4_5_6_6P(24, 24, 28, 30)     //开奖号码的尺寸
#define SYMBOLSIZE   IPhone4_5_6_6P(20, 20, 23, 25)     //符号+=的尺寸


@interface BetHeadView ()
{
    UIButton    *_btindependent;     //自主下注
    UIButton    *_btquick;           //快捷下注
    UIImageView *_imgchoose;         //红线
    UIView      *_resultview;        //上期开奖结果
    UIButton    *_button;            //开奖视频
    UIView      *_seleteview;        //选择自主快捷view
}
@end

@implementation BetHeadView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
-(void)initUI
{
    
    _lbresults = [[UILabel alloc] initWithFrame:CGRectMake(10,10, 200, 20)];
    _lbresults.textColor =BlackTitleColor;
    _lbresults.text=@"18998期开奖";
    _lbresults.font = [UIFont mysystemFontOfSize:MiddleFont];
    _lbresults.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_lbresults];
    
    _resultview=[[UIView alloc]initWithFrame:CGRectMake(10, 40, MSW-20, 30)];
    _resultview.backgroundColor=[UIColor whiteColor];
    [self addSubview:_resultview];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(10, 75,100, 25);
    [_button addTarget:self action:@selector(clicklotteryvideo) forControlEvents:UIControlEventTouchUpInside];
    [_button setTitleColor:RedColor forState:0];
    _button.titleLabel.font=[UIFont systemFontOfSize:BigFont];
    _button.backgroundColor=[UIColor clearColor];
    [_button setImage:[UIImage imageNamed:@"bet_play"] forState:UIControlStateNormal];
    _button.layer.cornerRadius = 5;
    _button.layer.borderWidth = 1;
    [_button setTitle:@"开奖视频" forState:0];
    _button.layer.borderColor = RedColor.CGColor;
    _button.adjustsImageWhenHighlighted=NO;
    [self addSubview:_button];
    
    
    _seleteview=[[UIView alloc]initWithFrame:CGRectMake(0, 80, MSW, 40)];
    [self addSubview:_seleteview];
    
    
    
    UILabel*lbline=[[UILabel alloc]initWithFrame:CGRectMake(0,0, MSW, 1)];
    lbline.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [_seleteview addSubview:lbline];
    
    _btindependent=[[UIButton alloc]initWithFrame:CGRectMake(0, 1, MSW/2, _seleteview.height-1)];
    _btindependent.backgroundColor=[UIColor clearColor];
    [_btindependent setTitle:@"自选下注" forState:0];
    _btindependent.tag=101;
    [_btindependent addTarget:self action:@selector(seletebettypewithbutton:) forControlEvents:UIControlEventTouchUpInside];
    _btindependent.titleLabel.font=[UIFont mysystemFontOfSize:16];
    [_btindependent setTitleColor:BlackTitleColor forState:0];
    [_seleteview addSubview:_btindependent];
    
    _btquick=[[UIButton alloc]initWithFrame:CGRectMake(_btindependent.right, _btindependent.top, MSW/2, _seleteview.height-1)];
    _btquick.backgroundColor=[UIColor clearColor];
    [_btquick setTitle:@"快捷下注" forState:0];
    _btquick.tag=102;
    [_btquick addTarget:self action:@selector(seletebettypewithbutton:) forControlEvents:UIControlEventTouchUpInside];
    _btquick.titleLabel.font=[UIFont mysystemFontOfSize:15];
    [_btquick setTitleColor:BlackDescColor forState:0];
    [_seleteview addSubview:_btquick];
    _imgchoose=[[UIImageView alloc]initWithFrame:CGRectMake(0, _seleteview.height-1.5, MSW/2, 1.5)];
    _imgchoose.image=[UIImage imageNamed:@"bet_betdetail_choose"];
    [_seleteview addSubview:_imgchoose];
    _button.hidden=YES;
    
    
    //    UILabel*lbline2=[[UILabel alloc]initWithFrame:CGRectMake(0, _imgchoose.bottom, MSW, 5)];
    //    lbline2.backgroundColor=SepearGrayLineColor;
    //    [self addSubview:lbline2];
    
}
-(void)setModel:(BetDetailHeadModel *)Model{
    _Model=Model;
    
    DLog(@"-=-=-----%@=-------%@",_lotterytype,_Model.openResult);
    
    if (_Model.openResult.count >1) {
        _lbresults.text=[NSString stringWithFormat:@"%@期开奖",_Model.lastSessionNo];
        
    }else{
        NSDictionary* style = @{@"body" :
                                    @[
                                        BlackTitleColor],
                                @"u": @[RedColor, ]};
        _lbresults.attributedText = [[NSString stringWithFormat:@"%@期<u>正在开奖中...</u>",_Model.lastSessionNo] attributedStringWithStyleBook:style];
        
    }
    [_resultview removeAllSubviews];
    
    DLog(@"-=---%@",_lotterytype);
    
    if ([_lotterytype isEqualToString:@"0"]||[_lotterytype isEqualToString:@"1"]||[_lotterytype isEqualToString:@"11"]) {  //彩票的种类[data.gamelist]游戏类型， 0=三份彩 1=北京赛车 2=幸运28 3=重庆时时彩 4=PC蛋蛋 5=广东快乐10分
        if (_Model.openResult.count>0) {
            for(int i = 0; i < _Model.openResult.count; i++)
            {
                UIButton*btball=[[UIButton alloc]init];
                btball.frame =CGRectMake(i*IPhone4_5_6_6P(29, 29, 33, 35), 3, LABLESIZE, LABLESIZE);
                btball.titleLabel.textColor=[UIColor whiteColor];
                btball.titleLabel.font=[UIFont systemFontOfSize:BigFont];
                [btball setBackgroundImage:[UIImage imageNamed:@"lettery_red"] forState:UIControlStateNormal];
                btball.userInteractionEnabled=NO;
                [btball setTitle:[NSString stringWithFormat:@"%@",[_Model.openResult objectAtIndex:i]]  forState:0];
                [_resultview addSubview:btball];
            }
        }else{
            
            for(int i = 0; i < 5; i++)
            {
                UIButton*btball=[[UIButton alloc]init];
                btball.frame =CGRectMake(i*IPhone4_5_6_6P(29, 29, 33, 35), 3, LABLESIZE, LABLESIZE);
                btball.titleLabel.textColor=[UIColor whiteColor];
                btball.titleLabel.font=[UIFont systemFontOfSize:BigFont];
                [btball setBackgroundImage:[UIImage imageNamed:@"lettery_red"] forState:UIControlStateNormal];
                btball.userInteractionEnabled=NO;
                [btball setTitle:[NSString stringWithFormat:@"-"]  forState:0];
                [_resultview addSubview:btball];
            }        }
        
    }else if ([_lotterytype isEqualToString:@"2"]||[_lotterytype isEqualToString:@"4"]||[_lotterytype isEqualToString:@"8"]||[_lotterytype isEqualToString:@"10"]){
        
        DLog(@"-=------%li",_Model.openResult.count);
        NSArray*symbolarr=@[@"+",@"+",@"="];
        if (_Model.openResult.count>0) {
            NSString*color=[_Model.openResult objectAtIndex:_Model.openResult.count-1]; 
            for(int i = 0; i < _Model.openResult.count-1; i++)
            {
                
                UIButton*btball=[[UIButton alloc]init];
                btball.frame = CGRectMake(i*45, 0, LABLESIZE, LABLESIZE);
                btball.titleLabel.textColor=[UIColor whiteColor];
                btball.titleLabel.font=[UIFont systemFontOfSize:BigFont];
                [btball setBackgroundImage:[UIImage imageNamed:@"lettery_red"] forState:UIControlStateNormal];
                btball.userInteractionEnabled=NO;
                [btball setTitle:[NSString stringWithFormat:@"%@",[_Model.openResult objectAtIndex:i]]  forState:0];
                [_resultview addSubview:btball];
                
                if ([_lotterytype isEqualToString:@"8"]) {
                    if (i==3) {//数组最后一位表示波色，0=无波色 1=绿波 2=蓝波 3=红波
                        if ([color isEqualToString:@"0"]) {
                            [btball setBackgroundImage:[UIImage imageNamed:@"bet_pk0"] forState:UIControlStateNormal];
                        }else if ([color isEqualToString:@"1"]){
                            [btball setBackgroundImage:[UIImage imageNamed:@"bet_pk1"] forState:UIControlStateNormal];
                        }else if ([color isEqualToString:@"2"]){
                            [btball setBackgroundImage:[UIImage imageNamed:@"bet_pk2"] forState:UIControlStateNormal];
                            
                        }else if ([color isEqualToString:@"3"]){
                            [btball setBackgroundImage:[UIImage imageNamed:@"bet_pk3"] forState:UIControlStateNormal];
                            
                        }else if ([color isEqualToString:@"4"]){
                            [btball setBackgroundImage:[UIImage imageNamed:@"bet_pk4"] forState:UIControlStateNormal];
                            
                        }else{
                            [btball setBackgroundImage:[UIImage imageNamed:@"bet_pk5"] forState:UIControlStateNormal];
                            
                        }
                    }
                }else{
                    if (i==3) {//数组最后一位表示波色，0=无波色 1=绿波 2=蓝波 3=红波
                        if ([color isEqualToString:@"0"]) {
                            [btball setBackgroundImage:[UIImage imageNamed:@"lettery_gray"] forState:UIControlStateNormal];
                        }else if ([color isEqualToString:@"1"]){
                            [btball setBackgroundImage:[UIImage imageNamed:@"lettery_green"] forState:UIControlStateNormal];
                        }else if ([color isEqualToString:@"2"]){
                            [btball setBackgroundImage:[UIImage imageNamed:@"lettery_blue"] forState:UIControlStateNormal];
                            
                        }else{
                            [btball setBackgroundImage:[UIImage imageNamed:@"lettery_red"] forState:UIControlStateNormal];
                        }
                    }
                }
                if (i<3) {
                    
                    UILabel *resultLbl = [[UILabel alloc] init];
                    resultLbl.frame = CGRectMake(i*45+24, 0, SYMBOLSIZE, SYMBOLSIZE);
                    resultLbl.backgroundColor = [UIColor clearColor];
                    resultLbl.text = [NSString stringWithFormat:@"%@",[symbolarr objectAtIndex:i]];
                    resultLbl.textColor = [UIColor blackColor];
                    resultLbl.textAlignment = NSTextAlignmentCenter;
                    resultLbl.adjustsFontSizeToFitWidth = YES;
                    [_resultview addSubview:resultLbl];
                }
                
            }
        }else{
            for(int i = 0; i <4; i++)
            {
                UIButton*btball=[[UIButton alloc]init];
                btball.frame = CGRectMake(i*45, 0, LABLESIZE, LABLESIZE);
                btball.titleLabel.textColor=[UIColor whiteColor];
                btball.titleLabel.font=[UIFont systemFontOfSize:BigFont];
                [btball setBackgroundImage:[UIImage imageNamed:@"lettery_red"] forState:UIControlStateNormal];
                btball.userInteractionEnabled=NO;
                [btball setTitle:@"-"  forState:0];
                [_resultview addSubview:btball];
                
                if (i<3) {
                    
                    UILabel *resultLbl = [[UILabel alloc] init];
                    resultLbl.frame = CGRectMake(i*45+24, 0, SYMBOLSIZE, SYMBOLSIZE);
                    resultLbl.backgroundColor = [UIColor clearColor];
                    resultLbl.text = [NSString stringWithFormat:@"%@",[symbolarr objectAtIndex:i]];
                    resultLbl.textColor = [UIColor blackColor];
                    resultLbl.textAlignment = NSTextAlignmentCenter;
                    resultLbl.adjustsFontSizeToFitWidth = YES;
                    [_resultview addSubview:resultLbl];
                }
                
            }
            
        }
    }
    else if ([_lotterytype isEqualToString:@"9"]){    //广东11选5
        NSArray*symbolarr=@[@"+",@"+",@"+",@"+",@"="];
        if (_Model.openResult.count>0) {
            for(int i = 0; i < _Model.openResult.count; i++)
            {
                
                UIButton*btball=[[UIButton alloc]init];
                btball.frame = CGRectMake(i*45, 0, LABLESIZE, LABLESIZE);
                btball.titleLabel.textColor=[UIColor whiteColor];
                btball.titleLabel.font=[UIFont systemFontOfSize:BigFont];
                [btball setBackgroundImage:[UIImage imageNamed:@"lettery_red"] forState:UIControlStateNormal];
                btball.userInteractionEnabled=NO;
                [btball setTitle:[NSString stringWithFormat:@"%@",[_Model.openResult objectAtIndex:i]]  forState:0];
                [_resultview addSubview:btball];
                
                if (i<5) {
                    
                    UILabel *resultLbl = [[UILabel alloc] init];
                    resultLbl.frame = CGRectMake(i*45+24, 0, SYMBOLSIZE, SYMBOLSIZE);
                    resultLbl.backgroundColor = [UIColor clearColor];
                    resultLbl.text = [NSString stringWithFormat:@"%@",[symbolarr objectAtIndex:i]];
                    resultLbl.textColor = [UIColor blackColor];
                    resultLbl.textAlignment = NSTextAlignmentCenter;
                    resultLbl.adjustsFontSizeToFitWidth = YES;
                    [_resultview addSubview:resultLbl];
                }
                
            }
        }
        
        else{
            
            for(int i = 0; i <6; i++)
            {
                UIButton*btball=[[UIButton alloc]init];
                btball.frame = CGRectMake(i*45, 0, LABLESIZE, LABLESIZE);
                btball.titleLabel.textColor=[UIColor whiteColor];
                btball.titleLabel.font=[UIFont systemFontOfSize:BigFont];
                [btball setBackgroundImage:[UIImage imageNamed:@"lettery_red"] forState:UIControlStateNormal];
                btball.userInteractionEnabled=NO;
                [btball setTitle:@"-"  forState:0];
                [_resultview addSubview:btball];
                
                if (i<5) {
                    
                    UILabel *resultLbl = [[UILabel alloc] init];
                    resultLbl.frame = CGRectMake(i*45+24, 0, SYMBOLSIZE, SYMBOLSIZE);
                    resultLbl.backgroundColor = [UIColor clearColor];
                    resultLbl.text = [NSString stringWithFormat:@"%@",[symbolarr objectAtIndex:i]];
                    resultLbl.textColor = [UIColor blackColor];
                    resultLbl.textAlignment = NSTextAlignmentCenter;
                    resultLbl.adjustsFontSizeToFitWidth = YES;
                    [_resultview addSubview:resultLbl];
                }
            }
        }
    }else if ([_lotterytype isEqualToString:@"3"]){
        if (_Model.openResult.count>0) {
            for(int i = 0; i < _Model.openResult.count; i++)
            {
                UIButton*btball=[[UIButton alloc]init];
                btball.frame =CGRectMake(i*IPhone4_5_6_6P(29, 29, 33, 35), 3, LABLESIZE, LABLESIZE);
                btball.titleLabel.textColor=[UIColor whiteColor];
                btball.titleLabel.font=[UIFont systemFontOfSize:BigFont];
                [btball setBackgroundImage:[UIImage imageNamed:@"lettery_red"] forState:UIControlStateNormal];
                btball.userInteractionEnabled=NO;
                [btball setTitle:[NSString stringWithFormat:@"%@",[_Model.openResult objectAtIndex:i]]  forState:0];
                [_resultview addSubview:btball];
                
            }
            
        }else{
            
            for(int i = 0; i < 5; i++)
            {
                UIButton*btball=[[UIButton alloc]init];
                btball.frame =CGRectMake(i*IPhone4_5_6_6P(29, 29, 33, 35), 3, LABLESIZE, LABLESIZE);
                btball.titleLabel.textColor=[UIColor whiteColor];
                btball.titleLabel.font=[UIFont systemFontOfSize:BigFont];
                [btball setBackgroundImage:[UIImage imageNamed:@"lettery_red"] forState:UIControlStateNormal];
                btball.userInteractionEnabled=NO;
                [btball setTitle:[NSString stringWithFormat:@"-"]  forState:0];
                [_resultview addSubview:btball];
                
            }
        }
    }
    else{
        if (_Model.openResult.count>0) {
            for(int i = 0; i < _Model.openResult.count; i++)
            {
                UIButton*btball=[[UIButton alloc]init];
                btball.frame =CGRectMake(i*IPhone4_5_6_6P(29, 29, 33, 35), 3, LABLESIZE, LABLESIZE);
                btball.titleLabel.textColor=[UIColor whiteColor];
                btball.titleLabel.font=[UIFont systemFontOfSize:BigFont];
                [btball setBackgroundImage:[UIImage imageNamed:@"lettery_red"] forState:UIControlStateNormal];
                btball.userInteractionEnabled=NO;
                [btball setTitle:[NSString stringWithFormat:@"%@",[_Model.openResult objectAtIndex:i]]  forState:0];
                [_resultview addSubview:btball];
                
                
            }
            
        }else{
            
            for(int i = 0; i < 8; i++)
            {
                UIButton*btball=[[UIButton alloc]init];
                btball.frame =CGRectMake(i*IPhone4_5_6_6P(29, 29, 33, 35), 3, LABLESIZE, LABLESIZE);
                btball.titleLabel.textColor=[UIColor whiteColor];
                btball.titleLabel.font=[UIFont systemFontOfSize:BigFont];
                [btball setBackgroundImage:[UIImage imageNamed:@"lettery_red"] forState:UIControlStateNormal];
                btball.userInteractionEnabled=NO;
                [btball setTitle:[NSString stringWithFormat:@"-"]  forState:0];
                [_resultview addSubview:btball];
            }
            
            
        }
        
    }
    
}
-(void)setLotterytype:(NSString *)lotterytype{
    _lotterytype=lotterytype;
    //    if ([lotterytype isEqualToString:@"1"]||[lotterytype isEqualToString:@"3"]) {//北京赛车
    //        _button.hidden=NO;
    //        _button.frame=CGRectMake(10, 75,100, 25);
    //        _seleteview.frame=CGRectMake(0, _button.bottom+5, MSW, 35);
    //    }else{
    _button.hidden=YES;
    _seleteview.frame=CGRectMake(0, 80, MSW, 35);
    //    }
    
}


//点击开奖视频
-(void)clicklotteryvideo{
    [self.delegate clicklotteryvideo];
}
-(void)seletebettypewithbutton:(UIButton*)button{
//    [MusicHelper showclickmusic];
    
    if (button.tag==101) {
        [UIView animateWithDuration:0.3 animations:^{
            _imgchoose.frame = CGRectMake(0, _btindependent.bottom-1.5,MSW/2,1.5);
        }];
        [_btindependent setTitleColor:BlackTitleColor forState:0];
        _btindependent.titleLabel.font=[UIFont mysystemFontOfSize:16];
        _btquick.titleLabel.font=[UIFont mysystemFontOfSize:15];
        
        [_btquick setTitleColor:BlackDescColor forState:0];
        [self.delegate seletebettypewithindex:1];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            _imgchoose.frame = CGRectMake(_btindependent.right, _btindependent.bottom-1.5,MSW/2,1.5);
        }];
        [_btindependent setTitleColor:BlackDescColor forState:0];
        [_btquick setTitleColor:BlackTitleColor forState:0];
        _btquick.titleLabel.font=[UIFont mysystemFontOfSize:16];
        _btindependent.titleLabel.font=[UIFont mysystemFontOfSize:15];
        [self.delegate seletebettypewithindex:2];
        
    }
    
}
@end
