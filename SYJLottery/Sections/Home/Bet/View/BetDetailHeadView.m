//
//  BetDetailHeadView.m
//  longzhicai
//
//  Created by lili on 2017/3/27.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import "BetDetailHeadView.h"
#define RIGHTWITH    100     //、右边的宽
#define TIMEWITH    3        //时分秒间距
@interface BetDetailHeadView ()

@property (nonatomic, strong) dispatch_source_t timer; // 定时器

@end

@implementation BetDetailHeadView
{
    UILabel     *_lbnper;           //期数
    UILabel     *_lbwin;            //输赢
    UILabel     *_lbtime;           //开奖时间
    UILabel     *_lbh;              //时
    UILabel     *_lbm;              //分
    UILabel     *_lbs;              //秒
    
    int              bettime;       //投注剩余时间     用以转换成时间格式   显示
    
}

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
    self.backgroundColor=[UIColor whiteColor];
    _lblottery = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, (MSW-RIGHTWITH)-20, 20)];
    _lblottery.textAlignment = NSTextAlignmentLeft;
    _lblottery.font = [UIFont systemFontOfSize:IPhone4_5_6_6P(13, 13, 15, 15)];
    //1.改变字符串中某几个字的颜色
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"北京时时彩 "];
//    [str addAttribute:NSForegroundColorAttributeName value:BlackTitleColor range:NSMakeRange(0,5)];
//    
//    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5,3)];
//    _lblottery.attributedText = str;
    [self addSubview:_lblottery];
    
    //    _lbnper = [[UILabel alloc] initWithFrame:CGRectMake(_lblottery.right,_lblottery.top,(MSW-RIGHTWITH)/2, 20)];
    //    _lbnper.textColor =BlackTitleColor;
    //    _lbnper.text=@"17898998期";
    //    _lbnper.font = [UIFont systemFontOfSize:15];
    //    _lbnper.textAlignment = NSTextAlignmentLeft;
    //    [self addSubview:_lbnper];
    
    _lbwin = [[UILabel alloc] initWithFrame:CGRectMake(_lblottery.left,_lblottery.bottom+5, MSW-RIGHTWITH-10, 20)];
    _lbwin.textColor =BlackTitleColor;
    _lbwin.text=@"今日输赢0.00 开奖时间00:00:00";
    _lbwin.font = [UIFont systemFontOfSize:MiddleFont];
    _lbwin.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_lbwin];
    //    _lbtime = [[UILabel alloc] initWithFrame:CGRectMake(_lblottery.right,_lbwin.top, 100, 20)];
    //    _lbtime.textColor =BlackDescColor;
    //    _lbtime.text=@"开奖时间14:00;90";
    //    _lbtime.font = [UIFont systemFontOfSize:SmallFont];
    //    _lbtime.textAlignment = NSTextAlignmentLeft;
    //    [self addSubview:_lbtime];
    //
    UILabel *lbline = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-1, MSW, 1)];
    lbline.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:lbline];
    UILabel *lbline2 = [[UILabel alloc] initWithFrame:CGRectMake(MSW-RIGHTWITH, 0, 1, self.frame.size.height)];
    lbline2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:lbline2];
    
    _lbtime = [[UILabel alloc] initWithFrame:CGRectMake(MSW-RIGHTWITH,_lblottery.top, RIGHTWITH, 20)];
    _lbtime.textColor =[UIColor blackColor];
    _lbtime.text=@"据截止下注";
    _lbtime.font = [UIFont systemFontOfSize:BigFont];
    _lbtime.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lbtime];
    
    
    _lbh = [[UILabel alloc] initWithFrame:CGRectMake(MSW-RIGHTWITH/5*4-TIMEWITH,_lbtime.bottom, RIGHTWITH/5, 25)];
    _lbh.textColor =[UIColor whiteColor];
    _lbh.text=@"00";
    _lbh.backgroundColor=[UIColor colorWithHex:@"#333333"];
    _lbh.font = [UIFont systemFontOfSize:BigFont];
    _lbh.textAlignment = NSTextAlignmentCenter;
    _lbh.layer.cornerRadius = 5;
    _lbh.layer.masksToBounds = YES;
    [self addSubview:_lbh];
    
    _lbm = [[UILabel alloc] initWithFrame:CGRectMake(_lbh.right+TIMEWITH,_lbtime.bottom, RIGHTWITH/5, 25)];
    _lbm.textColor =[UIColor whiteColor];
    _lbm.text=@"00";
    _lbm.backgroundColor=[UIColor colorWithHex:@"#333333"];
    _lbm.font = [UIFont systemFontOfSize:BigFont];
    _lbm.textAlignment = NSTextAlignmentCenter;
    _lbm.layer.cornerRadius = 5;
    _lbm.layer.masksToBounds = YES;
    [self addSubview:_lbm];
    _lbs = [[UILabel alloc] initWithFrame:CGRectMake(_lbm.right+TIMEWITH,_lbtime.bottom, RIGHTWITH/5, 25)];
    _lbs.textColor =[UIColor whiteColor];
    _lbs.text=@"00";
    _lbs.backgroundColor=[UIColor colorWithHex:@"#333333"];
    _lbs.font = [UIFont systemFontOfSize:BigFont];
    _lbs.textAlignment = NSTextAlignmentCenter;
    _lbs.layer.cornerRadius = 5;
    _lbs.layer.masksToBounds = YES;
    [self addSubview:_lbs];
    
    
    UILabel*lbseparated = [[UILabel alloc] initWithFrame:CGRectMake(_lbh.right,_lbh.top, TIMEWITH, 25)];
    lbseparated.textColor =BlackDescColor;
    lbseparated.text=@":";
    lbseparated.font = [UIFont systemFontOfSize:BigFont];
    lbseparated.textAlignment = NSTextAlignmentCenter;
    [self addSubview:lbseparated];
    UILabel*lbseparated2 = [[UILabel alloc] initWithFrame:CGRectMake(_lbm.right,_lbh.top, TIMEWITH, 25)];
    lbseparated2.textColor =BlackDescColor;
    lbseparated2.text=@":";
    lbseparated2.font = [UIFont systemFontOfSize:BigFont];
    lbseparated2.textAlignment = NSTextAlignmentCenter;
    [self addSubview:lbseparated2];
    
    
}
-(void)setModel:(BetDetailHeadModel *)Model{
    _Model=Model;
    bettime = [_Model.betTime intValue];
    //    bettime=3610;
    NSString*timestr=[self SecondChange:[NSString stringWithFormat:@"%d",bettime]];
    NSArray *timearray = [timestr componentsSeparatedByString:@":"];
    _lbh.text = [timearray objectAtIndex:0];
    _lbm.text = [timearray objectAtIndex:1];
    _lbs.text = [timearray objectAtIndex:2];
    //    DLog(@"-=-=-=--当前剩余时间------  %@",_Model.betTime);
    if (bettime>0) {
        if(self.timer==nil)
        {
            [self starOpenTimer];
        }
    }
    NSDictionary* style = @{@"body" :
                                @[[UIFont systemFontOfSize:IPhone4_5_6_6P(13, 13, 15, 15)],
                                  BlackTitleColor],
                            @"u": @[[UIFont systemFontOfSize:IPhone4_5_6_6P(13, 13, 15, 15)],RedColor,
                                    
                                    ],@"v": @[[UIFont systemFontOfSize:IPhone4_5_6_6P(13, 13, 15, 15)],BlackTitleColor,
                                              
                                              ]};
    
    NSDictionary* style2 = @{@"body" :
                                 @[[UIFont systemFontOfSize:MiddleFont],
                                   BlackTitleColor],
                             @"u": @[[UIFont systemFontOfSize:MiddleFont],RedColor,
                                     
                                     ]};
    _lblottery.attributedText = [[NSString stringWithFormat:@"%@<u> %@ </u><v>%@期</v>",_Model.gameName,_Model.room,_Model.sessionNo] attributedStringWithStyleBook:style];
    _lbwin.attributedText = [[NSString stringWithFormat:@"今日输赢:<u>%@</u>  开奖时间:%@",_Model.gains,_Model.openDate] attributedStringWithStyleBook:style2];
    
    
}

