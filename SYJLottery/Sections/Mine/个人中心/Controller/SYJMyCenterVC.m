//
//  SYJMyCenterVC.m
//  MoxiNBA
//
//  Created by 尚勇杰 on 2017/7/13.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJMyCenterVC.h"
#import "SYJLotteryCollectionCell.h"
#import "SYJPersonCell.h"
#import "SYJInfoVC.h"
#import "SYJLoginController.h"
#import "SYJSorceDetailController.h"
#import "SYJForgetController.h"
#import "SYJUserInfoController.h"
#import "SYJSettingController.h"
#import "SYJRealInfoController.h"
#import "LotteryController.h"
#import "SYJCollectController.h"
#import "SYJForumCollectController.h"


@interface SYJMyCenterVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *arrList;
@property (nonatomic, strong) NSArray *imgList;

@property (nonatomic, strong) NSDictionary *userInfo;

//@property (nonatomic, strong) CPUserInfoModel *model;


@end

@implementation SYJMyCenterVC

- (NSArray *)imgList{
    
    if (_imgList == nil) {
        _imgList = @[@"签到",@"信息1",@"密码1",@"账户",@"积分",@"收藏1",@"开奖结果",@"设置1",@"绑定"];
    }
    return _imgList;
}

- (NSArray *)arrList{
    
    if (_arrList == nil) {
        _arrList = @[@"签到",@"个人信息",@"更改密码",@"购彩信息",@"积分详情",@"我的收藏",@"开奖信息",@"设置",@"真实身份"];
    }
    
    return _arrList;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    
    self.userInfo = nil;
    [self.collectionView reloadData];
    if (dict[@"userId"]) {
        [self getHttpData];
        
    }

    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout * layout = [UICollectionViewFlowLayout new];
    layout.sectionInset = UIEdgeInsetsZero;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[SYJPersonCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[SYJLotteryCollectionCell class] forCellWithReuseIdentifier:@"cell1"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        if (dict[@"userId"]) {
            [self getHttpData];
  
        }

    }];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}



- (void)getHttpData{
    
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSDictionary *parame = @{@"userId":dict[@"userId"]};
    [SYJHttpHelper Post:@"https://www.h1055.com/user/getUserInfo.do" parameters:parame success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        SYJLog(@"%@",dict);
        if ([dict[@"errorcode"] isEqualToString:@"0"]) {
            [[NSUserDefaults standardUserDefaults] setObject:dict[@"result"] forKey:@"userInfo"];
            self.userInfo = dict[@"result"];
            SYJLog(@"%@",self.userInfo);
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"error"]];
        }
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView reloadData];
        
        
    } failure:^(NSError *error) {
        [self.collectionView.mj_header endRefreshing];
    }];
    
}


