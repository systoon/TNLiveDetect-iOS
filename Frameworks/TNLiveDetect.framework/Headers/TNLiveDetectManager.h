//
//  TNLiveDetectManager.h
//  TNLiveDetect
//
//  Created by sysw1n on 2020/8/12.
//  Copyright © 2020 flyBird001. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

typedef void(^TNLDErrorHandlerBlock)(NSInteger code);

NS_ASSUME_NONNULL_BEGIN

@interface TNLiveDetectManager : NSObject

+ (instancetype)sharedInstance;

- (BOOL)canHandle:(NSURL *)url;

- (void)faceLiveDetect:(NSURL *)url webView:(WKWebView*)webView navigationController:(UINavigationController *)navigationController errorHandler:(TNLDErrorHandlerBlock)handler;

- (void)retryFaceLiveDetect;

@end

NS_ASSUME_NONNULL_END
