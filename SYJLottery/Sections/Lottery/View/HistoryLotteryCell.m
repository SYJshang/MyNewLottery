//
//  HistoryLotteryCell.m
//  longzhicai
//
//  Created by lili on 2017/3/23.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import "HistoryLotteryCell.h"
#define LABLEHIGHT    23     //5个lable的高
#define LABLESIZE    IPhone4_5_6_6P(24, 24, 28, 30)     //开奖号码的尺寸
#define SYMBOLSIZE   IPhone4_5_6_6P(20, 20, 23, 25)     //符号+=的尺寸

@implementation HistoryLotteryCell
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

    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 136)];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_bgView];
    
    _numberView=[[UIView alloc]initWithFrame:CGRectMake(10, 40, MSW-20, 30)];
    _numberView.backgroundColor=[UIColor whiteColor];
    [self addSubview:_numberView];
    
    
    _lbtitle = [[UILabel alloc] initWithFrame:CGRectMake(10,10,100, 20)];
    _lbtitle.backgroundColor = [UIColor whiteColor];
    _lbtitle.font = [UIFont systemFontOfSize:BigFont];
    _lbtitle.textColor = BlackTitleColor;
    _lbtitle.text = @"天津时时彩";
    [_bgView addSubview:_lbtitle];
    
    _lbtime = [[UILabel alloc] initWithFrame:CGRectMake(_lbtitle.right+10,10, screen_width - 130, 20)];
    _lbtime.backgroundColor = [UIColor whiteColor];
    _lbtime.font = [UIFont systemFontOfSize:MiddleFont];
    _lbtime.textColor = [UIColor grayColor];
    _lbtime.textAlignment = NSTextAlignmentRight;
    _lbtime.text = @"第222222期2017-03-22 13:00:00";
    [_bgView addSubview:_lbtime];
    
    
    _lbtoplift = [[UILabel alloc] initWithFrame:CGRectMake(10,_lbtitle.bottom+47, (MSW-21)/2, LABLEHIGHT)];
    _lbtoplift.backgroundColor = RGBCOLOR(255, 222, 223);
    _lbtoplift.font = [UIFont systemFontOfSize:BigFont];
    _lbtoplift.textColor = BlackTitleColor;
    _lbtoplift.textAlignment = NSTextAlignmentCenter;
    _lbtoplift.text = @"总和";
    [_bgView addSubview:_lbtoplift];
    
    _lbtopright = [[UILabel alloc] initWithFrame:CGRectMake(_lbtoplift.right+1,_lbtoplift.top, (MSW-21)/2, LABLEHIGHT)];
    _lbtopright.backgroundColor = RGBCOLOR(255, 222, 223);
    _lbtopright.font = [UIFont systemFontOfSize:BigFont];
    _lbtopright.textColor = BlackTitleColor;
    _lbtopright.textAlignment = NSTextAlignmentCenter;
    _lbtopright.text = @"龙虎";
    [_bgView addSubview:_lbtopright];

    _lbdownliftone = [[UILabel alloc] init];
    _lbdownliftone.backgroundColor = RGBCOLOR(255, 242, 242);
    _lbdownliftone.font = [UIFont systemFontOfSize:BigFont];
    _lbdownliftone.textColor =BlackTitleColor;
    _lbdownliftone.textAlignment = NSTextAlignmentCenter;
    _lbdownliftone.text = @"10";
    [_bgView addSubview:_lbdownliftone];

    _lbdownlifttwo= [[UILabel alloc] init];
    _lbdownlifttwo.backgroundColor = RGBCOLOR(255, 242, 242);
    _lbdownlifttwo.font = [UIFont systemFontOfSize:BigFont];
    _lbdownlifttwo.textColor = BlackTitleColor;
    _lbdownlifttwo.textAlignment = NSTextAlignmentCenter;
    _lbdownlifttwo.text = @"小";
    [_bgView addSubview:_lbdownlifttwo];
    
    _lbdownliftthr= [[UILabel alloc] init];
    _lbdownliftthr.backgroundColor = RGBCOLOR(255, 242, 242);
    _lbdownliftthr.font = [UIFont systemFontOfSize:BigFont];
    _lbdownliftthr.textColor = BlackTitleColor;
    _lbdownliftthr.textAlignment = NSTextAlignmentCenter;
    _lbdownliftthr.text = @"单";
    [_bgView addSubview:_lbdownliftthr];
    
    _lbdownliftfour= [[UILabel alloc] init];
    _lbdownliftfour.backgroundColor = RGBCOLOR(255, 242, 242);
    _lbdownliftfour.font = [UIFont systemFontOfSize:BigFont];
    _lbdownliftfour.textColor = BlackTitleColor;
    _lbdownliftfour.textAlignment = NSTextAlignmentCenter;
    _lbdownliftfour.text = @"单";
    [_bgView addSubview:_lbdownliftfour];

    _lbdownright= [[UILabel alloc] initWithFrame:CGRectMake(_lbtopright.left,_lbtopright.bottom, _lbtopright.width, LABLEHIGHT)];
    _lbdownright.backgroundColor = RGBCOLOR(255, 242, 242);
    _lbdownright.font = [UIFont systemFontOfSize:BigFont];
    _lbdownright.textColor = BlackTitleColor;
    _lbdownright.textAlignment = NSTextAlignmentCenter;
    _lbdownright.text = @"虎";
    [_bgView addSubview:_lbdownright];
    CGSize size=CGSizeMake(3, 3);
    _lbdownliftone.frame=CGRectIntegral(CGRectMake(_lbtoplift.left,_lbtoplift.bottom, _lbtoplift.width/3, LABLEHIGHT));

    
    [self renYiYuanJiao:_lbtoplift size:size left:1 right:0 bottomLeft:0 bottomRight:0 ];
    [self renYiYuanJiao:_lbtopright size:size left:0 right:1 bottomLeft:0 bottomRight:0 ];
    [self renYiYuanJiao:_lbdownright size:size left:0 right:0 bottomLeft:0 bottomRight:1];
    [self renYiYuanJiao:_lbdownliftone size:size left:0 right:0 bottomLeft:1 bottomRight:0 ];
        UILabel*lbline=[[UILabel alloc]initWithFrame:CGRectMake(_lbtoplift.right-0.2,_lbtoplift.top ,1.4, LABLEHIGHT*2)];
        lbline.backgroundColor=[UIColor whiteColor];
        [_bgView addSubview:lbline];

    
    DLog(@"-=-=------%@",_typestr);
    
    
    _lbdownliftone.frame=CGRectIntegral(CGRectMake(_lbtoplift.left,_lbtoplift.bottom, _lbtoplift.width/3, LABLEHIGHT));
    _lbdownlifttwo.frame=CGRectIntegral(CGRectMake(_lbdownliftone.right,_lbtoplift.bottom, _lbtoplift.width/3, LABLEHIGHT));
    _lbdownliftthr.frame=CGRectIntegral(CGRectMake(_lbdownlifttwo.right,_lbtoplift.bottom, _lbtoplift.width/3, LABLEHIGHT));
    
    _typestr=[MyConfig currentConfig].bettype;
    //彩票类型， 0=三份彩 1=北京赛车 2=幸运28 3=重庆时时彩 4=PC蛋蛋 5=广东快乐10分
    if ([_typestr isEqualToString:@"0"]) {
        _lbdownliftone.frame=CGRectIntegral(CGRectMake(_lbtoplift.left,_lbtoplift.bottom, _lbtoplift.width/3, LABLEHIGHT));
        _lbdownlifttwo.frame=CGRectIntegral(CGRectMake(_lbdownliftone.right,_lbtoplift.bottom, _lbtoplift.width/3, LABLEHIGHT));
        _lbdownliftthr.frame=CGRectIntegral(CGRectMake(_lbdownlifttwo.right,_lbtoplift.bottom, _lbtoplift.width/3, LABLEHIGHT));
    }else if ([_typestr isEqualToString:@"1"]){
        _lbdownliftone.frame=CGRectIntegral(CGRectMake(_lbtoplift.left,_lbtoplift.bottom, _lbtoplift.width/3, LABLEHIGHT));
        _lbdownlifttwo.frame=CGRectIntegral(CGRectMake(_lbdownliftone.right,_lbtoplift.bottom, _lbtoplift.width/3, LABLEHIGHT));
        _lbdownliftthr.frame=CGRectIntegral(CGRectMake(_lbdownlifttwo.right,_lbtoplift.bottom, _lbtoplift.width/3, LABLEHIGHT));
        _lbtopright.text = @"1-5龙虎";
        
    }
    else if ([_typestr isEqualToString:@"2"]){
        _lbdownliftone.frame=CGRectIntegral(CGRectMake(_lbtoplift.left,_lbtoplift.bottom, _lbtoplift.width/4, LABLEHIGHT));
        _lbdownlifttwo.frame=CGRectIntegral(CGRectMake(_lbdownliftone.right,_lbtoplift.bottom, _lbtoplift.width/4, LABLEHIGHT));
        _lbdownliftthr.frame=CGRectIntegral(CGRectMake(_lbdownlifttwo.right,_lbtoplift.bottom, _lbtoplift.width/4, LABLEHIGHT));
        _lbdownliftfour.frame=CGRectIntegral(CGRectMake(_lbdownliftthr.right,_lbtoplift.bottom, _lbtoplift.width/4, LABLEHIGHT));
        _lbtopright.text = @"波色";
    }
    else if ([_typestr isEqualToString:@"3"]){
        _lbdownliftone.frame=CGRectIntegral(CGRectMake(_lbtoplift.left,_lbtoplift.bottom, _lbtoplift.width/3, LABLEHIGHT));
        _lbdownlifttwo.frame=CGRectIntegral(CGRectMake(_lbdownliftone.right,_lbtoplift.bottom, _lbtoplift.width/3, LABLEHIGHT));
        _lbdownliftthr.frame=CGRectIntegral(CGRectMake(_lbdownlifttwo.right,_lbtoplift.bottom, _lbtoplift.width/3, LABLEHIGHT));
    }
    else if ([_typestr isEqualToString:@"4"]){
        _lbdownliftone.frame=CGRectIntegral(CGRectMake(_lbtoplift.left,_lbtoplift.bottom, _lbtoplift.width/4, LABLEHIGHT));
        _lbdownlifttwo.frame=CGRectIntegral(CGRectMake(_lbdownliftone.right,_lbtoplift.bottom, _lbtoplift.width/4, LABLEHIGHT));
        _lbdownliftthr.frame=CGRectIntegral(CGRectMake(_lbdownlifttwo.right,_lbtoplift.bottom, _lbtoplift.width/4, LABLEHIGHT));
        _lbdownliftfour.frame=CGRectIntegral(CGRectMake(_lbdownliftthr.right,_lbtoplift.bottom, _lbtoplift.width/4, LABLEHIGHT));
        _lbtopright.text = @"波色";
        
    }else{
        _lbdownliftone.frame=CGRectIntegral(CGRectMake(_lbtoplift.left,_lbtoplift.bottom, _lbtoplift.width/4, LABLEHIGHT));
        _lbdownlifttwo.frame=CGRectIntegral(CGRectMake(_lbdownliftone.right,_lbtoplift.bottom, _lbtoplift.width/4, LABLEHIGHT));
        _lbdownliftthr.frame=CGRectIntegral(CGRectMake(_lbdownlifttwo.right,_lbtoplift.bottom, _lbtoplift.width/4, LABLEHIGHT));
        _lbdownliftfour.frame=CGRectIntegral(CGRectMake(_lbdownliftthr.right,_lbtoplift.bottom, _lbtoplift.width/4, LABLEHIGHT));
        
    }

    
    
}
-(void)setHistorylotteryModel:(HistoryLotteryModel *)historylotteryModel{
    _historylotteryModel=historylotteryModel;
    [_numberView removeAllSubviews];
    _lbtitle.text = _historylotteryModel.gameName;
    _lbtime.text =[NSString stringWithFormat:@"第%@期 %@",_historylotteryModel.sessionNo,_historylotteryModel.openTime];
    _lbdownliftone.text=[_historylotteryModel.sumItems objectAtIndex:0];
    _lbdownlifttwo.text=[_historylotteryModel.sumItems objectAtIndex:1];
    _lbdownliftthr.text=[_historylotteryModel.sumItems objectAtIndex:2];
    _lbdownright.text=_historylotteryModel.longhu;
    if (_historylotteryModel.sumItems.count==4) {
        _lbdownliftfour.text=[_historylotteryModel.sumItems objectAtIndex:3];
    }
    
    //    _lbtitle.text = typestr;
    //彩票类型， 0=三份彩 1=北京赛车 2=幸运28 3=重庆时时彩 4=PC蛋蛋 5=广东快乐10分
   
    if ([_typestr isEqualToString:@"0"]) {
        for(int i = 0; i < _historylotteryModel.resultItems.count; i++)
        {
            UILabel *resultLbl = [[UILabel alloc] init];
            resultLbl.frame = CGRectMake(i*IPhone4_5_6_6P(29, 29, 33, 35), 0, LABLESIZE, LABLESIZE);
            resultLbl.text = [NSString stringWithFormat:@"%@",[_historylotteryModel.resultItems objectAtIndex:i]];
            resultLbl.textColor = [UIColor whiteColor];
            resultLbl.textAlignment = NSTextAlignmentCenter;
            [resultLbl setFont:[UIFont fontWithName:@"Helvetica-Bold" size:BigFont]];
            resultLbl.layer.cornerRadius = LABLESIZE/2;
            resultLbl.layer.backgroundColor =RedColor.CGColor;
//            resultLbl.backgroundColor = RedColor;

//            resultLbl.layer.masksToBounds = YES;
//            resultLbl.adjustsFontSizeToFitWidth = YES;
            [_numberView addSubview:resultLbl];
        }

    }else if ([_typestr isEqualToString:@"1"]){
        for(int i = 0; i < _historylotteryModel.resultItems.count; i++)
        {
            UILabel *resultLbl = [[UILabel alloc] init];
            resultLbl.frame = CGRectMake(i*IPhone4_5_6_6P(29, 29, 33, 35), 0, LABLESIZE, LABLESIZE);
            resultLbl.backgroundColor = RedColor;
            resultLbl.text = [NSString stringWithFormat:@"%@",[_historylotteryModel.resultItems objectAtIndex:i]];
            resultLbl.textColor = [UIColor whiteColor];
            resultLbl.textAlignment = NSTextAlignmentCenter;
            [resultLbl setFont:[UIFont fontWithName:@"Helvetica-Bold" size:BigFont]];
//            resultLbl.layer.backgroundColor =RedColor.CGColor;
            resultLbl.layer.cornerRadius = LABLESIZE/2;
            resultLbl.backgroundColor = RedColor;
            resultLbl.layer.masksToBounds = YES;
//            resultLbl.adjustsFontSizeToFitWidth = YES;
            [_numberView addSubview:resultLbl];
        }
    }
    else if ([_typestr isEqualToString:@"2"]){
        NSArray*symbolarr=@[@"+",@"+",@"="];
        NSString*color=[_historylotteryModel.resultItems objectAtIndex:_historylotteryModel.resultItems.count-1];

        for(int i = 0; i < _historylotteryModel.resultItems.count-1; i++)
        {
            UILabel *resultLbl = [[UILabel alloc] init];
            resultLbl.frame = CGRectMake(i*45, 0, LABLESIZE, LABLESIZE);
            resultLbl.text = [NSString stringWithFormat:@"%@",[_historylotteryModel.resultItems objectAtIndex:i]];
            resultLbl.textColor = [UIColor whiteColor];
            resultLbl.textAlignment = NSTextAlignmentCenter;
            [resultLbl setFont:[UIFont fontWithName:@"Helvetica-Bold" size:MiddleFont]];
//            resultLbl.layer.backgroundColor =RedColor.CGColor;
            resultLbl.layer.cornerRadius = LABLESIZE/2;
            resultLbl.backgroundColor = RedColor;
            resultLbl.layer.masksToBounds = YES;
//            resultLbl.adjustsFontSizeToFitWidth = YES;
            [_numberView addSubview:resultLbl];
            
            if (i==3) {//数组最后一位表示波色，0=无波色 1=绿波 2=蓝波 3=红波
                if ([color isEqualToString:@"0"]) {
                    resultLbl.backgroundColor = GrayColor;
                }else if ([color isEqualToString:@"1"]){
                    resultLbl.backgroundColor = GreenColor;
                }else if ([color isEqualToString:@"2"]){
                    resultLbl.backgroundColor = BlueColor;
                    
                }else{
                    resultLbl.backgroundColor = RedColor;
                    
                }
                
            }

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
    }
    else if ([_typestr isEqualToString:@"3"]){
        for(int i = 0; i < _historylotteryModel.resultItems.count; i++)
        {
            UILabel *resultLbl = [[UILabel alloc] init];
            resultLbl.frame = CGRectMake(i*IPhone4_5_6_6P(29, 29, 33, 35), 0, LABLESIZE, LABLESIZE);
            resultLbl.text = [NSString stringWithFormat:@"%@",[_historylotteryModel.resultItems objectAtIndex:i]];
            resultLbl.textColor = [UIColor whiteColor];
            resultLbl.textAlignment = NSTextAlignmentCenter;
            [resultLbl setFont:[UIFont fontWithName:@"Helvetica-Bold" size:BigFont]];
            resultLbl.layer.cornerRadius = LABLESIZE/2;
            resultLbl.layer.backgroundColor =RedColor.CGColor;
//            resultLbl.layer.masksToBounds = YES;
//            resultLbl.adjustsFontSizeToFitWidth = YES;
//            resultLbl.backgroundColor = RedColor;

            [_numberView addSubview:resultLbl];
        }
    }
    else if ([_typestr isEqualToString:@"4"]){
                NSArray*symbolarr=@[@"+",@"+",@"="];
        NSString*color=[_historylotteryModel.resultItems objectAtIndex:_historylotteryModel.resultItems.count-1];

                for(int i = 0; i < _historylotteryModel.resultItems.count-1; i++)
                {
                    UILabel *resultLbl = [[UILabel alloc] init];
                    resultLbl.frame = CGRectMake(i*45, 0, LABLESIZE, LABLESIZE);
                    resultLbl.text = [NSString stringWithFormat:@"%@",[_historylotteryModel.resultItems objectAtIndex:i]];
                    resultLbl.textColor = [UIColor whiteColor];
                    resultLbl.textAlignment = NSTextAlignmentCenter;
                    [resultLbl setFont:[UIFont fontWithName:@"Helvetica-Bold" size:MiddleFont]];
                    resultLbl.layer.cornerRadius = LABLESIZE/2;
//                    resultLbl.layer.backgroundColor =RedColor.CGColor;
                    resultLbl.backgroundColor = RedColor;
                    resultLbl.layer.masksToBounds = YES;
//                    resultLbl.adjustsFontSizeToFitWidth = YES;
                    [_numberView addSubview:resultLbl];
                    
                    if (i==3) {//数组最后一位表示波色，0=无波色 1=绿波 2=蓝波 3=红波
                        if ([color isEqualToString:@"0"]) {
                            resultLbl.backgroundColor =GrayColor;
                        }else if ([color isEqualToString:@"1"]){
                            resultLbl.backgroundColor = GreenColor;
                        }else if ([color isEqualToString:@"2"]){
                            resultLbl.backgroundColor = BlueColor;
                            
                        }else{
                            resultLbl.backgroundColor = RedColor;
                            
                        }
                        
                    }

                if (i<3) {
        
                        UILabel *resultLbl = [[UILabel alloc] init];
                        resultLbl.frame = CGRectMake(i*45+25, 2.5, SYMBOLSIZE, SYMBOLSIZE);
                        resultLbl.backgroundColor = [UIColor clearColor];
                        resultLbl.text = [NSString stringWithFormat:@"%@",[symbolarr objectAtIndex:i]];
                        resultLbl.textColor = [UIColor blackColor];
                        resultLbl.textAlignment = NSTextAlignmentCenter;
                        resultLbl.adjustsFontSizeToFitWidth = YES;
                        [_numberView addSubview:resultLbl];
                    }
                    
                }
    }
    else{
        for(int i = 0; i < _historylotteryModel.resultItems.count; i++)
        {
            UILabel *resultLbl = [[UILabel alloc] init];
            resultLbl.frame = CGRectMake(i*IPhone4_5_6_6P(29, 29, 33, 35), 0, LABLESIZE, LABLESIZE);
//            resultLbl.backgroundColor = RedColor;
            resultLbl.text = [NSString stringWithFormat:@"%@",[_historylotteryModel.resultItems objectAtIndex:i]];
            resultLbl.textColor = [UIColor whiteColor];
            resultLbl.textAlignment = NSTextAlignmentCenter;
            [self setLayerAndBezierPathCutCircularWithView:resultLbl roundedCornersSize:(LABLESIZE/2)];
            [resultLbl setFont:[UIFont fontWithName:@"Helvetica-Bold" size:BigFont]];
            resultLbl.layer.cornerRadius = LABLESIZE/2;
//            resultLbl.layer.masksToBounds = YES;
            resultLbl.layer.backgroundColor =RedColor.CGColor;
            
//            resultLbl.adjustsFontSizeToFitWidth = YES;
            [_numberView addSubview:resultLbl];

//            UIImageView*ima=[[UIImageView alloc]initWithFrame:resultLbl.frame];
//            ima.image=[UIImage imageNamed:@"lettery_cyrecl"];
//            [_numberView addSubview:ima];
        }

    
    }

}
#pragma mark - 通过layer和bezierPath 设置圆角
- (void)setLayerAndBezierPathCutCircularWithView:(UIView *) view roundedCornersSize:(CGFloat )cornersSize
{
    // 创建BezierPath 并设置角 和 半径 这里只设置了 左上 和 右上
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(cornersSize, cornersSize)];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.frame = view.bounds;
    layer.path = path.CGPath;
    view.layer.mask = layer;
}

