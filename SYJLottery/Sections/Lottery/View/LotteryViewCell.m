//
//  LotteryViewCell.m
//  longzhicai
//
//  Created by lili on 2017/3/23.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import "LotteryViewCell.h"
#define LABLESIZE    IPhone4_5_6_6P(24, 24, 28, 30)     //开奖号码的尺寸
#define SYMBOLSIZE   IPhone4_5_6_6P(20, 20, 23, 25)     //符号+=的尺寸

@implementation LotteryViewCell
{
    UIView                *_bgView;
    UIView                *_numberView;      //存放号码的view
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(3, 0, screen_width-6, IPhone4_5_6_6P(75, 75, 85, 90))];
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.layer.cornerRadius = 4;
    [self.contentView addSubview:_bgView];
    
    _lbtitle = [[UILabel alloc] initWithFrame:CGRectMake(10,IPhone4_5_6_6P(10, 10, 15, 15),IPhone4_5_6_6P(85, 95, 100, 100), 20)];
    _lbtitle.backgroundColor = [UIColor whiteColor];
    _lbtitle.font = [UIFont systemFontOfSize:BigFont];
    _lbtitle.textColor = BlackTitleColor;
    _lbtitle.text = @"天津时时彩";
    [_bgView addSubview:_lbtitle];
    
    _lbtime = [[UILabel alloc] initWithFrame:CGRectMake(_lbtitle.right+IPhone4_5_6_6P(0, 0, 10, 10),_lbtitle.top, _bgView.width-_lbtitle.width-IPhone4_5_6_6P(20, 20, 30, 30), 20)];
    _lbtime.backgroundColor = [UIColor clearColor];
    _lbtime.font = [UIFont systemFontOfSize:MiddleFont];
    _lbtime.textColor =BlackDescColor;
    //    _lbtime.backgroundColor=[UIColor redColor];
    _lbtime.textAlignment = NSTextAlignmentRight;
    _lbtime.text = @"第222222期2017-03-22 13:00:00";
    [_bgView addSubview:_lbtime];
    
    _numberView=[[UIView alloc]initWithFrame:CGRectMake(10, _lbtitle.bottom+IPhone4_5_6_6P(10, 10, 15, 15), MSW-20, 30)];
    _numberView.backgroundColor=[UIColor whiteColor];
    [self addSubview:_numberView];
    
    
    
    
}
-(void)setModel:(LotteryModel *)Model{
    _Model=Model;
    _lbtitle.text = Model.gameName;
    _lbtime.text =[NSString stringWithFormat:@"第%@期 %@",_Model.openSessionNo,_Model.time];
    
    [_numberView removeAllSubviews];
    if (_Model.openResult.count>0) {
        
    }else{
        return;
    }
    //    游戏类型 0=三份彩 1=北京赛车 2=幸运28 3=重庆时时彩 4=PC蛋蛋 5=广东快乐10分
    //    DLog(@"-=====-----------%@----%@----",_Model.gameName,_Model.openSessionNo);
    

    if ([_Model.type isEqualToString:@"0"] ||[_Model.type isEqualToString:@"1"] ||[_Model.type isEqualToString:@"3"] ||[_Model.type isEqualToString:@"5"]||[_Model.type isEqualToString:@"6"]||[_Model.type isEqualToString:@"7"]||[_Model.type isEqualToString:@"11"]) {
        for(int i = 0; i < _Model.openResult.count; i++)
        {
            UIButton*btball=[[UIButton alloc]init];
            btball.frame = CGRectMake(i*IPhone4_5_6_6P(29, 29, 33, 35), 0, LABLESIZE, LABLESIZE);
            btball.titleLabel.textColor=[UIColor whiteColor];
            btball.titleLabel.font=[UIFont systemFontOfSize:BigFont];
            [btball setBackgroundImage:[UIImage imageNamed:@"lettery_red"] forState:UIControlStateNormal];
            btball.userInteractionEnabled=NO;
            [btball setTitle:[NSString stringWithFormat:@"%@",[_Model.openResult objectAtIndex:i]]  forState:0];
            [_numberView addSubview:btball];
        }
    }else if ([_Model.type isEqualToString:@"2"]||[_Model.type isEqualToString:@"4"]||[_Model.type isEqualToString:@"8"]||[_Model.type isEqualToString:@"10"])
    {
        NSArray*symbolarr=@[@"+",@"+",@"="];
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
            [_numberView addSubview:btball];
            
            if ([_Model.type isEqualToString:@"8"]) {
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
                }}
            if (i<3) {
                
                UILabel *resultLbl = [[UILabel alloc] init];
                resultLbl.frame = CGRectMake(i*45+25, 2.5, SYMBOLSIZE, SYMBOLSIZE);
                resultLbl.backgroundColor = [UIColor clearColor];
                resultLbl.text = [NSString stringWithFormat:@"%@",[symbolarr objectAtIndex:i]];
                resultLbl.textColor = [UIColor blackColor];
                resultLbl.textAlignment = NSTextAlignmentCenter;
                [_numberView addSubview:resultLbl];
            }
            
        }
    }else if ([_Model.type isEqualToString:@"12"]){  //六合彩
    
        for(int i = 0; i <_Model.openResult.count; i++)
        {
            
            UIButton*btball=[[UIButton alloc]init];
            btball.frame =CGRectMake(i*IPhone4_5_6_6P(29, 29, 33, 35), 0, LABLESIZE, LABLESIZE);
            btball.titleLabel.textColor=[UIColor whiteColor];
            btball.titleLabel.font=[UIFont systemFontOfSize:BigFont];
            btball.userInteractionEnabled=NO;
            [btball setBackgroundImage:[UIImage imageNamed:@"lettery_red"] forState:UIControlStateNormal];
            [btball setTitle:[NSString stringWithFormat:@"%@",[_Model.openResult objectAtIndex:i]]  forState:0];

            [_numberView addSubview:btball];
            
            if (i==6) {
                btball.frame =CGRectMake(i*IPhone4_5_6_6P(29, 29, 33, 35)+15, 0, LABLESIZE, LABLESIZE);
                UILabel *resultLbl = [[UILabel alloc] init];
                resultLbl.frame = CGRectMake(i*IPhone4_5_6_6P(29, 29, 33, 35)-5, 2.5, SYMBOLSIZE, SYMBOLSIZE);
                resultLbl.backgroundColor = [UIColor clearColor];
                resultLbl.text = @"+";
                resultLbl.textColor = [UIColor blackColor];
                resultLbl.textAlignment = NSTextAlignmentCenter;
                [_numberView addSubview:resultLbl];
                
            }
            
        }
        
    
    }
    else if ([_Model.type isEqualToString:@"9"]){
        NSArray*symbolarr=@[@"+",@"+",@"+",@"+",@"="];
        for(int i = 0; i < _Model.openResult.count; i++)
        {
            UIButton*btball=[[UIButton alloc]init];
            btball.frame = CGRectMake(i*45, 0, LABLESIZE, LABLESIZE);
            btball.titleLabel.textColor=[UIColor whiteColor];
            btball.titleLabel.font=[UIFont systemFontOfSize:BigFont];
            [btball setBackgroundImage:[UIImage imageNamed:@"lettery_red"] forState:UIControlStateNormal];
            btball.userInteractionEnabled=NO;
            [btball setTitle:[NSString stringWithFormat:@"%@",[_Model.openResult objectAtIndex:i]]  forState:0];
            [_numberView addSubview:btball];
          
    
        if (i<5) {
            
            UILabel *resultLbl = [[UILabel alloc] init];
            resultLbl.frame = CGRectMake(i*45+25, 2.5, SYMBOLSIZE, SYMBOLSIZE);
            resultLbl.backgroundColor = [UIColor clearColor];
            resultLbl.text = [NSString stringWithFormat:@"%@",[symbolarr objectAtIndex:i]];
            resultLbl.textColor = [UIColor blackColor];
            resultLbl.textAlignment = NSTextAlignmentCenter;
            [_numberView addSubview:resultLbl];
        }
        

        }
    
    
    }

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
