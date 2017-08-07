//
//  OptionalView.m
//  longzhicai
//
//  Created by lili on 2017/3/30.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import "OptionalView.h"

@implementation OptionalView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
-(void)initUI
{
    
    _lbtitle = [[UILabel alloc] initWithFrame:CGRectMake(5,5,MSW/4-10, 15)];
//    _lbtitle.textColor =BlackDescColor;
    _lbtitle.text=@"大";
//    _lbtitle.font = [UIFont mysystemFontOfSize:11];
    _lbtitle.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lbtitle];

    
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, 40)];
    view.backgroundColor=RGBCOLOR(232, 232, 232);
    UIButton*bt=[[UIButton alloc]initWithFrame:CGRectMake(MSW-70, 0, 70, 40)];
    [bt setTitle:@"完成" forState:UIControlStateNormal];
    bt.titleLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:17];
    [bt setTitleColor:BlackTitleColor forState:0];
    [bt addTarget:self action:@selector(handleSingleTapFrom) forControlEvents:UIControlEventTouchDown ];
    [view addSubview:bt];
    _tfnumber=[[UITextField alloc]initWithFrame:CGRectMake(10,_lbtitle.bottom+5,MSW/4-20, 25)];
    _tfnumber.textAlignment=NSTextAlignmentCenter;
    _tfnumber.layer.borderWidth = 1;
//    _tfnumber.delegate=self;
    _tfnumber.textColor=[UIColor grayColor];
    _tfnumber.layer.cornerRadius = 1;
    _tfnumber.layer.masksToBounds = YES;
    _tfnumber.inputAccessoryView=view;
    _tfnumber.delegate=self;
    [_tfnumber addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _tfnumber.font=[UIFont mysystemFontOfSize:SmallFont];
    _tfnumber.keyboardType=UIKeyboardTypeNumberPad;
    _tfnumber.layer.borderColor =[UIColor groupTableViewBackgroundColor].CGColor;
    [self addSubview:_tfnumber];
    
}
-(void)handleSingleTapFrom{
    [_tfnumber resignFirstResponder];
}



-(void)setIsRotaryheader:(int)isRotaryheader{
    _isRotaryheader=isRotaryheader;
}

-(void)setModel:(BetModel *)Model{
    _Model=Model;
    if (_isRotaryheader==0) {
        _tfnumber.enabled=YES;
        _tfnumber.textColor=BlackTitleColor;
        _tfnumber.font=[UIFont mysystemFontOfSize:MiddleFont];
    }else{
    
    _tfnumber.enabled=NO;
    _tfnumber.text=@"封盘";
    _tfnumber.font=[UIFont mysystemFontOfSize:SmallFont];
    _tfnumber.textColor=RedColor;
    }
    NSDictionary* style = @{@"body" :
                                @[[UIFont systemFontOfSize:IPhone4_5_6_6P(11, 11, 12, 13)],
                                  BlackTitleColor],
                            @"u": @[[UIFont systemFontOfSize:IPhone4_5_6_6P(11, 11, 12, 13)],RedColor,
                                    
                                    ]};
    _lbtitle.attributedText = [[NSString stringWithFormat:@"%@<u>%@</u>",_Model.title,_Model.rate] attributedStringWithStyleBook:style];


}
-(void)textFieldDidEndEditing:(UITextField *)textField{

        BetModel*model=[[BetModel alloc]init];
        model=_Model;
        model.count=textField.text;
        [self.delegate seletebetmodelwithmodel:model];
}
- (void) textFieldDidChange:(UITextField *)sender {        
    if ([_tfnumber.text intValue]>10000) {
        _tfnumber.text=@"10000";
    }else if ([_tfnumber.text isEqualToString:@"0"]){
        _tfnumber.text=@"1";
    }

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    DLog(@"-=-=-------%@",_tfnumber.text);
    if (textField == _tfnumber) {
        if (string.length == 0)return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 5) {
            return NO;
        }
    }
    return YES;
}

@end
