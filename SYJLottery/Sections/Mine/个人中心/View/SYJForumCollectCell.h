//
//  SYJForumCollectCell.h
//  SYJLottery
//
//  Created by 尚勇杰 on 2017/7/25.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SYJForumCollectModel.h"

@interface SYJForumCollectCell : UITableViewCell

@property (nonatomic, strong) UIImageView *pic;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, strong) UIView *lineBottom;
//@property (nonatomic, weak) UIButton *commentButton;
//@property (nonatomic, weak) UIButton *praiseButton;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIButton *commentBtn;
@property (nonatomic, strong) UIButton *favoriteBtn;
@property (nonatomic, assign) BOOL isFavorite;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UIView *line3;

@property (nonatomic, strong) SYJForumCollectModel *model;

@end
