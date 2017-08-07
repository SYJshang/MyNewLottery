
//
//  SYJCollectionCell.m
//  SYJLottery
//
//  Created by 尚勇杰 on 2017/7/21.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJCollectionCell.h"

@implementation SYJCollectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.titleLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.titleLab];
        self.titleLab.font = [UIFont systemFontOfSize:14];
        self.titleLab.textColor = [UIColor blackColor];
        self.titleLab.textAlignment = NSTextAlignmentLeft;
        self.titleLab.sd_layout.leftSpaceToView(self.contentView, 16).topSpaceToView(self.contentView, 10).heightIs(20).widthIs(160);
        
        
        self.rateLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.rateLab];
        self.rateLab.font = [UIFont systemFontOfSize:14];
        self.rateLab.textColor = TextColor;
        self.rateLab.textAlignment = NSTextAlignmentRight;
        self.rateLab.sd_layout.rightSpaceToView(self.contentView, 16).topSpaceToView(self.contentView, 10).heightIs(20).widthIs(160);
        
        
        self.bettitleLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.bettitleLab];
        self.bettitleLab.font = [UIFont systemFontOfSize:14];
        self.bettitleLab.textColor = [UIColor lightGrayColor];
        self.bettitleLab.textAlignment = NSTextAlignmentLeft;
        self.bettitleLab.sd_layout.leftSpaceToView(self.contentView, 16).bottomSpaceToView(self.contentView, 10).heightIs(20).widthIs(160);
        
        self.countLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.countLab];
        self.countLab.font = [UIFont systemFontOfSize:14];
        self.countLab.textColor = TextColor;
        self.countLab.textAlignment = NSTextAlignmentRight;
        self.countLab.sd_layout.rightSpaceToView(self.contentView, 16).bottomSpaceToView(self.contentView, 10).heightIs(20).widthIs(160);
        
        
        UIView *line = [[UIView alloc]init];
        [self.contentView addSubview:line];
        line.backgroundColor = Gray;
        line.sd_layout.leftSpaceToView(self.contentView, 10).rightSpaceToView(self.contentView, 10).bottomSpaceToView(self.contentView, 1).heightIs(1);
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
    }
    
    return self;
    

}


- (void)setModel:(BetModel *)model{
    
    _model = model;
    self.titleLab.text = [NSString stringWithFormat:@"投注名称:%@",model.title];
    self.rateLab.text = [NSString stringWithFormat:@"%@",model.rate];
    self.bettitleLab.text = [NSString stringWithFormat:@"下注:%@",model.rate];
    self.countLab.text = [NSString stringWithFormat:@"共 %@ 注",model.count];

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
