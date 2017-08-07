//
//  LotteryRoomController.m
//  longzhicai
//
//  Created by lili on 2017/3/23.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import "LotteryRoomController.h"
#import "DropDownListView.h"
#import "BetDetailController.h"

#import "BJRacingPkController.h"
#import "GDHappyTenController.h"
#import "PCBallsController.h"
#import "CQTimeColorController.h"
#import "LuckTwentyEightController.h"
#import "ThreeColorController.h"
#import "GDPickController.h"
#import "JSThreeController.h"
#import "GXHappyTenController.h"
#import "SixLotteryController.h"

@interface LotteryRoomController ()<DropDownViewDelegate>
{
    UIView      *_TopView;
    UILabel     *_lbroomname;
    UILabel     *_lbwater;
}
@property (nonatomic, strong) DropDownListView *list;
@property (nonatomic, strong) NSArray    *array;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIScrollView          *scrollview;            //主滑动视图
@property (nonatomic, strong) NSMutableArray    *titlearray;

@end

@implementation LotteryRoomController
- (instancetype)init {
    self = [super init];
    if (self) {
        self.isNeedBackItem = YES;
        self.titlearray=[NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = [NSArray arrayWithObjects:@"三分彩",@"北京赛车PK10",@"幸运28",@"重庆时时彩",@"PC蛋蛋",@"广东快乐十分",nil];
    
    [self.view addSubview:self.scrollview];
    UIButton*testbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    testbutton.frame = CGRectMake(0, 0,MSW,MSW*162/710);
    [testbutton addTarget:self action:@selector(intobetdetail) forControlEvents:UIControlEventTouchUpInside];
    [testbutton setTitleColor:BlackTitleColor forState:0];
    testbutton.titleLabel.font=[UIFont mysystemFontOfSize:18.0f];
    [testbutton setBackgroundImage:[UIImage imageNamed:@"home_bet_bj.png"] forState:UIControlStateNormal];
    [self.scrollview addSubview:testbutton];
    
    [self.view addSubview:self.list];
    [self addTopView];
    [self dropDownListParame:[self.array objectAtIndex:[_lotterytype intValue]]];
    
    _lbroomname=[[UILabel alloc]initWithFrame:CGRectMake(MSW/2, 20, 80, 30)];
    _lbroomname.text=@" ";
    _lbroomname.textColor=[UIColor whiteColor];
    _lbroomname.font=[UIFont systemFontOfSize:18];
    [testbutton addSubview:_lbroomname];
    
    _lbwater=[[UILabel alloc]initWithFrame:CGRectMake(MSW/2, _lbroomname.bottom, 80, 15)];
    _lbwater.text=@"无返水";
    _lbwater.textColor=[UIColor whiteColor];
    _lbwater.font=[UIFont systemFontOfSize:MiddleFont];
    [testbutton addSubview:_lbwater];
}

-(void)intobetdetail{
    DLog(@"-=-- 进入下注详情");
    
    if ([_lotterytype isEqualToString:@"0"]) {//0=三份彩
        
        ThreeColorController *setVC = [[ThreeColorController alloc] init];
        [self.navigationController pushViewController:setVC animated:YES];
    }else if ([_lotterytype isEqualToString:@"1"]){//1=北京赛车
        BJRacingPkController *setVC = [[BJRacingPkController alloc] init];
        [self.navigationController pushViewController:setVC animated:YES];

    }else if ([_lotterytype isEqualToString:@"2"]){//2=幸运28
        
        LuckTwentyEightController *setVC = [[LuckTwentyEightController alloc] init];
        [self.navigationController pushViewController:setVC animated:YES];
    }else if ([_lotterytype isEqualToString:@"3"]){//3=重庆时时彩
        
        CQTimeColorController *setVC = [[CQTimeColorController alloc] init];
        [self.navigationController pushViewController:setVC animated:YES];
    
    }else if ([_lotterytype isEqualToString:@"4"]){//4=PC蛋蛋
        
        PCBallsController *setVC = [[PCBallsController alloc] init];
        [self.navigationController pushViewController:setVC animated:YES];
    }else{//广东快乐10分
        
        GDHappyTenController *setVC = [[GDHappyTenController alloc] init];
        [self.navigationController pushViewController:setVC animated:YES];
    }
    

}

-(UIButton *)button
{
    if (!_button)
    {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(0, 0,200, 40);
        [_button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_button setTitleColor:BlackTitleColor forState:0];
        _button.titleLabel.font=[UIFont mysystemFontOfSize:18.0f];
        _button.backgroundColor=[UIColor clearColor];
        [_button setImage:[UIImage imageNamed:@"bet_pulldown"] forState:UIControlStateNormal];
        _button.adjustsImageWhenHighlighted=NO;
    }
    return _button;
}

-(void)buttonClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected == YES)
    {
        _list.hidden=NO;
        [_list showList];
    }else
    {
        [_list hiddenList];
    }
}
-(DropDownListView *)list
{
    if (!_list)
    {
        _list = [[DropDownListView alloc]initWithListDataSource:self.array rowHeight:44 view:_button tophight:0];
        _list.delegate = self;
        _list.hidden=YES;
    }
    return _list;
}

#pragma mark - 头部视图
//自定义导航栏按钮
- (void)addTopView {
    
    if (_TopView == nil) {
        _TopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    }
    _TopView.backgroundColor=[UIColor clearColor];
    self.navigationItem.titleView = _TopView;
    [_TopView addSubview:[self button]];
}
//改变文字图片的位置
-(void)dropDownListParame:(NSString *)aStr
{
    DLog(@"-=-=-    %@",aStr);
    [_button setTitle:aStr forState:UIControlStateNormal];
    
 _lotterytype= [NSString stringWithFormat:@"%li",[self.array indexOfObject:aStr]];
    //    交换文字与图片的位置
    CGFloat imageWidth = _button.imageView.bounds.size.width;
    CGFloat labelWidth = _button.titleLabel.bounds.size.width;
    _button.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);
    _button.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
    

}
//主滑动视图
-(UIScrollView*)scrollview{
    if (!_scrollview) {
        _scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0, MSW, MSH)];
        _scrollview.backgroundColor=[UIColor clearColor];
        _scrollview.showsHorizontalScrollIndicator=NO;
        _scrollview.showsVerticalScrollIndicator=NO;
        _scrollview.delegate=self;
        _scrollview.contentSize = CGSizeMake(MSW, MSH+1);
        
    }
    return _scrollview;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
