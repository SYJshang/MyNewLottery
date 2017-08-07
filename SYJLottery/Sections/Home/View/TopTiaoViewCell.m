//
//  TopTiaoViewCell.m
//  Money
//
//  Created by mac03 on 2017/3/17.
//  Copyright © 2017年 wkw. All rights reserved.
//

#import "TopTiaoViewCell.h"

@implementation TopTiaoViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)createUI
{
    

}
-(void)setTitlearray:(NSArray *)titlearray{
//        DLog(@"-=-=----%@",titlearray);
    if (!self.walkhourseview&&titlearray.count>0) {
        self.walkhourseview=[[WalkHorseView alloc]initWithFrame:CGRectMake(0, 0, MSW, 125)];
        self.walkhourseview.backgroundColor=[UIColor whiteColor];
        self.walkhourseview.labelWidth=MSW-10;
        self.walkhourseview.labelHeight=25;
        self.walkhourseview.textColor=BlackDescColor;
        self.walkhourseview.textColor2=[UIColor colorWithHex:@"#ffb716"];
        self.walkhourseview.titleCount=5;
        self.walkhourseview.textFont=[UIFont systemFontOfSize:14];
        [self addSubview:self.walkhourseview];
    }
    self.walkhourseview.labelTitleArray=titlearray;
}


@end
