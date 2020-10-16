//
//  TNLDQRCodeInputModel.h
//  TNLiveDetect
//
//  Created by fanhuibo on 2020/10/10.
//  Copyright © 2020 sysw1n. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TNLDQRCodeInputModel : NSObject

@property (nonatomic, assign)NSInteger hospitalCode;
@property (nonatomic, strong)NSString *cardNo;
@property (nonatomic, strong)NSString *cardType;
@property (nonatomic, strong)NSString *userName;
@property (nonatomic, assign)NSInteger effectiveTime;
@property (nonatomic, strong)NSString *deviceId;
@property (nonatomic, assign)NSInteger timestamp;
@property (nonatomic, strong)NSString *sign;

@end

NS_ASSUME_NONNULL_END
