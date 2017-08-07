//
//  FounctionCollectionCell.m
//  Money
//
//  Created by mac03 on 2017/3/16.
//  Copyright © 2017年 wkw. All rights reserved.
//

#import "FounctionCollectionCell.h"

@interface FounctionCollectionCell ()


@end

@implementation FounctionCollectionCell

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
    _menuImgV = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-15, 10, 30, 30)];
    [_menuImgV setContentMode:UIViewContentModeScaleAspectFill];
    _menuImgV.clipsToBounds = YES;
    [self addSubview:_menuImgV];
    
    _titlelab = [[UILabel alloc]initWithFrame:CGRectMake(0, _menuImgV.bottom+10, self.frame.size.width, 15)];
    _titlelab.textAlignment = NSTextAlignmentCenter;
    _titlelab.font = [UIFont systemFontOfSize:13.0];
    _titlelab.textColor = BlackTitleColor;
    _titlelab.backgroundColor = [UIColor clearColor];
    _titlelab.text=@"常见问题";
    [self addSubview:_titlelab];
    
    UIView   *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-0.5, MSW, 0.5)];
    line.backgroundColor = BackGroundColor;
    [self addSubview:line];
   
    _leftview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, self.frame.size.height)];
    _leftview.backgroundColor=[UIColor colorWithHex:@"#f1f1f1"];
    [self addSubview:_leftview];
    _rightview=[[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width-5, 0, 5, self.frame.size.height)];
    _rightview.backgroundColor=[UIColor colorWithHex:@"#f1f1f1"];
    [self addSubview:_rightview];
    _leftview.hidden=YES;
    _rightview.hidden=YES;
    
}


@end
