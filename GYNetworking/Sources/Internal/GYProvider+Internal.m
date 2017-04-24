//
//  GYProvider+Internal.m
//  GYNetworking
//
//  Created by 郭源 on 2017/4/24.
//  Copyright © 2017年 郭源. All rights reserved.
//

#import "GYProvider+Internal.h"
#import "GYCancellable.h"
#import "GYRequestTask.h"
#import "GYResponse.h"
#import "GYResult.h"

@implementation GYProvider (Internal)

- (id<CancellableInterface>)sendRequest:(NSURLRequest *)request
                                 target:(id<GYTargetInterface>)target
                               progress:(GYProgressBlock)progress
                             completion:(GYCompletionBlock)completion
                                inQueue:(nullable dispatch_queue_t)queue {
    void(^progressHandler)(NSProgress *) = nil;
    if (progress) {
        progressHandler = ^(NSProgress *p) {
            GYProgressResponse *progressResponse = [GYProgressResponse responseWithProgress:p response:nil];
            if (queue) {
                dispatch_async(queue, ^{
                    progress(progressResponse);
                });
            }else {
                progress(progressResponse);
            }
        };
    }
    
    void(^completionHandler)(NSURLResponse * _Nonnull , id  _Nullable, NSError * _Nullable) = nil;
    if (completion) {
        completionHandler = ^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error){
            
            GYResult<GYResponse *> *result = nil;
            if (error) {
                result = [GYResult resultWithError:error];
            }else {
                GYResponse *r = [GYResponse responseWithStatusCode:((NSHTTPURLResponse *)response).statusCode responseObject:responseObject request:request response:response responseSerializer:target.responseSerializer];
                if (progress) {
                    GYProgressResponse *pr = [GYProgressResponse responseWithProgress:nil response:r];
                    progress(pr);
                }
                result = [GYResult resultWithValue:r];
            }
            completion(result);
        };
    }
    
    switch (target.task.type) {
        case GYTaskRequest:
            return [self sendRequest:request
                   completionHandler:completionHandler];
        case GYTaskUploadFile:
            return [self sendUploadFileRequest:request
                                    uploadTask:(GYUploadFileTask *)target.task
                               progressHandler:progressHandler
                             completionHandler:completionHandler];
        case GYTaskUploadFormData:
            return [GYCancellable new];
        case GYTaskDownload:
            return [self sendDownloadRequest:request
                                downloadTask:(GYDownloadTask *)target.task
                             progressHandler:progressHandler
                           completionHandler:completionHandler];
    }
}

- (id<CancellableInterface>)sendRequest:(NSURLRequest *)request
                       completionHandler:(nullable void (^)(NSURLResponse *, id _Nullable,  NSError * _Nullable))completionHandler {
    
    NSURLSessionDataTask *task = nil;
    task = [self.manager dataTaskWithRequest:request
                           completionHandler:completionHandler];
    [task resume];
    
    return [GYCancellable cancellableWithTask:task];
}

- (id<CancellableInterface>)sendUploadFileRequest:(NSURLRequest *)request
                                        uploadTask:(GYUploadFileTask *)uploadTask
                                   progressHandler:(nullable void (^)(NSProgress *))progressHandler
                                 completionHandler:(nullable void (^)(NSURLResponse *, id _Nullable,  NSError * _Nullable))completionHandler {
    
    NSURLSessionDataTask *task = nil;
    task = [self.manager uploadTaskWithRequest:request
                                      fromFile:uploadTask.url
                                      progress:progressHandler
                             completionHandler:completionHandler];
    return [GYCancellable cancellableWithTask:task];
}

- (id<CancellableInterface>)sendDownloadRequest:(NSURLRequest *)request
                                    downloadTask:(GYDownloadTask *)downloadTask
                                 progressHandler:(nullable void (^)(NSProgress *))progressHandler
                               completionHandler:(nullable void (^)(NSURLResponse *, id _Nullable,  NSError * _Nullable))completionHandler {
    
    GYDownloadDestinationBlock destination = ^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *fileURL = downloadTask.destination(targetPath, response);
        switch (downloadTask.options) {
            case GYDownloadRemovePreviousFile:
                [NSFileManager.defaultManager removeItemAtURL:fileURL error:nil];
                break;
            case GYDownloadCreateIntermediateDirectories: {
                NSURL *directoryURL = [fileURL URLByDeletingLastPathComponent];
                [NSFileManager.defaultManager createDirectoryAtURL:directoryURL withIntermediateDirectories:YES attributes:nil error:nil];
                break;
            }
        }
        return fileURL;
    };
    
    NSURLSessionDownloadTask *task = nil;
    task = [self.manager downloadTaskWithRequest:request
                                        progress:progressHandler
                                     destination:destination
                               completionHandler:completionHandler];
    return [GYCancellable cancellableWithTask:task];
}

@end