-(void)starOpenTimer{
    
    // 创建队列               // 全局的并发队列            // 全局并发队列的优先级
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //        dispatch_queue_t queue = dispatch_get_main_queue();
    
    //1.先创建一个定时器对象
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    //2.设置定时器的各种属性
    //(1)什么时候开始定时器
    dispatch_time_t startTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC));
    //(2)隔多长时间执行一次 0.5s
    uint64_t interval = (int64_t)(1 * NSEC_PER_SEC);
    //(3)设置定时器
    dispatch_source_set_timer(self.timer, startTime, interval, 0);
    
    //3.设置回调
    dispatch_source_set_event_handler(self.timer, ^{
        //        NSLog(@"当前线程--%@",[NSThread currentThread]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self timerOpenTimer];
            
        });
    });
    
    //4.启动定时器 resume(重新开始)
    dispatch_resume(self.timer);
    
    
}
-(void)endOpenTimer{
    
    if (self.timer != nil) {
        dispatch_cancel(self.timer);
        self.timer = nil;
    }
    
}
-(void)endtime{
    
    [self endOpenTimer];
}
-(void)timerOpenTimer{
    
    bettime --;
    if (bettime<=0) {
        _lbh.text = @"00";
        _lbm.text = @"00";
        _lbs.text = @"00";
        @try {//有一定几率报错
            [self endOpenTimer];
            if ([self.delegate respondsToSelector:@selector(Thecountdowntotheend)]) {
                [self.delegate Thecountdowntotheend];

            }
            
        } @catch (NSException *exception) {
            DLog(@"异常处理-=-------%@",exception);
        } @finally {
            
        }
        
    }else{
        NSString*timestr=[self SecondChange:[NSString stringWithFormat:@"%d",bettime]];
        NSArray *timearray=[timestr componentsSeparatedByString:@":"];
        _lbh.text = [timearray objectAtIndex:0];
        _lbm.text = [timearray objectAtIndex:1];
        _lbs.text = [timearray objectAtIndex:2];
    }
    
}
#pragma 秒值转换
-(NSString *)SecondChange:(NSString *)timeStr{
    int time = timeStr.intValue;
    
    int hour = 0;
    int minute = 0;
    int second = 0;
    NSString *hourStr;
    NSString *minuteStr;
    NSString *secondStr;
    
    if (time >= 60 * 60) {
        hour = time/3600;
        minute = (time%3600)/60;
        second = time%60;
        
        
    }else if (time >= 60) {
        hour = 0;
        minute = time/ 60;
        second = time % 60;
    }else{
        hour = 0;
        minute = 0;
        second = time;
    }
    if (hour < 10) {
        hourStr = [NSString stringWithFormat:@"0%d",hour];
    }else{
        hourStr = [NSString stringWithFormat:@"%d",hour];
    }
    if (minute < 10) {
        minuteStr = [NSString stringWithFormat:@"0%d",minute];
    }else{
        minuteStr = [NSString stringWithFormat:@"%d",minute];
    }
    if (second < 10) {
        secondStr = [NSString stringWithFormat:@"0%d",second];
    }else{
        secondStr = [NSString stringWithFormat:@"%d",second];
    }
    
    return [NSString stringWithFormat:@"%@:%@:%@",hourStr,minuteStr,secondStr];
}
//传入 秒  得到 xx:xx:xx
-(NSString *)getMMSSFromSS:(NSString *)totalTime{
    
    NSInteger seconds = [totalTime integerValue];
    
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    
    return format_time;
    
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
