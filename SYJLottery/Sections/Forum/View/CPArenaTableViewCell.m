//
//  CPArenaTableViewCell.m
//  彩票2
//
//  Created by 张涛 on 2017/4/15.
//  Copyright © 2017年 1. All rights reserved.
//

#import "CPArenaTableViewCell.h"

@interface CPArenaTableViewCell()



@end

@implementation CPArenaTableViewCell


+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *cellID = @"CPArenaTableViewCell";
    CPArenaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[CPArenaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *contentView = self.contentView;

        UIImageView *pic = [[UIImageView alloc] init];
        pic.contentMode = UIViewContentModeScaleToFill;
        self.pic = pic;
        [contentView addSubview:pic];
        self.pic.sd_layout.leftSpaceToView(self.contentView, 10).topSpaceToView(self.contentView, 5).heightIs(60).widthIs(60);
        self.pic.image = [UIImage imageNamed:@"头像"];
        self.pic.layer.masksToBounds = YES;
        self.pic.layer.cornerRadius = 30;
        self.pic.layer.borderColor = Gray.CGColor;
        self.pic.layer.borderWidth = 0.5;

        
        UILabel *title = [[UILabel alloc] init];
//        title.text = @"中奖啦中奖啦！！！！";
        title.textAlignment = NSTextAlignmentLeft;
        title.textColor = [UIColor blackColor];
        title.font = [UIFont systemFontOfSize:16];
        [contentView addSubview:title];
        self.title = title;
        self.title.sd_layout.leftSpaceToView(self.pic, 5).topSpaceToView(self.contentView, 8).heightIs(20).widthIs(100);
        
        UILabel *dateLabel = [[UILabel alloc] init];
        dateLabel.textColor = Color(160, 160, 160, 1);
        dateLabel.textAlignment = NSTextAlignmentRight;
        dateLabel.font = [UIFont systemFontOfSize:13];
        dateLabel.text = @"2016年8月13日";
        [contentView addSubview:dateLabel];
        self.dateLabel = dateLabel;
        self.dateLabel.sd_layout.rightSpaceToView(self.contentView, 5).leftSpaceToView(self.title, 5).heightIs(20).centerYEqualToView(self.title);
        
        self.titleLab = [[UILabel alloc]init];
        self.titleLab.textColor = [UIColor grayColor];
        self.titleLab.font = [UIFont systemFontOfSize:14.0];
        [contentView addSubview:self.titleLab];
        self.titleLab.sd_layout.leftSpaceToView(self.pic, 5).topSpaceToView(self.title, 5).heightIs(15).rightSpaceToView(self.contentView, 5);
        
        UILabel *contentLab = [[UILabel alloc]init];
        contentLab.textColor = [UIColor lightGrayColor];
        contentLab.font = [UIFont systemFontOfSize:13.0];
        contentLab.lineBreakMode = NSLineBreakByTruncatingTail;
        contentLab.numberOfLines = 2;
        [contentView addSubview:contentLab];
        self.contentLab = contentLab;
        self.contentLab.sd_layout.leftSpaceToView(self.pic, 5).topSpaceToView(self.titleLab, 3).heightIs(40).rightSpaceToView(self.contentView, 5);
        
        UIView *lineBottom = [[UIView alloc] init];
        lineBottom.backgroundColor = Gray;//Color(200, 199, 204, 1);
        [contentView addSubview:lineBottom];
        self.lineBottom = lineBottom;
        self.lineBottom.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.contentLab, 5).heightIs(1).rightSpaceToView(self.contentView, 20);
        
        UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [commentBtn setImage:[UIImage imageNamed:@"评论"] forState:UIControlStateNormal];
        [commentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        commentBtn.titleLabel.font = fontSize(scaleWithSize(15));
        [self.contentView addSubview:commentBtn];
        self.commentBtn = commentBtn;
        self.commentBtn.sd_layout.leftSpaceToView(self.contentView, 60).topSpaceToView(self.lineBottom,5).heightIs(20).widthIs(40);
        
        UIButton *favoriteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [favoriteBtn setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
        [favoriteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        favoriteBtn.titleLabel.font = fontSize(scaleWithSize(14));
        [self.contentView addSubview:favoriteBtn];
        self.favoriteBtn = favoriteBtn;
        self.favoriteBtn.sd_layout.rightSpaceToView(self.contentView, 60).topSpaceToView(self.lineBottom,5).heightIs(20).widthIs(40);

        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = Gray;//Color(200, 199, 204, 1);
        [self.contentView addSubview:line];
        self.line = line;
        self.line.sd_layout.leftSpaceToView(self.contentView, 10).rightSpaceToView(self.contentView, 10).bottomSpaceToView(self.contentView, 1).heightIs(1);
        
        UIView *line2 = [[UIView alloc]init];
        line2.backgroundColor = Gray;//Color(200, 199, 204, 1);
        [self.contentView addSubview:line2];
        self.line2 = line2;
        self.line2.sd_layout.centerXEqualToView(self.contentView).topSpaceToView(self.lineBottom, 0).bottomSpaceToView(self.line, 0).widthIs(1);

        
//            [self layoutViewFrame];
    }
    
    return self;
}



- (void)setModel:(SYJForumModle *)model{
    
    _model = model;
    self.title.text = model.username;
    [self.pic sd_setImageWithURL:[NSURL URLWithString:model.imgPath] placeholderImage:[UIImage imageNamed:@"头像"]];
    self.dateLabel.text = model.createTime;
    self.titleLab.text = model.title;
    self.contentLab.text = model.content;
    [self.commentBtn setTitle:model.commentCount forState:UIControlStateNormal];
    if (model.isCollection == 0) {
        [self.favoriteBtn setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
    }else{
        [self.favoriteBtn setImage:[UIImage imageNamed:@"collect1"] forState:UIControlStateNormal];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
