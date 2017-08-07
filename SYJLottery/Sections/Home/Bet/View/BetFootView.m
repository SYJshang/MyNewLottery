//
//  BetFootView.m
//  longzhicai
//
//  Created by lili on 2017/3/27.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import "BetFootView.h"

@implementation BetFootView

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
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = SepearGrayLineColor.CGColor;
    UIButton*btempty=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, (MSW-120)/3, 49)];
    btempty.backgroundColor=[UIColor whiteColor];
    [btempty setTitle:@"清空选项" forState:0];
    btempty.tag=101;
    btempty.layer.borderWidth = 0.5;
    btempty.layer.borderColor = SepearGrayLineColor.CGColor;
    [btempty addTarget:self action:@selector(footviewclick:) forControlEvents:UIControlEventTouchUpInside];
    btempty.titleLabel.font=[UIFont systemFontOfSize:BigFont];
    [btempty setTitleColor:BlackTitleColor forState:0];
    [self addSubview:btempty];
    UIButton*btmovements=[[UIButton alloc]initWithFrame:CGRectMake(btempty.right, 0, (MSW-120)/3, 49)];
    btmovements.backgroundColor=[UIColor whiteColor];
    [btmovements setTitle:@"走势" forState:0];
    btmovements.tag=102;
    btmovements.layer.borderWidth = 0.5;
    btmovements.layer.borderColor = SepearGrayLineColor.CGColor;
    [btmovements addTarget:self action:@selector(footviewclick:) forControlEvents:UIControlEventTouchUpInside];
    btmovements.titleLabel.font=[UIFont systemFontOfSize:BigFont];
    [btmovements setTitleColor:BlackTitleColor forState:0];
    [self addSubview:btmovements];
    UIButton*btranking=[[UIButton alloc]initWithFrame:CGRectMake(btmovements.right, 0, (MSW-120)/3, 49)];
    btranking.backgroundColor=[UIColor whiteColor];
    [btranking setTitle:@"冷热排行" forState:0];
    btranking.tag=103;
    btranking.layer.borderWidth = 0.5;
    btranking.layer.borderColor = SepearGrayLineColor.CGColor;
    [btranking addTarget:self action:@selector(footviewclick:) forControlEvents:UIControlEventTouchUpInside];
    btranking.titleLabel.font=[UIFont systemFontOfSize:BigFont];
    [btranking setTitleColor:BlackTitleColor forState:0];
    [self addSubview:btranking];
    UIButton*btbet=[[UIButton alloc]initWithFrame:CGRectMake(btranking.right, 0, 120, 49)];
    btbet.backgroundColor=RedColor;
    [btbet setTitle:@"下注" forState:0];
    btbet.tag=104;
    btbet.layer.borderWidth = 0.5;
    btbet.layer.borderColor = SepearGrayLineColor.CGColor;
    [btbet addTarget:self action:@selector(footviewclick:) forControlEvents:UIControlEventTouchUpInside];
    btbet.titleLabel.font=[UIFont systemFontOfSize:BigFont];
    [btbet setTitleColor:[UIColor whiteColor] forState:0];
    [self addSubview:btbet];
   
//    if ( [[MyConfig currentConfig].show  isEqualToString:@"1"]) {
//        btbet.hidden=YES;
//        btempty.frame=CGRectMake(0, 0, (MSW)/3, 49);
//        btmovements.frame=CGRectMake(btempty.right, 0, (MSW)/3, 49);
//        btranking.frame=CGRectMake(btmovements.right, 0, (MSW)/3, 49);
//        
//    }else{
//        btbet.hidden=NO;
//        btempty.frame=CGRectMake(0, 0, (MSW-120)/3, 49);
//        btmovements.frame=CGRectMake(btempty.right, 0, (MSW-120)/3, 49);
//        btranking.frame=CGRectMake(btmovements.right, 0, (MSW-120)/3, 49);
//    }
//    

}


-(void)footviewclick:(UIButton*)sender{
    int  index=(int)sender.tag;
//    [MusicHelper showclickmusic];
    [self.delegate clickwithbuttontag:index];
}
@end
