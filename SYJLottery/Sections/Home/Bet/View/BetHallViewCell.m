//
//  BetHallViewCell.m
//  longzhicai
//
//  Created by lili on 2017/3/23.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import "BetHallViewCell.h"

@implementation BetHallViewCell
{
    UIView                *_bgView;
    UIImageView           *_imglottery;
    UILabel               *_lbtitle;
    UILabel               *_lbnper;
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(3, 0, screen_width-6, IPhone4_5_6_6P(80, 80, 90, 90))];
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.layer.cornerRadius = 4;

    [self.contentView addSubview:_bgView];
    _imglottery = [[UIImageView alloc] initWithFrame:CGRectMake(13, 10, IPhone4_5_6_6P(60, 60, 70, 70), IPhone4_5_6_6P(60, 60, 70, 70))];

    [_bgView addSubview:_imglottery];
    
    _lbtitle = [[UILabel alloc] initWithFrame:CGRectMake(_imglottery.right +20,IPhone4_5_6_6P(15, 15, 20, 20), screen_width - 130, 20)];
    _lbtitle.backgroundColor = [UIColor clearColor];
    _lbtitle.font = [UIFont mysystemFontOfSize:BigFont];
    _lbtitle.textColor = [UIColor blackColor];
    _lbtitle.text = @"天津时时彩";
    [_bgView addSubview:_lbtitle];

    _lbnper = [[UILabel alloc] initWithFrame:CGRectMake(_lbtitle.left, _lbtitle.bottom+10, screen_width - 130, 20)];
    _lbnper.backgroundColor = [UIColor clearColor];
    _lbnper.font = [UIFont systemFontOfSize:MiddleFont];
    _lbnper.textColor = [UIColor grayColor];
    _lbnper.text = @"第222222期";
    [_bgView addSubview:_lbnper];

    UIImageView *allRightImg = [[UIImageView alloc] initWithFrame:CGRectMake(screen_width - 30, (IPhone4_5_6_6P(76, 76, 86, 86) - 10)/2.0, 14,21)];
    allRightImg.image = [UIImage imageNamed:@"bet_right"];
//    allRightImg.contentMode = UIViewContentModeScaleAspectFill;
    [_bgView addSubview:allRightImg];


}
-(void)setModel:(LotteryModel *)Model{
    _Model=Model;
    _lbtitle.text = _Model.gameName;
    _lbnper.text = [NSString stringWithFormat:@"第%@期",_Model.latestSessionNo];
    [_imglottery sd_setImageWithURL:[NSURL URLWithString:_Model.img] placeholderImage:DefaultImage1];

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
