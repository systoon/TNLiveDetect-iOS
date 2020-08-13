//
//  TWebViewController.m
//  tIdentifiy_Example
//
//  Created by sysw1n on 2020/2/14.
//  Copyright © 2020 catqbt. All rights reserved.
//

#import "TWebViewController.h"
#import <TNLiveDetect/TNLiveDetectManager.h>

@interface TWebViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, assign) NSInteger type;
@end


@implementation TWebViewController

#pragma mark - Life Cycle

- (void)viewDidLoad{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSURL * htmlURL = [NSURL URLWithString:@"http://t200renzheng.zhengtoon.com/open/m/login/goUserLogin?client_id=789&redirect_uri=http://t200renzheng.zhengtoon.com/inner/basicInfo?isH5=true&response_type=code&scope=user_info&state="];
    NSURLRequest * request = [NSURLRequest requestWithURL:htmlURL];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSURL * URL = request.URL;
    NSString *scheme = [URL scheme];
    if ([scheme isEqualToString:@"uias"]) {
        [[TNLiveDetectManager sharedInstance] faceLiveDetect:URL webView:webView navigationController:self.navigationController errorHandler:nil];
    }
    return YES;
}

#pragma mark - Getters && Setters
- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
        _webView.delegate = self;
    }
    return _webView;
}

@end
