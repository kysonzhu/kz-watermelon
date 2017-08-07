//
//  WMWebViewController.m
//  Watermelon
//
//  Created by zhujinhui on 2017/8/5.
//  Copyright © 2017年 kyson. All rights reserved.
//

#import "WMWebViewController.h"

#define K_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define K_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define K_STATESBAR_HEIGHT 20



@interface WMWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation WMWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
//    NSURL *URL = [NSURL fileURLWithPath:htmlPath];
    NSURL *URL = [NSURL URLWithString:@"http://www.kyson.cn/demo/watermelon/"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    request.timeoutInterval = 3.f;
    self.webView.delegate = self;
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}





- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
}



- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}




-(UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, K_STATESBAR_HEIGHT, K_SCREEN_WIDTH, K_SCREEN_HEIGHT - K_STATESBAR_HEIGHT)];
        
    }
    
    return _webView;
}


@end
