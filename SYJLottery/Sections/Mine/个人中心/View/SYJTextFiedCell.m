//
//  SYJTextFiedCell.m
//  SYJLottery
//
//  Created by 尚勇杰 on 2017/7/21.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJTextFiedCell.h"

@implementation SYJTextFiedCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.nameLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.nameLab];
        self.nameLab.font = [UIFont systemFontOfSize:16];
        self.nameLab.textColor = [UIColor blackColor];
        self.nameLab.textAlignment = NSTextAlignmentLeft;
        self.nameLab.sd_layout.leftSpaceToView(self.contentView, 10).centerYEqualToView(self.contentView).heightIs(20).widthIs(100);
        
        self.textFiled = [[UITextField alloc]init];
        self.textFiled.placeholder = @"请输入密码";
        self.textFiled.borderStyle = UITextBorderStyleNone;
        [self.contentView addSubview:self.textFiled];
        self.textFiled.font = [UIFont systemFontOfSize:14];
        self.textFiled.textAlignment = NSTextAlignmentRight;
        self.textFiled.sd_layout.leftSpaceToView(self.nameLab, 20).rightSpaceToView(self.contentView, 20).centerYEqualToView(self.contentView).heightIs(20);
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
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
