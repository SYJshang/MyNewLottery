//
//  SYJCommentCell.m
//  SYJLottery
//
//  Created by 尚勇杰 on 2017/7/24.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJCommentCell.h"

@implementation SYJCommentCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        self.pic = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"头像"]];
        [self.contentView addSubview:self.pic];
        self.pic.sd_layout.leftSpaceToView(self.contentView, 10).topSpaceToView(self.contentView, 5).heightIs(46).widthIs(46);
        self.pic.sd_cornerRadius = @23;
        
        self.title = [[UILabel alloc]init];
        [self.contentView addSubview:self.title];
        self.title.font = [UIFont systemFontOfSize:16];
        self.title.textColor = [UIColor blackColor];
        self.title.sd_layout.leftSpaceToView(self.pic, 5).topSpaceToView(self.contentView, 10).heightIs(20).rightSpaceToView(self.contentView, 10);
        
        self.dateLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.dateLab];
        self.dateLab.font = [UIFont systemFontOfSize:14];
        self.dateLab.textColor = [UIColor lightGrayColor];
        self.dateLab.sd_layout.leftSpaceToView(self.pic, 5).bottomEqualToView(self.pic).heightIs(20).rightSpaceToView(self.contentView, 10);
        
        self.contentLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.contentLab];
        self.contentLab.font = [UIFont systemFontOfSize:14];
        self.contentLab.numberOfLines = 0;
        self.contentLab.textColor = [UIColor lightGrayColor];
        self.contentLab.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(self.pic, 5).rightSpaceToView(self.contentView, 15).autoHeightRatio(0);
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = Gray;
        [self.contentView addSubview:line];
        line.sd_layout.leftSpaceToView(self.contentView, 5).rightSpaceToView(self.contentView, 5).topSpaceToView(self.contentLab, 6).heightIs(1);
        [self setupAutoHeightWithBottomView:line bottomMargin:0];
        
//        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentLab attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
//        NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
//        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentLab attribute:NSLayoutAttributeTop multiplier:1.0 constant:50];
//        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentLab attribute:NSLayoutAttributeBottom multiplier:1.0 constant:6];
//        NSArray* edgeConstraints = @[topConstraint, bottomConstraint];
//        [self.contentView addConstraints:edgeConstraints];

    }
    
    return self;
}

- (void)setModel:(SYJCommentModel *)model{
    
    _model = model;
    self.title.text = model.username;
    [self.pic sd_setImageWithURL:[NSURL URLWithString:model.imgPath] placeholderImage:[UIImage imageNamed:@"头像"]];
    self.dateLab.text = model.createTime;
    NSString *str = [self base64DecodeString:model.content];
    self.contentLab.text = str;
}

- (NSString *)base64DecodeString:(NSString *)string

{
    
    //1.将base64编码后的字符串『解码』为二进制数据
    
    NSData *data = [[NSData alloc]initWithBase64EncodedString:string options:0];
    
    //2.把二进制数据转换为字符串返回
    
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
}

- (NSString *)base64EncodeString:(NSString *)string

{
    
    //1.先把字符串转换为二进制数据
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    
    
    //2.对二进制数据进行base64编码，返回编码后的字符串
    
    return [data base64EncodedStringWithOptions:0];
    
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