#pragma mark - Delegate && DataSouce

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        SYJPersonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        
        if (!self.userInfo[@"username"]) {
            cell.nameLab.text = @"未登录";

        }else{
            cell.nameLab.text = self.userInfo[@"username"];
        }
        [cell.imgHeader sd_setImageWithURL:[NSURL URLWithString:self.userInfo[@"imgPath"]] placeholderImage:[UIImage imageNamed:@"头像"]];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [cell.imgHeader addGestureRecognizer:gesture];
        cell.sorceBtn.text = @"当前积分:0";
        if (self.userInfo) {
            cell.dict = self.userInfo;
        }
        return cell;
    }else{
        SYJLotteryCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
        NSInteger issign = [self.userInfo[@"isSign"] integerValue];
        NSString *str = [NSString stringWithFormat:@"%ld",issign];
        if (indexPath.row == 0 && [str isEqualToString:@"1"]) {
            cell.img.image = [UIImage imageNamed:self.imgList[indexPath.row]];
            cell.lotteryName.text = @"已签到";
            cell.lotteryName.textColor = TextColor;
        }else{
            cell.lotteryName.text = self.arrList[indexPath.row];
            cell.img.image = [UIImage imageNamed:self.imgList[indexPath.row]];
            cell.lotteryName.textColor = [UIColor blackColor];

        }
        
        
        return cell;
    }
    
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    switch (section) {
        case 1:
            return 0.5;
    }
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    switch (section) {
        case 1:
            return 0.5;
    }
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    switch (section) {
        case 0: return UIEdgeInsetsMake(0, 0, 0, 0);
            //        case 1: return UIEdgeInsetsMake(6, 0, 12, 0);
        case 1: return UIEdgeInsetsMake(0, 0, 61, 0);
    }
    return UIEdgeInsetsZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:  return CGSizeMake(KSceenW, 200);
        case 1:{
            CGFloat w = (KSceenW - 1 )/ 3.;
            return  CGSizeMake(w, w);
        }
        default: return CGSizeZero;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 1:
            return CGSizeMake(KSceenW, 30);
        default:
            return CGSizeZero;
    }
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        UICollectionReusableView * head = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        
        UILabel *title = [head viewWithTag:1000];
        if (!title) {
            title = [[UILabel alloc]initWithFrame:CGRectMake(13, 5, 200, 25)];
            title.tag = 1000;
            title.font = [UIFont boldSystemFontOfSize:15];
            title.text = @"个人信息";
            title.textColor = [UIColor colorWithWhite:0.2 alpha:1.0];
            
            [head addSubview:title];
        }
        return head;
    }else{
        return nil;
    }
}


#pragma mark -  data source
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
        case 1:
            return self.arrList.count;
        default:
            return 0;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1 && self.userInfo) {
        switch (indexPath.row) {
                case 0:
                [self gotoSign];
                break;
                case 1:
                {
                SYJUserInfoController *vc = [[SYJUserInfoController alloc]init];
                vc.userID = self.userInfo[@"userId"];
                [self.navigationController pushViewController:vc animated:YES];
                break;
                }
                
                case 2:
                {
                SYJForgetController *vc = [[SYJForgetController alloc]init];
                vc.isChangePwd = YES;
                [self.navigationController pushViewController:vc animated:YES];
                break;
                }
            case 3:{
                [self.navigationController pushViewController:[SYJCollectController new] animated:YES];
                break;

            }
//                [SVProgressHUD showInfoWithStatus:@"暂无中奖信息"];
                case 4:
            {
                SYJSorceDetailController *vc = [[SYJSorceDetailController alloc]init];
                vc.userID = self.userInfo[@"userId"];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
                case 5:
                [self.navigationController pushViewController:[SYJForumCollectController new] animated:YES];
                break;
                case 6:
                [self.navigationController pushViewController:[LotteryController new] animated:YES];
                break;
                case 7:
                [self.navigationController pushViewController:[SYJSettingController new] animated:YES];
                break;
                case 8:
                [self.navigationController pushViewController:[SYJRealInfoController new] animated:YES];
                break;
                
            default:
                break;
        }
    }else if(indexPath.section == 0){
        
    }else{
        [SVProgressHUD showInfoWithStatus:@"未登录！请先去登录！"];
    }
   
}

//签到
- (void)gotoSign{
    
    NSDictionary *parame = @{@"userId":self.userInfo[@"userId"]};
    [SYJHttpHelper Post:@"https://www.h1055.com/user/userSign.do" parameters:parame success:^(id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if ([dict[@"errorcode"] isEqualToString:@"0"]) {
            [SVProgressHUD showSuccessWithStatus:@"签到成功!"];
            [self getHttpData];
        }else{
            [SVProgressHUD showSuccessWithStatus:dict[@"error"]];

        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 点击头像
- (void)tap{
    if (self.userInfo[@"userId"]) {
       [self.navigationController pushViewController:[SYJSettingController new] animated:YES];
    }else{
        [self.navigationController pushViewController:[SYJLoginController new] animated:YES];
    }
    
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
