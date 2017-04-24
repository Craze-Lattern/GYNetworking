//
//  GYRequestTask.h
//  GYNetworking
//
//  Created by 郭源 on 2017/4/23.
//  Copyright © 2017年 郭源. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GYMultipartProvider;

typedef NS_ENUM(NSUInteger, GYTaskType) {
    GYTaskRequest           = 0,
    GYTaskUploadFile        = 1,
    GYTaskUploadFormData    = 2,
    GYTaskDownload          = 3,
};

@interface GYRequestTask : NSObject

@property (readonly, nonatomic, assign) GYTaskType type;

@end

@interface GYUploadFileTask : GYRequestTask

+ (instancetype)taskWithFileURL:(NSURL *)url;

@property (readonly, nonatomic, strong) NSURL *url;

@end

@interface GYUploadFormDataTask : GYRequestTask

+ (instancetype)taskWithMultiparFormDatas:(NSArray<GYMultipartProvider *> *)formDatas;

@property (nonatomic, strong) NSArray<GYMultipartProvider *> *formDatas;

@end

typedef NSURL * (^GYDownloadDestinationBlock)(NSURL *targetPath, NSURLResponse *response);

typedef NS_ENUM(NSUInteger, GYDownloadOptions) {
    GYDownloadCreateIntermediateDirectories = 0,
    GYDownloadRemovePreviousFile            = 1,
};

@interface GYDownloadTask : GYRequestTask

+ (instancetype)taskWithDestination:(GYDownloadDestinationBlock)destination options:(GYDownloadOptions)options;

@property (readonly, nonatomic, assign) GYDownloadOptions options;

@property (readonly, nonatomic, copy) GYDownloadDestinationBlock destination;

@end
