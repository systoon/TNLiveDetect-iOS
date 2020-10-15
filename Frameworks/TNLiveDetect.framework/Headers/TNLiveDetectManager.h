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

@class TNLDQRCodeInputModel;

typedef void(^TNLDErrorHandlerBlock)(NSInteger code);
typedef void(^TNLDCommonBlock)(NSInteger code, NSDictionary * data);

NS_ASSUME_NONNULL_BEGIN

@interface TNLiveDetectManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong)NSString *deviceId;
@property (nonatomic, strong)NSString *serverAddress;

- (BOOL)canHandle:(NSURL *)url;

- (void)faceLiveDetect:(NSURL *)url webView:(WKWebView*)webView navigationController:(UINavigationController *)navigationController errorHandler:(TNLDErrorHandlerBlock)handler;

- (void)retryFaceLiveDetect;

- (void)signWithUid:(NSString *)uid raw:(NSString *)raw callback:(void(^)(NSString *sign, NSInteger code))callback;

- (void)qrCodeWithModel:(TNLDQRCodeInputModel *)model callback:(TNLDCommonBlock)callback;

@end

NS_ASSUME_NONNULL_END
