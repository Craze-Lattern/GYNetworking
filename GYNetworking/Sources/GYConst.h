//
//  GYConst.h
//  GYNetworking
//
//  Created by 郭源 on 2017/4/22.
//  Copyright © 2017年 郭源. All rights reserved.
//

#ifndef GYConst_h
#define GYConst_h

#import <AFNetworking.h>

typedef NSDictionary<NSString *, id> GYParameters;

typedef NSDictionary<NSString *, NSString *> GYHttpHeaderFields;

typedef NS_ENUM(NSUInteger, GYHTTPMethodType) {
    GYHTTPMethodGET     = 0,
    GYHTTPMethodPOST    = 1,
    GYHTTPMethodHEAD    = 2,
    GYHTTPMethodDELETE  = 3,
    GYHTTPMethodPUT     = 4,
    GYHTTPMethodPATCH   = 5,
};

typedef NS_ENUM(NSUInteger, GYRequestSerializerType) {
    GYRequestSerializerHTTP     = 0,
    GYRequestSerializerJSON     = 1,
    GYRequestSerializerPlist    = 2,
};

//typedef NS_ENUM(NSUInteger, GYResponseSerializerType) {
//    GYResponseSerializerHTTP    = 0,
//    GYResponseSerializerJSON    = 1,
//    GYResponseSerializerPlist   = 2,
//    GYResponseSerializerXML     = 3,
//};

NS_ASSUME_NONNULL_BEGIN

@class GYRequestTask;

@protocol GYTargetInterface <NSObject>

@property (readonly, nonatomic, strong) NSURL *baseURL;

@property (readonly, nonatomic, copy) NSString *path;

@property (readonly, nonatomic, assign) GYHTTPMethodType method;

@property (nullable, readonly, nonatomic, strong) GYParameters *parameters;

@property (readonly, nonatomic, assign) GYRequestSerializerType requestSerializer;

//@property (readonly, nonatomic, assign) GYResponseSerializerType responseSerializer;

@property (readonly, nonatomic, strong) GYRequestTask *task;

@end

@protocol CancellableInterface <NSObject>

@property (readonly, nonatomic, assign) BOOL isCancelled;

- (void)cancel;

@end

NS_ASSUME_NONNULL_END

#endif /* GYConst_h */
