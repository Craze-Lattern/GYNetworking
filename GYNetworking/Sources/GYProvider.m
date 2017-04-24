//
//  GYProvider.m
//  GYNetworking
//
//  Created by 郭源 on 2017/4/22.
//  Copyright © 2017年 郭源. All rights reserved.
//

#import "GYProvider.h"
#import "GYCancellable.h"
#import "GYRequestTask.h"
#import "GYEndpoint.h"
#import "GYMultipartProvider.h"
#import "GYEndpoint+Internal.h"
#import "GYProvider+Internal.h"
#import "GYResult.h"

@interface GYProvider ()

@property (readonly, nonatomic, copy) EndpointBlock _endpointBlock;

@property (readonly, nonatomic, copy) RequestBlock _requestBlock;

@end

@implementation GYProvider

+ (instancetype)providerWithEndpoint:(EndpointBlock)endpointBlock
                             request:(RequestBlock)requestBlock
                             manager:(Manager *)manager {
    return [[self alloc] initWithEndpoint:endpointBlock
                                  request:requestBlock
                                  manager:manager];
}

- (instancetype)initWithEndpoint:(EndpointBlock)endpointBlock
                         request:(RequestBlock)requestBlock
                         manager:(Manager *)manager {
    if (self = [super init]) {
        __endpointBlock = endpointBlock;
        __requestBlock = requestBlock;
        _manager = manager;
    }
    return self;
}

- (id<CancellableInterface>)requestWithTarget:(id<GYTargetInterface>)target
                                   completion:(GYCompletionBlock)completion {
    return [self requestWithTarget:target progress:nil completion:completion];
}

- (id<CancellableInterface>)requestWithTarget:(id<GYTargetInterface>)target
                                     progress:(GYProgressBlock)progress
                                   completion:(GYCompletionBlock)completion {
    return [self requestWithTarget:target progress:progress completion:completion inQueue:nil];
}

- (id<CancellableInterface>)requestWithTarget:(id<GYTargetInterface>)target
                                     progress:(GYProgressBlock)progress
                                   completion:(GYCompletionBlock)completion
                                      inQueue:(dispatch_queue_t)queue {
    
    GYEndpoint *endpoint = self._endpointBlock(target);
    
    if (target.task.type == GYTaskUploadFormData) {
        [endpoint appendMultipartForms:((GYUploadFormDataTask *)target.task).formDatas];
    }
    
    __block GYCancellable *cancellable = nil;
    
    __weak typeof(self) weakSelf = self;
    RequestResultBlock requestResult = ^(GYResult<NSURLRequest *> *result) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (result.value) {
            cancellable = [strongSelf sendRequest:result.value
                                           target:target
                                         progress:progress
                                       completion:completion
                                          inQueue:queue];
        }else {
            completion([GYResult resultWithError:result.error]);
        }
    };
    
    self._requestBlock(endpoint, requestResult);
    
    return cancellable;
}

@end
