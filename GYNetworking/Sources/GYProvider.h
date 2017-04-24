//
//  GYProvider.h
//  GYNetworking
//
//  Created by 郭源 on 2017/4/22.
//  Copyright © 2017年 郭源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GYConst.h"

NS_ASSUME_NONNULL_BEGIN

@class GYResponse, GYProgressResponse, GYEndpoint, GYResult<ObjectType>;

@protocol CancellableInterface, GYTargetInterface;

typedef AFURLSessionManager Manager;

typedef void(^GYCompletionBlock)(GYResult<GYResponse *> *);

typedef void(^GYProgressBlock)(GYProgressResponse *);

typedef GYEndpoint *_Nonnull(^EndpointBlock)(id<GYTargetInterface>);

typedef void(^RequestResultBlock)(GYResult<NSURLRequest *> *);

typedef void(^RequestBlock)(GYEndpoint *, RequestResultBlock);

@interface GYProvider : NSObject

+ (instancetype)providerWithEndpoint:(EndpointBlock)endpointBlock
                             request:(RequestBlock)requestBlock
                             manager:(Manager *)manager;

@property (readonly, nonatomic, strong) Manager *manager;

- (id<CancellableInterface>)requestWithTarget:(id<GYTargetInterface>)target
                                   completion:(GYCompletionBlock)completion;

- (id<CancellableInterface>)requestWithTarget:(id<GYTargetInterface>)target
                                     progress:(nullable GYProgressBlock)progress
                                   completion:(GYCompletionBlock)completion;

- (id<CancellableInterface>)requestWithTarget:(id<GYTargetInterface>)target
                                     progress:(nullable GYProgressBlock)progress
                                   completion:(GYCompletionBlock)completion
                                      inQueue:(nullable dispatch_queue_t)queue;

@end

NS_ASSUME_NONNULL_END
