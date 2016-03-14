//
//  LMOauthViewController.m
//  weibo2016
//
//  Created by mac on 16/3/11.
//  Copyright © 2016年 songlm. All rights reserved.
//

#import "LMOauthViewController.h"
#import "LMTabBarController.h"
#import "LMNewfeatureViewController.h"

@interface LMOauthViewController ()<UIWebViewDelegate>

@end

@implementation LMOauthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *access_token = [defaults objectForKey:@"access_token"];
    if (access_token) {
        [self settingUpRootView];
    }else {
        [self addWebview];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//添加webview到self.view，提供微博账号登录页面
- (void)addWebview {
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.frame;
    [self.view addSubview:webView];
    //注意不要忘了设置webview的代理为self
    webView.delegate = self;
    NSString *appKey = @"2901639269";
    NSString *redirectURI = @"http://www.haifu.com.cn";
    NSString *kOauthURL = @"https://api.weibo.com/oauth2/authorize";
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",kOauthURL, appKey,redirectURI];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}


#pragma mark - webViewdelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *urlStr = request.URL.absoluteString;
    NSRange urlcodeRange = [urlStr rangeOfString:@"code="];
    if (urlcodeRange.length != 0) {
        NSString *code = [urlStr substringFromIndex:urlcodeRange.location + urlcodeRange.length];
        // 利用code换取一个accessToken
        [self accessTokenWithCode:code];
        
        //切换窗口到首页窗口
        [self settingUpRootView];
        
        // 禁止加载回调地址
        return NO;
    }
    
    return YES;
}

- (void)accessTokenWithCode:(NSString *)code {
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/access_token?client_id=2901639269&client_secret=89550eca056151668be395b00544ab31&grant_type=authorization_code&redirect_uri=http://www.haifu.com.cn&code=%@",code];

    NSURL *URL = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod:@"POST"];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSDictionary *access_token = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        //保存access_token到偏好设置
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:access_token forKey:@"access_token"];
        [userDefault synchronize];//同步保存偏好设置
    }];
}


- (void)settingUpRootView {
    //    NSString *VersionKey = @"Bundle version";//这个是读不出版本号的
    //    NSString *VersionKey = @"CFBundleShortVersionString";//和CFBundleVersion到底什么区别
    NSString *VersionKey = @"CFBundleVersion";
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] valueForKey:VersionKey];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *keepVersion = [defaults objectForKey:VersionKey];
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    if ([currentVersion isEqualToString:keepVersion]) {
        LMTabBarController *LMweibo = [[LMTabBarController alloc] init];
        window.rootViewController = LMweibo;//设置root控制器为微博tabbar控制器
    }else {
        [defaults setObject:currentVersion forKey:VersionKey];//版本号不同就保存到沙盒（偏好设置）里
        [defaults synchronize];
        
        LMNewfeatureViewController *newfeatureVC = [[LMNewfeatureViewController alloc] init];
        window.rootViewController = newfeatureVC;//设置root控制器为新特性
    }
}


- (void)webViewDidStartLoad:(UIWebView *)webView {
//    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    NSLog(@"webViewDidFinishLoad");
}
          

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}

@end

