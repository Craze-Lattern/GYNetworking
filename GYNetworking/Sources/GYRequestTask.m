//
//  GYRequestTask.m
//  GYNetworking
//
//  Created by 郭源 on 2017/4/23.
//  Copyright © 2017年 郭源. All rights reserved.
//

#import "GYRequestTask.h"

@implementation GYRequestTask

- (GYTaskType)type {
    return GYTaskRequest;
}

@end

@implementation GYUploadFileTask

+ (instancetype)taskWithFileURL:(NSURL *)url {
    return [[self alloc] initWithFileURL:url];
}

- (instancetype)initWithFileURL:(NSURL *)url {
    if (self = [super init]) {
        _url = url;
    }
    return self;
}

- (GYTaskType)type {
    return GYTaskUploadFile;
}

@end

@implementation GYUploadFormDataTask

+ (instancetype)taskWithMultiparFormDatas:(NSArray<GYMultipartProvider *> *)formDatas {
    return [[self alloc] initWithMultiparFormDatas:formDatas];
}

- (instancetype)initWithMultiparFormDatas:(NSArray<GYMultipartProvider *> *)formDatas {
    if (self = [super init]) {
        _formDatas = formDatas;
    }
    return self;
}

- (GYTaskType)type {
    return GYTaskUploadFormData;
}

@end

@implementation GYDownloadTask

+ (instancetype)taskWithDestination:(GYDownloadDestinationBlock)destination options:(GYDownloadOptions)options {
    return [[self alloc] initWithDestination:destination options:options];
}

- (instancetype)initWithDestination:(GYDownloadDestinationBlock)destination options:(GYDownloadOptions)options {
    if (self = [super init]) {
        _destination = destination;
        _options = options;
    }
    return self;
}

- (GYTaskType)type {
    return GYTaskDownload;
}

@end
