//
//  GYCancellable.h
//  GYNetworking
//
//  Created by 郭源 on 2017/4/22.
//  Copyright © 2017年 郭源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GYConst.h"

NS_ASSUME_NONNULL_BEGIN

@interface GYCancellable : NSObject<CancellableInterface>

+ (instancetype)cancellableWithTask:(nullable NSURLSessionTask *)task;

@end

NS_ASSUME_NONNULL_END
