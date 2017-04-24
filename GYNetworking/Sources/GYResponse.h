//
//  GYResponse.h
//  GYNetworking
//
//  Created by 郭源 on 2017/4/22.
//  Copyright © 2017年 郭源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GYConst.h"

NS_ASSUME_NONNULL_BEGIN

@class GYResult<ObjectType>;

@interface GYResponse : NSObject

+ (instancetype)responseWithStatusCode:(NSInteger)statusCode
                        responseObject:(id)responseObject
                               request:(nullable NSURLRequest *)request
                              response:(nullable NSURLResponse *)response;

@property (readonly, nonatomic, assign) NSInteger statusCode;

@property (readonly, nonatomic, strong) id responseObject;

@property (nullable, readonly, nonatomic, strong) NSURLRequest *request;

@property (nullable, readonly, nonatomic, strong) NSURLResponse *response;

- (BOOL)isEqualToResponse:(GYResponse *)response;

@end

@interface GYResponse (Extension)

- (GYResponse *)filterWithStatusCodes:(NSRange)range error:(NSError * _Nullable __autoreleasing *)error;

- (GYResponse *)filterWithStatusCode:(NSInteger)statusCode error:(NSError * _Nullable __autoreleasing *)error;

- (GYResponse *)filterSuccessfulStatusCodesWithError:(NSError * _Nullable __autoreleasing *)error;

- (GYResponse *)filterSuccessfulStatusAndRedirectCodesWithError:(NSError * _Nullable __autoreleasing *)error;

@end

FOUNDATION_EXPORT NSString * const GYResponseStatusCodeErrorDomain;

@interface GYProgressResponse : NSObject

+ (instancetype)responseWithProgress:(nullable NSProgress *)progress response:(nullable GYResponse *)response;

@property (nullable, readonly, nonatomic, strong) GYResponse *response;

@property (nullable, readonly, nonatomic, strong) NSProgress *progressObj;

@property (readonly, nonatomic, assign) double progress;

@property (readonly, nonatomic, assign) BOOL completed;

@end

NS_ASSUME_NONNULL_END
