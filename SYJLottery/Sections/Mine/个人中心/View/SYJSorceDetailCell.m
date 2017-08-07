//
//  SYJSorceDetailCell.m
//  SYJLottery
//
//  Created by 尚勇杰 on 2017/7/20.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJSorceDetailCell.h"

@implementation SYJSorceDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.typeName = [[UILabel alloc]init];
        [self.contentView addSubview:self.typeName];
        self.typeName.font = [UIFont systemFontOfSize:15.0];
        self.typeName.textColor = [UIColor blackColor];
        self.typeName.textAlignment = NSTextAlignmentLeft;
        self.typeName.sd_layout.leftSpaceToView(self.contentView, 10).centerYEqualToView(self.contentView).heightIs(50).widthIs(150);
        
        self.scoreLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.scoreLab];
        self.scoreLab.font = [UIFont systemFontOfSize:17.0];
        self.scoreLab.textColor = TextColor;
        self.scoreLab.textAlignment = NSTextAlignmentCenter;
        self.scoreLab.sd_layout.centerXEqualToView(self.contentView).centerYEqualToView(self.contentView).heightIs(50).widthIs(50);
        
        self.timeLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.timeLab];
        self.timeLab.font = [UIFont systemFontOfSize:13.0];
        self.timeLab.textColor = [UIColor lightGrayColor];
        self.timeLab.textAlignment = NSTextAlignmentCenter;
        self.timeLab.sd_layout.leftSpaceToView(self.scoreLab, 10).centerYEqualToView(self.contentView).heightIs(50).rightSpaceToView(self.contentView, 10);
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.contentView.layer.masksToBounds = YES;
        self.contentView.layer.cornerRadius = 3;
        self.contentView.layer.borderColor = Gray.CGColor;
        self.contentView.layer.borderWidth = 1.0;
        
    }
    
    return self;
    
}

- (void)setModel:(SYJSorceDetailModel *)model{
    
    _model = model;
    self.typeName.text = model.typeName;
    self.timeLab.text = model.createTime;
    if (model.mark == 0) {
        self.scoreLab.text = [NSString stringWithFormat:@"+ %@",model.scoreDetail];
    }else{
        self.scoreLab.text = [NSString stringWithFormat:@"- %@",model.scoreDetail];
 
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
