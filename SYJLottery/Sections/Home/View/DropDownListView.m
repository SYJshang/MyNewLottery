//
//  DropDownListView.m
//  longzhicai
//
//  Created by lili on 2017/3/24.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import "DropDownListView.h"

@interface DropDownListView ()
<UITableViewDataSource,
UITableViewDelegate>

@property(nonatomic,strong)NSArray *arr;
@property(nonatomic,assign)CGFloat rowHeight;   // 行高
@property(nonatomic,strong)UIButton *button;    //从Controller传过来的控制器
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIImageView *arrow;
@property(nonatomic,assign)NSInteger index;    //记录选中行

@end


@implementation DropDownListView
-(id)initWithListDataSource:(NSArray *)array
                  rowHeight:(CGFloat)rowHeight
                       view:(UIView *)v
                   tophight:(CGFloat)tophight;
{
    self = [super initWithFrame:CGRectMake(0, tophight, MSW, MSH)];
    if (self)
    {
//        self.backgroundColor = [UIColor greenColor];
        self.arr = array;
        self.rowHeight = rowHeight;
        self.button = (UIButton *)v;
    }
    return self;
}
-(UIView *)bgView
{
    if (!_bgView)
    {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        UIButton*btblack = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
        btblack.backgroundColor = [UIColor clearColor];
        [_bgView addSubview:btblack];
        [btblack addTarget:self action:@selector(hiddenList) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgView;
}

-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MSW, 0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsMake(20,20, 20, 20);//设置tableview分割线的位置
         _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tableView;
}
-(NSArray *)arr
{
    if (!_arr)
    {
        _arr = [[NSArray alloc]init];
    }
    return _arr;
}
//选中标记图片暂时不需要设置为空
-(UIImageView *)arrow
{
    if (!_arrow)
    {
        _arrow = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width - 35, 10, 20, 20)];
        _arrow.image = [UIImage imageNamed:@""];
    }
    return _arrow;
}
/**
 *   显示下拉列表
 */
-(void)showList
{
    [self addSubview:self.bgView];
    [self addSubview:self.tableView];
    [self.tableView reloadData];
    [UIView animateWithDuration:0.5f animations:^{
        self.bgView.alpha = 1;
        if (self.arr.count<8) {
            self.tableView.frame = CGRectMake(0, 0, MSW, self.rowHeight * self.arr.count);
        }else{
        
            self.tableView.frame = CGRectMake(0, 0, MSW, MSH-300);
        }
        self.hidden=NO;
    }];
}
/**
 *  隐藏
 */
-(void)hiddenList
{
    [UIView animateWithDuration:0.5f animations:^{
        self.bgView.alpha = 0;
        self.tableView.frame = CGRectMake(0, 0, MSW, 0);
    } completion:^(BOOL finished) {
        self.hidden=YES;
        [_bgView removeFromSuperview];
    }];
}
#pragma mark - UITableViewDelegateAndUITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.arr[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;//文字居中
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    if (self.index == indexPath.row)
    //    {
    //        if ([cell.textLabel.text isEqualToString:self.button.titleLabel.text])
    //        {
    //            [cell addSubview:self.arrow];
    //        }
    //    }
    //    
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark ----------------UITableView  表的选中方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    [self hiddenList];
    self.index = indexPath.row;
    if ([self.delegate respondsToSelector:@selector(dropDownListParame:)])
    {
        [self.delegate dropDownListParame:self.arr[indexPath.row]];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.rowHeight;
}

@end
