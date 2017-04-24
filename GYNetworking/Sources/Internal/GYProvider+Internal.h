//
//  GYProvider+Internal.h
//  GYNetworking
//
//  Created by 郭源 on 2017/4/24.
//  Copyright © 2017年 郭源. All rights reserved.
//

#import "GYProvider.h"

NS_ASSUME_NONNULL_BEGIN

@interface GYProvider (Internal)

- (id<CancellableInterface>)sendRequest:(NSURLRequest *)request
                                 target:(id<GYTargetInterface>)target
                               progress:(nullable GYProgressBlock)progress
                             completion:(GYCompletionBlock)completion
                                inQueue:(nullable dispatch_queue_t)queue;

@end

NS_ASSUME_NONNULL_END
