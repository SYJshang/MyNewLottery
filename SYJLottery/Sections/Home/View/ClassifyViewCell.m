//
//  ClassifyViewCell.m
//  Money
//
//  Created by mac03 on 2017/3/17.
//  Copyright © 2017年 wkw. All rights reserved.
//

#import "ClassifyViewCell.h"

@implementation ClassifyViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    self.backgroundColor=[UIColor whiteColor];
    
    self.img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10,60, 60)];
    self.img.backgroundColor=[UIColor clearColor];
    [self addSubview:_img];
    
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(self.img.right + 10, 20, 100, 20)];
    self.title.textAlignment = NSTextAlignmentLeft;
    self.title.textColor = BlackTitleColor;
    self.title.font = [UIFont systemFontOfSize:IPhone4_5_6_6P(14, 14, 15, 15)];
    self.title.text=@"北京时时彩";
    [self addSubview:self.title];
    
    self.subtitle = [[UILabel alloc] initWithFrame:CGRectMake(self.img.right + 10, self.title.bottom+5, 100, 20)];
    self.subtitle.textAlignment = NSTextAlignmentLeft;
    self.subtitle.textColor =BlackDescColor;
    self.subtitle.font = [UIFont systemFontOfSize:13];
    self.subtitle.text=@"北京幸运28";
    [self addSubview:self.subtitle];
    
    UIView   *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-0.5, MSW, 0.5)];
    line.backgroundColor = BackGroundColor;
    [self addSubview:line];
    
}
-(void)setGameModel:(GameListModel *)gameModel{
    _gameModel=gameModel;
    [self.img sd_setImageWithURL:[NSURL URLWithString:_gameModel.img] placeholderImage:DefaultImage1];
    _title.text=_gameModel.title;
    _subtitle.text=_gameModel.subtitle;

}

@end
