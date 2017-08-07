//
//  HttpManager.m
//  longzhicai
//
//  Created by 夏云飞 on 2017/2/14.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import "HttpManager.h"
#import "NetWork_HTTPRequestDefine.h"

static HttpManager  *_singleManager = nil;
@implementation HttpManager

+ (instancetype)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleManager = [[HttpManager alloc] init];
    });
    return _singleManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {

//        self.requestSerializer = [AFJSONRequestSerializer serializer];
//        self.requestSerializer.timeoutInterval = 30.0f;
      
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.requestSerializer.timeoutInterval = 30.0f;
        

        AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
//        serializer.removesKeysWithNullValues = YES;
        self.responseSerializer = serializer;
//        self.securityPolicy.allowInvalidCertificates = YES;
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    }
    return self;
}

/**
 *  Post 请求
 */

- (void)requestPostURL:(NSString *)url
            withParams:(NSDictionary *)params
            withTarget:(id)target
               withHud:(BOOL)hud
      withSuccessBlock:(SuccessResponse)success
      withFailureBlock:(FailureResponse)failure {
    [self showOrHiddenNetworkActivity:YES];
    [self showNetworkHUDshow:hud aTarget:target];
    if (!url) {
        url = @"";
    }
    NSString *totalURL = [NSString stringWithFormat:@"%@%@",SERVERURL,url];
    
    if (!params) {
        params = [[NSDictionary alloc] init];
        
    }
    
    NSString *paramsstr=[self keyValueStringWithDict:params];//参数字典转换成字符串
    NSString *DesStr= [Des encryptUseDES:paramsstr key:DESKEY];//先进行转码后进行加密
    NSString*DesUrl=[NSString stringWithFormat:@"%@?m=%@",totalURL,[Des encodeString:DesStr]];//参数加密后的整个URL
    [self POST:DesUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self showOrHiddenNetworkActivity:NO];
        [self hideNetworkHUDhide:hud aTarget:target];
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showOrHiddenNetworkActivity:NO];
        [self hideNetworkHUDhide:hud aTarget:target];
        failure(error);
    }];
}


/**
 *  Get 请求       由于对接口进行了加密处理需要把GET请求换成POST请求  所以在GET请求里直接换成了POST
 */

- (void)requestGetURL:(NSString *)url
           withParams:(NSDictionary *)params
           withTarget:(id)target
              withHud:(BOOL)hud
     withSuccessBlock:(SuccessResponse)success
     withFailureBlock:(FailureResponse)failure {
    [self showOrHiddenNetworkActivity:YES];
    [self showNetworkHUDshow:hud aTarget:target];
    if (!url) {
        url = @"";
    }
    NSString *totalURL = [NSString stringWithFormat:@"%@%@",SERVERURL,url];
    
    if (!params) {
        params = [[NSDictionary alloc] init];
    }
    NSString*paramsstr=[self keyValueStringWithDict:params];//参数字典转换成字符串
    NSString*DesStr= [Des encryptUseDES:paramsstr key:DESKEY];//先进行转码后进行加密
    NSString*DesUrl=[NSString stringWithFormat:@"%@?m=%@",totalURL,[Des encodeString:DesStr]];//参数加密后的整个URL
    
//        DLog(@"-=------数字典转换成字符串  %@  -=转码后-  %@  --------加密的参数字典url=  %@",paramsstr,DesStr,DesUrl);
//        GET请求
    //    [self GET:DesUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //        [self showOrHiddenNetworkActivity:NO];
    //        [self hideNetworkHUDhide:hud aTarget:target];
    //        success(responseObject);
    //    }
    
    //    POST请求
    [self POST:DesUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self showOrHiddenNetworkActivity:NO];
        [self hideNetworkHUDhide:hud aTarget:target];

        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showOrHiddenNetworkActivity:NO];
        [self hideNetworkHUDhide:hud aTarget:target];
        failure(error);
    }];
}

/**
 *  取消请求
 */
- (void)cancelRequest {
    if (self.operationQueue.operationCount) {
        [self.operationQueue cancelAllOperations];
    }
}

/**
 *  显示隐藏状态栏标识
 */
- (void)showOrHiddenNetworkActivity:(BOOL)show {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:show];
}

/**
 *  显示网络等待框
 */
- (void)showNetworkHUDshow:(BOOL)show aTarget:(id)target {

    if (!show || target == nil) {
        return;
    }
    
    if (![target isKindOfClass:[UIView class]] && ![target isKindOfClass:[UIViewController class]]) {
        return;
    }
    
    // 要显示HUD的View
    UIView *view = nil;
    if ([target isKindOfClass:[UIView class]]) {
        view = (UIView *)target;
    }else if ([target isKindOfClass:[UIViewController class]]) {
        view = (UIView *)(((UIViewController *)target).view);
    }
    
    // 创建HUD
    if (!_networkHUDView) {
        _networkHUDView = [[MBProgressHUD alloc] init];
        ((MBProgressHUD *)_networkHUDView).bezelView.backgroundColor = [UIColor blackColor];
        [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor whiteColor];
        [view addSubview:_networkHUDView];
        [(MBProgressHUD *)_networkHUDView showAnimated:YES];
    }else {
        [view addSubview:_networkHUDView];
        [(MBProgressHUD *)_networkHUDView showAnimated:YES];
    }
}

/**
 *  隐藏网络等待框
 */
- (void)hideNetworkHUDhide:(BOOL)hide aTarget:(id)target {
    
    if (!hide || target == nil) {
        return;
    }
    
    if (![target isKindOfClass:[UIView class]] && ![target isKindOfClass:[UIViewController class]]) {
        return;
    }
    
    // HUD不存在
    if (!_networkHUDView) {
        return;
    }
    
    if (![_networkHUDView isKindOfClass:[MBProgressHUD class]]) {
        [(MBProgressHUD *)_networkHUDView hideAnimated:YES];
    }
    
    // 移除
    if (_networkHUDView.superview) {
        [_networkHUDView removeFromSuperview];
    }
}
//／字典转换成URL
- (NSString *)keyValueStringWithDict:(NSDictionary *)dict
{
    if (dict == nil) {
        return nil;
    }
    //    NSMutableString *string = [NSMutableString stringWithString:@"?"];  //要不要加？
    
    NSMutableString *string = [NSMutableString stringWithString:@""];
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [string appendFormat:@"%@=%@&",key,[Des encodeString:obj]];
        }];
    
    if ([string rangeOfString:@"&"].length) {
        [string deleteCharactersInRange:NSMakeRange(string.length - 1, 1)];
    }
    
    return string;
}

-(NSDictionary *)dictionaryWithUrlString:(NSString *)urlStr
{
    if (urlStr && urlStr.length && [urlStr rangeOfString:@"?"].length == 1) {
        NSArray *array = [urlStr componentsSeparatedByString:@"?"];
        if (array && array.count == 2) {
            NSString *paramsStr = array[1];
            if (paramsStr.length) {
                NSMutableDictionary *paramsDict = [NSMutableDictionary dictionary];
                NSArray *paramArray = [paramsStr componentsSeparatedByString:@"&"];
                for (NSString *param in paramArray) {
                    if (param && param.length) {
                        NSArray *parArr = [param componentsSeparatedByString:@"="];
                        if (parArr.count == 2) {
                            [paramsDict setObject:parArr[1] forKey:parArr[0]];
                        }
                    }
                }
                return paramsDict;
            }else{
                return nil;
            }
        }else{
            return nil;
        }
    }else{
        return nil;
    }
}


@end
