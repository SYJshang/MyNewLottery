//
//  SYJNewsCell.m
//  SYJLottery
//
//  Created by 尚勇杰 on 2017/7/25.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJNewsCell.h"

@implementation SYJNewsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
        [self.contentView addSubview:self.img];
        self.img.contentMode = UIViewContentModeScaleAspectFill;
        self.img.sd_layout.leftSpaceToView(self.contentView, 5).rightSpaceToView(self.contentView, 5).topSpaceToView(self.contentView, 5).bottomSpaceToView(self.contentView, 5);
        self.img.layer.masksToBounds = YES;
        self.img.layer.cornerRadius = 2;
        self.img.layer.borderWidth = 1.0;
        self.img.layer.borderColor = Gray.CGColor;
        
        self.nameLab = [[UILabel alloc]init];
        [self.img addSubview:self.nameLab];
        self.nameLab.font = [UIFont boldSystemFontOfSize:17.0];
        self.nameLab.textColor = [UIColor whiteColor];
        self.nameLab.textAlignment = NSTextAlignmentCenter;
        self.nameLab.sd_layout.centerXEqualToView(self.img).centerYEqualToView(self.img).widthIs(320).heightIs(20);
        
        
        
        
        self.newsTypeLab = [[UILabel alloc]init];
        [self.img addSubview:self.newsTypeLab];
        self.newsTypeLab.font = [UIFont boldSystemFontOfSize:12.0];
        self.newsTypeLab.backgroundColor = TextColor;
        self.newsTypeLab.textColor = [UIColor whiteColor];
        self.newsTypeLab.textAlignment = NSTextAlignmentCenter;
        self.newsTypeLab.sd_layout.widthIs(55).leftSpaceToView(self.img,0).topSpaceToView(self.img, 0).heightIs(20);
        
        self.readCountLab = [[UILabel alloc]init];
        [self.img addSubview:self.readCountLab];
        self.readCountLab.font = [UIFont boldSystemFontOfSize:14.0];
        self.readCountLab.textColor = [UIColor whiteColor];
        self.readCountLab.textAlignment = NSTextAlignmentCenter;
        self.readCountLab.sd_layout.widthIs(80).leftSpaceToView(self.img, 20).bottomSpaceToView(self.img, 10).heightIs(15);
        
        self.dateLab = [[UILabel alloc]init];
        [self.img addSubview:self.dateLab];
        self.dateLab.font = [UIFont boldSystemFontOfSize:13.0];
        self.dateLab.textColor = [UIColor whiteColor];
        self.dateLab.textAlignment = NSTextAlignmentRight;
        self.dateLab.sd_layout.widthIs(150).rightSpaceToView(self.img, 10).bottomSpaceToView(self.img, 10).heightIs(15);
        
    }
    
    
    return self;
    
}

- (void)setModel:(SYJNewsModel *)model{
    
    _model = model;
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.imageurl] placeholderImage:[UIImage imageNamed:@"dream"]];
    self.nameLab.text = model.title;
    self.dateLab.text = model.registertime;
    self.readCountLab.text = [NSString stringWithFormat:@"阅读数:%@",model.readCount];
    self.newsTypeLab.text = model.newsType;
    
    
    
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
