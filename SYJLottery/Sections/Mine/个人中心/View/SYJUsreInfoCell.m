//
//  SYJUsreInfoCell.m
//  SYJLottery
//
//  Created by 尚勇杰 on 2017/7/21.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJUsreInfoCell.h"

@implementation SYJUsreInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.nameLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.nameLab];
        self.nameLab.font = [UIFont systemFontOfSize:16.0];
        self.nameLab.textColor = [UIColor blackColor];
        self.nameLab.textAlignment = NSTextAlignmentLeft;
        self.nameLab.sd_layout.leftSpaceToView(self.contentView, 10).centerYEqualToView(self.contentView).heightIs(50).widthIs(120);
        
        self.descLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.descLab];
        self.descLab.font = [UIFont systemFontOfSize:16.0];
        self.descLab.textColor = [UIColor blackColor];
        self.descLab.textAlignment = NSTextAlignmentRight;
        self.descLab.sd_layout.leftSpaceToView(self.nameLab, 10).centerYEqualToView(self.contentView).heightIs(50).rightSpaceToView(self.contentView, 10);
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *line = [[UIView alloc]init];
        [self.contentView addSubview:line];
        line.sd_layout.leftSpaceToView(self.contentView, 10).rightSpaceToView(self.contentView, 10).bottomSpaceToView(self.contentView, 1).heightIs(1);
        
    }
    
    return self;
    
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
