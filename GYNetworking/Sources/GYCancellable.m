//
//  GYRequestCancellable.m
//  GYNetworking
//
//  Created by 郭源 on 2017/4/22.
//  Copyright © 2017年 郭源. All rights reserved.
//

#import "GYCancellable.h"

#define GYLock() dispatch_semaphore_wait(self->_lock, DISPATCH_TIME_FOREVER)
#define GYUnLock() dispatch_semaphore_signal(self->_lock)

@interface GYCancellable ()

@property (nonatomic, assign) BOOL _privateIsCancelled;

@property (nullable, readonly, nonatomic, strong) NSURLSessionTask *_task;

@end

@implementation GYCancellable {
    dispatch_semaphore_t _lock;
}

+ (instancetype)cancellableWithTask:(NSURLSessionTask *)task {
    return [[self alloc] initWithTask:task];
}

- (instancetype)initWithTask:(NSURLSessionTask *)task {
    if (self = [super init]) {
        __task = task;
    }
    return self;
}

- (BOOL)isCancelled {
    return self._privateIsCancelled;
}

- (void)cancel {
    GYLock();
    [self._task cancel];
    self._privateIsCancelled = YES;
    GYUnLock();
}

@end
