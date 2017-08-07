//
//  HttpManager.h
//  longzhicai
//
//  Created by 夏云飞 on 2017/2/14.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import "AFHTTPSessionManager.h"

/**
 *  网络请求成功
 */
typedef void(^SuccessResponse) (id responseObject);

/**
 *  网络请求失败
 */
typedef void(^FailureResponse) (NSError *error);

@interface HttpManager : AFHTTPSessionManager

+ (instancetype)manager;

/**
 *  网络等待框
 */
@property (nonatomic, strong) UIView        *networkHUDView;

/**
 *  Post 请求
 * 
 *  @param url         请求链接
 *  @param params      请求参数
 *  @param target      请求体
 *  @param hud         是否显示弹框
 *  @param success     成功回调
 *  @param failure     失败回调
 */

- (void)requestPostURL:(NSString *)url
            withParams:(NSDictionary *)params
            withTarget:(id)target
               withHud:(BOOL)hud
      withSuccessBlock:(SuccessResponse)success
      withFailureBlock:(FailureResponse)failure;


/**
 *  Get 请求
 *
 *  @param url         请求链接
 *  @param params      请求参数
 *  @param target      请求体
 *  @param hud         是否显示弹框
 *  @param success     成功回调
 *  @param failure     失败回调
 */

- (void)requestGetURL:(NSString *)url
           withParams:(NSDictionary *)params
           withTarget:(id)target
              withHud:(BOOL)hud
     withSuccessBlock:(SuccessResponse)success
     withFailureBlock:(FailureResponse)failure;

/**
 *  取消请求
 */
- (void)cancelRequest;

@end
