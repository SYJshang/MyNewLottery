//
//  SYJForumDetailCell.h
//  SYJLottery
//
//  Created by 尚勇杰 on 2017/7/24.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYJForumModle.h"

@interface SYJForumDetailCell : UITableViewCell

@property (nonatomic, strong) UIImageView *pic;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, strong) UIView *lineBottom;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIButton *commentBtn;
@property (nonatomic, strong) UIButton *favoriteBtn;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UIView *line3;

@property (nonatomic, strong) SYJForumModle *model;



@end
