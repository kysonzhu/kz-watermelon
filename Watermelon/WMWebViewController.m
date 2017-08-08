//
//  WMWebViewController.m
//  Watermelon
//
//  Created by zhujinhui on 2017/8/5.
//  Copyright © 2017年 kyson. All rights reserved.
//

#import "WMWebViewController.h"
#import "Watermelon.h"
#import "WMPackageManager.h"

#define K_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define K_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define K_STATESBAR_HEIGHT 20



@interface WMWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation WMWebViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modeSettedFinished) name:WatermelonNotificationModeSettingFinished object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.webView];
    
    
    [self loadWebViewRequest];

}

-(void) loadWebViewRequest {
    switch ([Watermelon shareInstance].currentBootMode) {
        case WMBootModeBasicModule: {
            NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            NSString *distPath = [documentDirectory stringByAppendingPathComponent:K_DEFAULT_PACKAGE_NAME];
            NSString *packageURLString = [distPath stringByAppendingFormat:@"/watermelon/index.html"];
            NSURL *watermelonURL = [NSURL fileURLWithPath:packageURLString];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:watermelonURL];
            [self.webView loadRequest:request];

            
        }
            break;
        case WMBootModeAllModule: {
            
        }
            break;
            
        default:
            break;
    }
}


-(void) modeSettedFinished {
    [self loadWebViewRequest];
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
