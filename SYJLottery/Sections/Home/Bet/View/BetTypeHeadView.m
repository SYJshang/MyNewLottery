//
//  BetTypeHeadView.m
//  longzhicai
//
//  Created by lili on 2017/3/29.
//  Copyright © 2017年 wkw. All rights reserved.
//

#import "BetTypeHeadView.h"
@interface BetTypeHeadView ()
{
    UIImageView    *_imgarrow;     // 向右箭头
    NSMutableArray *_lbarray;
}
@end

@implementation BetTypeHeadView
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
    self.backgroundColor=RGBCOLOR(253, 253, 253);
    UILabel*lbheadline=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, MSW, 10)];
    lbheadline.backgroundColor=SepearGrayLineColor;
    [self addSubview:lbheadline];
    _imgarrow=[[UIImageView alloc]initWithFrame:CGRectMake(MSW-25, 22.5, 15, 15)];
    _imgarrow.image=[UIImage imageNamed:@"bet_down"];
    [self addSubview:_imgarrow];
    
    _lbarray=[NSMutableArray array];
    for(int i = 0; i < 4; i++)
    {
        UILabel *lbtitle = [[UILabel alloc] init];
        lbtitle.frame = CGRectMake(i*MSW/4+10, 10, MSW/4, self.frame.size.height-10);
        lbtitle.textColor = [UIColor colorWithHex:@"#666666"];
        lbtitle.font=[UIFont mysystemFontOfSize:15];
        [self addSubview:lbtitle];
        [_lbarray addObject:lbtitle];
    }

    UIButton*btclick=[[UIButton alloc]initWithFrame:CGRectMake(0, 10, MSW, self.frame.size.height-10)];
    btclick.backgroundColor=[UIColor clearColor];
    [btclick addTarget:self action:@selector(clickview) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:btclick];
    self.isopen=YES;
    
}

-(void)clickview{
    if (_isopen==YES) {
        _isopen=NO;
        _imgarrow.image=[UIImage imageNamed:@"bet_goto"];

    }else{
        _isopen=YES;
        _imgarrow.image=[UIImage imageNamed:@"bet_down"];

    }

    [self.delegate clickviewwithtag:_viewtag isopen:_isopen];
}
-(void)setTitleArray:(NSArray *)titleArray{
    _titleArray=titleArray;
    for (int i=0; i<_titleArray.count; i++) {
        UILabel*lbtitle=[_lbarray objectAtIndex:i];
        lbtitle.text=[_titleArray objectAtIndex:i];
    }
}






@end
