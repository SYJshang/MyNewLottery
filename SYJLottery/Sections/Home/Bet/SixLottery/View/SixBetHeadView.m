//
//  SixBetHeadView.m
//  longzhicai
//
//  Created by lili on 2017/6/7.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import "SixBetHeadView.h"
#define LABLESIZE    IPhone4_5_6_6P(24, 24, 28, 30)     //开奖号码的尺寸
#define SYMBOLSIZE   IPhone4_5_6_6P(20, 20, 23, 25)     //符号+=的尺寸

@interface SixBetHeadView ()
{
    UIButton    *_btindependent;     //自主下注
    UIButton    *_btquick;           //快捷下注
    UIImageView *_imgchoose;         //红线
    UIView      *_resultview;        //上期开奖结果
    UIButton    *_button;            //开奖视频
    UIView      *_seleteview;        //选择自主快捷view
}
@end

@implementation SixBetHeadView
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
-(void)setBettype:(NSString *)bettype{
//[data]是否只能快捷下载 0可以自选下载，1必须快捷下注
    
    if ([bettype isEqualToString:@"1"]) {
        _btindependent.hidden=YES;
        _imgchoose.hidden=YES;
        _btquick.frame=CGRectMake(0, 1, MSW,  39);
        
        [_btquick setTitleColor:BlackTitleColor forState:0];
        _btquick.titleLabel.font=[UIFont mysystemFontOfSize:16];
        _imgchoose.frame=CGRectMake(0, 38.5, MSW/2, 1.5);
    }else{
        _btindependent.hidden=NO;
        _imgchoose.hidden=NO;
        _imgchoose.frame=CGRectMake(0,38.5, MSW/2, 1.5);
        _btindependent.frame=CGRectMake(0, 1, MSW/2, 39);

        _btquick.frame=CGRectMake(_btindependent.right, _btindependent.top, MSW/2, 39);
        [_btindependent setTitleColor:BlackTitleColor forState:0];
        [_btquick setTitleColor:BlackDescColor forState:0];
        _btindependent.frame=CGRectMake(0, 1, MSW/2, 39);

        
    
    }

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
    
        if (_Model.openResult.count>0) {
            for(int i = 0; i < _Model.openResult.count; i++)
            {
                UIButton*btball=[[UIButton alloc]init];
                btball.frame =CGRectMake(i*IPhone4_5_6_6P(29, 29, 33, 35), 0, LABLESIZE, LABLESIZE);
                btball.titleLabel.textColor=[UIColor whiteColor];
                btball.titleLabel.font=[UIFont systemFontOfSize:BigFont];
                btball.userInteractionEnabled=NO;
                [btball setBackgroundImage:[UIImage imageNamed:@"lettery_red"] forState:UIControlStateNormal];
                [btball setTitle:[NSString stringWithFormat:@"%@",[_Model.openResult objectAtIndex:i]]  forState:0];
                [_resultview addSubview:btball];
        
                if (i==6) {
                    btball.frame =CGRectMake(i*IPhone4_5_6_6P(29, 29, 33, 35)+15, 0, LABLESIZE, LABLESIZE);
                    UILabel *resultLbl = [[UILabel alloc] init];
                    resultLbl.frame = CGRectMake(i*IPhone4_5_6_6P(29, 29, 33, 35)-5, 2.5, SYMBOLSIZE, SYMBOLSIZE);
                    resultLbl.backgroundColor = [UIColor clearColor];
                    resultLbl.text = @"+";
                    resultLbl.textColor = [UIColor blackColor];
                    resultLbl.textAlignment = NSTextAlignmentCenter;
                    [_resultview addSubview:resultLbl];
                    
                }

                
                
            }
        }else{
            
            for(int i = 0; i < 7; i++)
            {
                UIButton*btball=[[UIButton alloc]init];
                btball.frame =CGRectMake(i*IPhone4_5_6_6P(29, 29, 33, 35), 0, LABLESIZE, LABLESIZE);
                btball.titleLabel.textColor=[UIColor whiteColor];
                btball.titleLabel.font=[UIFont systemFontOfSize:BigFont];
                btball.userInteractionEnabled=NO;
                [btball setBackgroundImage:[UIImage imageNamed:@"lettery_red"] forState:UIControlStateNormal];
                [btball setTitle:[NSString stringWithFormat:@"-"]  forState:0];

                [_resultview addSubview:btball];
                
                if (i==6) {
                    btball.frame =CGRectMake(i*IPhone4_5_6_6P(29, 29, 33, 35)+15, 0, LABLESIZE, LABLESIZE);
                    UILabel *resultLbl = [[UILabel alloc] init];
                    resultLbl.frame = CGRectMake(i*IPhone4_5_6_6P(29, 29, 33, 35)-5, 2.5, SYMBOLSIZE, SYMBOLSIZE);
                    resultLbl.backgroundColor = [UIColor clearColor];
                    resultLbl.text = @"+";
                    resultLbl.textColor = [UIColor blackColor];
                    resultLbl.textAlignment = NSTextAlignmentCenter;
                    [_resultview addSubview:resultLbl];
                    
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
