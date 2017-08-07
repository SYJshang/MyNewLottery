//
//  MyHeaderTwoView.m
//  Money
//
//  Created by mac03 on 2017/3/21.
//  Copyright © 2017年 wkw. All rights reserved.
//

#import "MyHeaderTwoView.h"

@implementation MyHeaderTwoView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        _img = [[UIImageView alloc]init];
        _img.frame =CGRectMake(10,self.frame.size.height/2-5, 10,10);
        _img.clipsToBounds = YES;
        _img.layer.cornerRadius = _img.width/2;
        _img.backgroundColor=[UIColor colorWithHex:@"#ffb716"];
        [self addSubview:_img];
        _titleLab = [[UILabel alloc]init];
        _titleLab.frame =CGRectMake(_img.right + 5,0, MSW - _img.width,self.frame.size.height);
        _titleLab.text = @"最新中奖";
        _titleLab.font=[UIFont systemFontOfSize:17];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.backgroundColor = [UIColor clearColor];
        [self addSubview:_titleLab];
        _titleLab.textColor=BlackTitleColor;
        UIView   *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-0.5, MSW, 0.5)];
        line.backgroundColor = BackGroundColor;
        [self addSubview:line];
        
        
    }
    return self;
}


@end
