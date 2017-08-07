//
//  TestViewController.m
//  longzhicai
//
//  Created by bxs on 2017/6/16.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import "TestViewController.h"
#import "TestModel.h"

@interface TestViewController ()
{
    NSMutableArray        *_dataArray;
    NSDictionary          *_oneDic;
    
    
}
@property (nonatomic, strong) UIScrollView          *scrollview;            //主滑动视图



@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:@"常见问题" font:17.0];
    
    // Do any additional setup after loading the view.
    _dataArray = [NSMutableArray new];
    [self.view addSubview:self.scrollview];
    
//    [self getRequestData];
    
    [self setViewLayoutWithArray];
    

}

- (void)getRequestData {
    
    [[HttpManager manager] requestPostURL:HTTP_Test_List withParams:nil withTarget:self withHud:YES withSuccessBlock:^(id responseObject) {
        DLog(@"测试-----= %@", responseObject)
        _dataArray = responseObject;
        _oneDic = responseObject[0];
        
    } withFailureBlock:^(NSError *error) {
        
        DLog(@"测试-----= %@", error)

        
        
    }];
    
}

-(void)setViewLayoutWithArray{
    
    [_scrollview removeAllSubviews];
    
    _dataArray = [NSMutableArray arrayWithObjects:@{@"常见问题解答：":@"在不懂的彩种规则下，点击右上角“规则”查看！！"},
                                                  @{@"2、彩种规则":@"购买记录可在我的界面购买记录中查看！"},
                                                  @{@"2、彩种规则":@"为响应国家政策，该彩票只支持模拟购买，并没有真正购买（注意）！"},
                                                  @{@"2、彩种规则":@"可以在彩票中通过积分购买彩票，模拟现实购买彩票流程！"},
                                                  @{@"2、彩种规则":@"积分可以通过每日签到获得，或关注app内轮播图活动内容！"},
                                                        nil];
    _oneDic = _dataArray[0];

    //取出第一个字典里面的所有key值，作为第一行标题
    NSArray *allKeys = _oneDic.allKeys;
    
    CGFloat W = (MSW - 20) / allKeys.count * 2;
    CGFloat H = IPhone4_5_6_6P(20, 20, 23, 23) * 2;
    
    //将每个字典中的values取出来添加到数组中
    NSMutableArray *allValuesArray = [NSMutableArray new];
    
    [_dataArray enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
        [allValuesArray addObject:[dic allValues]];
    }];
    
    for (int i = 0; i <= allValuesArray.count; i++) {
        for (int j = 0; j < allKeys.count; j++) {
            UILabel*lable = [[UILabel alloc]initWithFrame:CGRectMake((W)*j,i* H, W+1, H)];
            if (lable.top == 0) {
                lable.text = [allKeys objectAtIndex:j];
            } else {
                NSArray *arr = allValuesArray[i - 1];
                lable.text = [NSString stringWithFormat:@"%@", [arr objectAtIndex:j]];
            }
            lable.textAlignment = NSTextAlignmentLeft;
            lable.font=[UIFont systemFontOfSize:MiddleFont];
            [_scrollview addSubview:lable];
        }
    }
    
//    _scrollview.contentSize = CGSizeMake((W + 1) * allKeys.count, H * (allValuesArray.count + 1));

}


//主滑动视图
-(UIScrollView*)scrollview{
    if (!_scrollview) {
        _scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(10,10,MSW, MSH)];
        _scrollview.backgroundColor=[UIColor clearColor];
        _scrollview.showsHorizontalScrollIndicator=NO;
        _scrollview.showsVerticalScrollIndicator=NO;
        _scrollview.delegate=self;
        _scrollview.contentSize = CGSizeMake(MSW, MSH+40);
        
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
