//
//  SYJNewsDetailCell.m
//  SYJLottery
//
//  Created by 尚勇杰 on 2017/7/25.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJNewsDetailCell.h"

@implementation SYJNewsDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.nameLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.nameLab];
        self.nameLab.font = [UIFont boldSystemFontOfSize:17.0];
        self.nameLab.textColor = [UIColor blackColor];
        self.nameLab.numberOfLines = 0;
        self.nameLab.textAlignment = NSTextAlignmentCenter;
        self.nameLab.sd_layout.leftSpaceToView(self.contentView,10).rightSpaceToView(self.contentView,10).topSpaceToView(self.contentView, 10).heightIs(30);
        
        self.newsTypeLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.newsTypeLab];
        self.newsTypeLab.font = [UIFont boldSystemFontOfSize:13.0];
        self.newsTypeLab.backgroundColor = TextColor;
        self.newsTypeLab.textColor = [UIColor whiteColor];
        self.newsTypeLab.textAlignment = NSTextAlignmentCenter;
        self.newsTypeLab.sd_layout.widthIs(70).leftSpaceToView(self.contentView,20).topSpaceToView(self.nameLab, 5).heightIs(15);
        
        self.readCountLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.readCountLab];
        self.readCountLab.font = [UIFont boldSystemFontOfSize:14.0];
        self.readCountLab.textColor = [UIColor lightGrayColor];
        self.readCountLab.textAlignment = NSTextAlignmentCenter;
        self.readCountLab.sd_layout.widthIs(80).leftSpaceToView(self.newsTypeLab, 20).topSpaceToView(self.nameLab, 5).heightIs(15);
        
        self.dateLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.dateLab];
        self.dateLab.font = [UIFont boldSystemFontOfSize:13.0];
        self.dateLab.textColor = [UIColor lightGrayColor];
        self.dateLab.textAlignment = NSTextAlignmentRight;
        self.dateLab.sd_layout.widthIs(150).rightSpaceToView(self.contentView, 10).topSpaceToView(self.nameLab, 5).heightIs(15);

        
        self.img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
        [self.contentView addSubview:self.img];
        self.img.contentMode = UIViewContentModeScaleAspectFill;
        self.img.sd_layout.leftSpaceToView(self.contentView, 5).rightSpaceToView(self.contentView, 5).topSpaceToView(self.dateLab, 8).heightIs(140);
        self.img.layer.masksToBounds = YES;
        self.img.layer.cornerRadius = 2;
        self.img.layer.borderWidth = 1.0;
        self.img.layer.borderColor = Gray.CGColor;
        
        self.contextLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.contextLab];
        self.contextLab.font = [UIFont boldSystemFontOfSize:14.0];
        self.contextLab.textColor = [UIColor lightGrayColor];
//        self.contextLab.textAlignment = NSTextAlignmentCenter;
        self.contextLab.sd_layout.leftSpaceToView(self.contentView, 10).rightSpaceToView(self.contentView, 10).topSpaceToView(self.img, 5).autoHeightRatio(0);
        
        [self setupAutoHeightWithBottomView:self.contextLab bottomMargin:5];

        
    }
    
    
    return self;
    
}

- (void)setModels:(SYJNewsModel *)models{
    
    _models = models;
    [self.img sd_setImageWithURL:[NSURL URLWithString:models.imageurl] placeholderImage:[UIImage imageNamed:@"dream"]];
    self.nameLab.text = models.title;
    self.dateLab.text = models.registertime;
    self.readCountLab.text = [NSString stringWithFormat:@"阅读数:%@",models.readCount];
    self.newsTypeLab.text = models.newsType;
    if (models.newsType == nil || models.newsType.length == 0) {
        return;
    }else{
        NSString *str = [self filterHTML:models.newsContent];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:str];;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:8];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];
        self.contextLab.attributedText = attributedString;
        
    }
    
    
    
}

-(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
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
