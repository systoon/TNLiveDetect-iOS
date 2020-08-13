//
//  TNLiveDetectViewController.h
//  Toon
//
//  Created by sysw1n on 2017/12/8.
//  Copyright © 2017年 思源. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TNLiveDetectResult) {
    TNLiveDetectResultUnknownError = -100,
    TNLiveDetectResultUnauthorized = -2,
    TNLiveDetectResultfailed = -1, //人脸检测失败
    TNLiveDetectResultSuccess = 1, //人脸检测成功
    TNLiveDetectResultCancel,   //人脸检测取消
};

@protocol TNLiveDetectProtocal <NSObject>
- (void)faceLiveDetectResult:(TNLiveDetectResult)result imageData:(NSData *)bestFaceData;
@end

@interface TNLiveDetectViewController : UIViewController

@property(nonatomic,weak)id<TNLiveDetectProtocal>faceSDKDelegate;

@end