/**
 
 view 传入要变圆角的视图
 
 size自己根据需要设置角度大小
 
 后面的4个角 BOOL 1 是设置该角为圆角 0 不改变
 
 */

- (void)renYiYuanJiao:(UIView *)view size:(CGSize)size left:(BOOL)left right:(BOOL)right bottomLeft:(BOOL)bottomLeft bottomRight:(BOOL)bottomRight {
    
    UIRectCorner Left = 0;
    
    UIRectCorner Right = 0;
    
    UIRectCorner BottomLeft = 0;
    
    UIRectCorner BottomRight = 0;
    
    if (left) {
        
        Left = UIRectCornerTopLeft;
        
    }
    
    if (right) {
        
        Right = UIRectCornerTopRight;;
        
    }
    
    if (bottomLeft) {
        
        BottomLeft = UIRectCornerBottomLeft;
        
    }
    
    if (bottomRight) {
        
        BottomRight = UIRectCornerBottomRight;
        
    }
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:Left|Right|BottomLeft|BottomRight cornerRadii:size];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = view.bounds;
    
    maskLayer.path = maskPath.CGPath;
    
    view.layer.mask = maskLayer;
    
}




-(void)setTypestr:(NSString *)typestr{

    _typestr=typestr;
////    _lbtitle.text = typestr;
//    //彩票类型， 0=三份彩 1=北京赛车 2=幸运28 3=重庆时时彩 4=PC蛋蛋 5=广东快乐10分
//    if ([_typestr isEqualToString:@"0"]) {
//        _lbdownliftone.frame=CGRectIntegral(CGRectMake(_lbtoplift.left,_lbtoplift.bottom, _lbtoplift.width/3, LABLEHIGHT));
//        _lbdownlifttwo.frame=CGRectIntegral(CGRectMake(_lbdownliftone.right,_lbtoplift.bottom, _lbtoplift.width/3, LABLEHIGHT));
//        _lbdownliftthr.frame=CGRectIntegral(CGRectMake(_lbdownlifttwo.right,_lbtoplift.bottom, _lbtoplift.width/3, LABLEHIGHT));
//    }else if ([_typestr isEqualToString:@"1"]){
//        _lbdownliftone.frame=CGRectIntegral(CGRectMake(_lbtoplift.left,_lbtoplift.bottom, _lbtoplift.width/3, LABLEHIGHT));
//        _lbdownlifttwo.frame=CGRectIntegral(CGRectMake(_lbdownliftone.right,_lbtoplift.bottom, _lbtoplift.width/3, LABLEHIGHT));
//        _lbdownliftthr.frame=CGRectIntegral(CGRectMake(_lbdownlifttwo.right,_lbtoplift.bottom, _lbtoplift.width/3, LABLEHIGHT));
//        _lbtopright.text = @"1-5龙虎";
//
//    }
//    else if ([_typestr isEqualToString:@"2"]){
//        _lbdownliftone.frame=CGRectIntegral(CGRectMake(_lbtoplift.left,_lbtoplift.bottom, _lbtoplift.width/4, LABLEHIGHT));
//        _lbdownlifttwo.frame=CGRectIntegral(CGRectMake(_lbdownliftone.right,_lbtoplift.bottom, _lbtoplift.width/4, LABLEHIGHT));
//        _lbdownliftthr.frame=CGRectIntegral(CGRectMake(_lbdownlifttwo.right,_lbtoplift.bottom, _lbtoplift.width/4, LABLEHIGHT));
//        _lbdownliftfour.frame=CGRectIntegral(CGRectMake(_lbdownliftthr.right,_lbtoplift.bottom, _lbtoplift.width/4, LABLEHIGHT));
//        _lbtopright.text = @"波色";
//    }
//    else if ([_typestr isEqualToString:@"3"]){
//        _lbdownliftone.frame=CGRectIntegral(CGRectMake(_lbtoplift.left,_lbtoplift.bottom, _lbtoplift.width/3, LABLEHIGHT));
//        _lbdownlifttwo.frame=CGRectIntegral(CGRectMake(_lbdownliftone.right,_lbtoplift.bottom, _lbtoplift.width/3, LABLEHIGHT));
//        _lbdownliftthr.frame=CGRectIntegral(CGRectMake(_lbdownlifttwo.right,_lbtoplift.bottom, _lbtoplift.width/3, LABLEHIGHT));
//    }
//    else if ([_typestr isEqualToString:@"4"]){
//        _lbdownliftone.frame=CGRectIntegral(CGRectMake(_lbtoplift.left,_lbtoplift.bottom, _lbtoplift.width/4, LABLEHIGHT));
//        _lbdownlifttwo.frame=CGRectIntegral(CGRectMake(_lbdownliftone.right,_lbtoplift.bottom, _lbtoplift.width/4, LABLEHIGHT));
//        _lbdownliftthr.frame=CGRectIntegral(CGRectMake(_lbdownlifttwo.right,_lbtoplift.bottom, _lbtoplift.width/4, LABLEHIGHT));
//        _lbdownliftfour.frame=CGRectIntegral(CGRectMake(_lbdownliftthr.right,_lbtoplift.bottom, _lbtoplift.width/4, LABLEHIGHT));
//        _lbtopright.text = @"波色";
//
//    }else{
//        _lbdownliftone.frame=CGRectIntegral(CGRectMake(_lbtoplift.left,_lbtoplift.bottom, _lbtoplift.width/4, LABLEHIGHT));
//        _lbdownlifttwo.frame=CGRectIntegral(CGRectMake(_lbdownliftone.right,_lbtoplift.bottom, _lbtoplift.width/4, LABLEHIGHT));
//        _lbdownliftthr.frame=CGRectIntegral(CGRectMake(_lbdownlifttwo.right,_lbtoplift.bottom, _lbtoplift.width/4, LABLEHIGHT));
//        _lbdownliftfour.frame=CGRectIntegral(CGRectMake(_lbdownliftthr.right,_lbtoplift.bottom, _lbtoplift.width/4, LABLEHIGHT));
//
//    }
////    CGSize size=CGSizeMake(3, 3);
////    [self renYiYuanJiao:_lbdownliftone size:size left:0 right:0 bottomLeft:1 bottomRight:0 ];
//
//
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
