//
//  TWKWebViewController.m
//  tIdentifiy_Example
//
//  Created by sysw1n on 2020/2/14.
//  Copyright © 2020 catqbt. All rights reserved.
//

#import "TWKWebViewController.h"
#import <WebKit/WebKit.h>
#import <TNLiveDetect/TNLiveDetectManager.h>

@interface TWKWebViewController ()<WKUIDelegate, WKNavigationDelegate>
@property(nonatomic, strong) WKWebView * webView;
@property (nonatomic, assign) NSInteger type;
@end

@implementation TWKWebViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    NSURL * htmlURL = [NSURL URLWithString:@"http://t200renzheng.zhengtoon.com/open/m/login/goUserLogin?client_id=789&redirect_uri=http://t200renzheng.zhengtoon.com/inner/basicInfo?isH5=true&response_type=code&scope=user_info&state="];
    NSURL *htmlURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"livedetect" ofType:@"html"]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:htmlURL]];
    [self.view addSubview:self.webView];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSURL *URL = navigationAction.request.URL;
    
    if ([[TNLiveDetectManager sharedInstance] canHandle:URL]) {
        [[TNLiveDetectManager sharedInstance] faceLiveDetect:URL webView:webView navigationController:self.navigationController errorHandler:^(NSInteger code) {
//            [[TNLiveDetectManager sharedInstance] retryFaceLiveDetect];
        }];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - WKUIDelegate
- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    return nil;
}

//- (void)webViewDidClose:(WKWebView *)webView{
//
//}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:webView.title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", @"确定")
                                                 style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction* action)
                         {
                             completionHandler();
                             [alert dismissViewControllerAnimated:YES completion:nil];
                         }];
    
    [alert addAction:ok];
    
    UIViewController* rootController = [UIApplication sharedApplication].delegate.window.rootViewController;
    
    [rootController presentViewController:alert animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:webView.title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", @"确定")
                                                 style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction* action)
                         {
                             completionHandler(YES);
                             [alert dismissViewControllerAnimated:YES completion:nil];
                         }];
    
    [alert addAction:ok];
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", @"取消")
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction* action)
                             {
                                 completionHandler(NO);
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                             }];
    [alert addAction:cancel];
    
    UIViewController* rootController = [UIApplication sharedApplication].delegate.window.rootViewController;
    
    [rootController presentViewController:alert animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:webView.title
                                                                   message:prompt
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", @"确定")
                                                 style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction* action)
                         {
                             completionHandler(((UITextField*)alert.textFields[0]).text);
                             [alert dismissViewControllerAnimated:YES completion:nil];
                         }];
    
    [alert addAction:ok];
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", @"取消")
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction* action)
                             {
                                 completionHandler(nil);
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                             }];
    [alert addAction:cancel];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField* textField) {
        textField.text = defaultText;
    }];
    
    UIViewController* rootController = [UIApplication sharedApplication].delegate.window.rootViewController;
    
    [rootController presentViewController:alert animated:YES completion:nil];
}

#if TARGET_OS_IPHONE
- (BOOL)webView:(WKWebView *)webView shouldPreviewElement:(WKPreviewElementInfo *)elementInfo{
    return NO;
}

- (nullable UIViewController *)webView:(WKWebView *)webView previewingViewControllerForElement:(WKPreviewElementInfo *)elementInfo defaultActions:(NSArray<id <WKPreviewActionItem>> *)previewActions{
    return nil;
}

//- (void)webView:(WKWebView *)webView commitPreviewingViewController:(UIViewController *)previewingViewController{
//}
#endif

#pragma mark - Getters && Setters

- (WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:[self getWebViewConfiguration]];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _webView.allowsBackForwardNavigationGestures = YES;
    }
    return _webView;
}

- (WKWebViewConfiguration *)getWebViewConfiguration{
    WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc] init];
    
    WKPreferences * preferences = [[WKPreferences alloc] init];
    preferences.javaScriptEnabled = YES;
    
    return config;
}

@end
