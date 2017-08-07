//
//  WebViewController.m
//  longzhicai
//
//  Created by lili on 2017/4/5.
//  Copyright © 2017年 xyf. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
#import <Foundation/Foundation.h>
//#import "AccountDetailsViewController.h"

@interface WebViewController ()<UIWebViewDelegate,WKScriptMessageHandler,WKUIDelegate,WKNavigationDelegate>
{
    WKWebView       *_webView;

}
@end

@implementation WebViewController
- (instancetype)init {
    self = [super init];
    if (self) {
        self.isNeedBackItem = YES;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self cleanCacheAndCookie];
    [self createView];
}
//-(void)backForePage{
//    if (_webView.canGoBack) {
//        [_webView goBack];
//    }else{
//        if ([_type isEqualToString:@"1"]) {
//            NSArray * ctrlArray = self.navigationController.viewControllers;
//            [self.navigationController popToViewController:[ctrlArray objectAtIndex:1] animated:YES];
//            
//        }else{
//                    [self.navigationController popViewControllerAnimated:YES];
//        }
//        
//    }
//
//}
- (void)createView{
    
    [SVProgressHUD showWithStatus:@"loading..."];
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = [WKUserContentController new];
    [configuration.userContentController addScriptMessageHandler:self name:@"starupClose"];//关闭webview
    [configuration.userContentController addScriptMessageHandler:self name:@"starupSucc"];//支付成功。

    
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    preferences.minimumFontSize = 10.0;
    configuration.preferences = preferences;

    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, MSW  , MSH-64) configuration:configuration];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    _webView.allowsBackForwardNavigationGestures=YES;//右滑返回
    [self.view addSubview:_webView];
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_urlstr]]];
    [_webView loadRequest:request];
    

    
    
//    NSString *doc = @"document.body.outerHTML";
//    [_webView evaluateJavaScript:doc
//                     completionHandler:^(id _Nullable htmlStr, NSError * _Nullable error) {
//                         if (error) {
//                             DLog(@"JSError:%@",error);
//                         }
//                         DLog(@"html:%@",doc);
//                     }] ;
    
}
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    //    self.loadCount ++;
}
// 内容返回时开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
    //    self.loadCount --;
}
//页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [SVProgressHUD dismiss];
    DLog(@"=-=-  加载完成");
}
//失败
- (void)webView:(WKWebView *)webView didFailNavigation: (null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    //    self.loadCount --;
    DLog(@"%@",error);
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    DLog(@"-=-=-=  加载失败");
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    decisionHandler(WKNavigationActionPolicyAllow);
    
    
}
#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    //    message.body  --  Allowed types are NSNumber, NSString, NSDate, NSArray,NSDictionary, and NSNull.
    DLog(@"--  %@   -",message);
        NSLog(@"name:%@\\\\n body:%@\\\\n frameInfo:%@\\\\n",message.name,message.body,message.frameInfo);
    if ([message.name isEqualToString:@"starupClose"]) {//关闭webview
//        AccountDetailsViewController * account = [[AccountDetailsViewController alloc] init];
//        account.type = @"1";
//        account.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:account animated:YES];
        

    }else if ([message.name isEqualToString:@"starupSucc"]) {// 支付成功。
//        AccountDetailsViewController * account = [[AccountDetailsViewController alloc] init];
//        account.type = @"1";
//        account.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:account animated:YES];
        


    }

}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    
    if ([keyPath isEqualToString:@"title"])
    {
        if (object == _webView) {
            self.title = _webView.title;
            
        }
    }
    
}
-(void)viewWillDisappear:(BOOL)animated{
        [_webView removeObserver:self forKeyPath:@"title"];
}


/**清除缓存和cookie*/
- (void)cleanCacheAndCookie{
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]){
        [storage deleteCookie:cookie];
    }
    //清除UIWebView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
