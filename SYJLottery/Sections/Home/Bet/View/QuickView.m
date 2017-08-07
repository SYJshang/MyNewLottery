//
//  QuickView.m
//  longzhicai
//
//  Created by lili on 2017/3/30.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import "QuickView.h"
@interface QuickView ()
{
    UIButton*btselete;
}
@end

@implementation QuickView

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
    
    _lbtitle = [[UILabel alloc] initWithFrame:CGRectMake(10,12,MSW/4-20, 15)];
    _lbtitle.textColor =BlackTitleColor;
    _lbtitle.text=@"大";
    _lbtitle.font = [UIFont systemFontOfSize:IPhone4_5_6_6P(11, 11, 12, 13)];
    _lbtitle.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lbtitle];
    _lbnumber = [[UILabel alloc] initWithFrame:CGRectMake(_lbtitle.left,_lbtitle.bottom,MSW/4-20, _lbtitle.height)];
    _lbnumber.textColor =RedColor;
    _lbnumber.text=@"1.985";
    _lbnumber.font = [UIFont systemFontOfSize:IPhone4_5_6_6P(10, 10, 11, 12)];
    _lbnumber.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lbnumber];
    btselete=[[UIButton alloc]initWithFrame:CGRectMake(10, 10, MSW/4-20, 35)];
    btselete.backgroundColor=[UIColor clearColor];
    btselete.layer.borderWidth = 1;
    btselete.layer.cornerRadius = 1;
    btselete.layer.masksToBounds = YES;
    
    btselete.layer.borderColor =[UIColor groupTableViewBackgroundColor].CGColor;
//    [btselete addTarget:self action:@selector(clickseletenumberwithbutton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btselete];
    _isselete=NO;
    
    UIButton*btplus=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSW/4,self.frame.size.height)];
    btplus.backgroundColor=[UIColor clearColor];
    [btplus addTarget:self action:@selector(clickseletenumberwithbutton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btplus];

    
    
    
}
-(void)setIsRotaryheader:(int)isRotaryheader{
    _isRotaryheader=isRotaryheader;
}
-(void)setModel:(BetModel *)Model{
    _Model=Model;
    _lbtitle.text=_Model.title;
    _lbnumber.text=_Model.rate;
}

-(void)clickseletenumberwithbutton:(UIButton*)button{
    
    
    if (_isRotaryheader==0) {
        
        if (_isselete==NO) {
            _isselete=YES;
            [btselete setBackgroundImage:[UIImage imageNamed:@"bet_betselected"] forState:UIControlStateNormal];
            btselete.layer.borderColor =[UIColor clearColor].CGColor;
            
            
        }else{
            _isselete=NO;
            btselete.layer.borderColor =LineColor.CGColor;
            [btselete setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            btselete.layer.cornerRadius = 1;
            btselete.layer.masksToBounds = YES;
            

            
        }
        
        [self.delegate seletebetmodelwithmodel:_Model Andisselete:_isselete];
        
    }else{
        [self.delegate seletebetmodelwithmodel:nil Andisselete:nil];
    }
}



@end
