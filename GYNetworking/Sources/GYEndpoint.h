//
//  GYEndpoint.h
//  GYNetworking
//
//  Created by 郭源 on 2017/4/22.
//  Copyright © 2017年 郭源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GYConst.h"

NS_ASSUME_NONNULL_BEGIN

@class GYMultipartProvider, GYResult<ObjectType>;

@interface GYEndpoint : NSObject

+ (instancetype)endpointWithURL:(NSString *)url
                         method:(GYHTTPMethodType)method
                     parameters:(nullable GYParameters *)parameters
              requestSerializer:(GYRequestSerializerType)requestSerializer
               httpHeaderFields:(nullable GYHttpHeaderFields *)httpHeaderFields;

@property (readonly, nonatomic, copy) NSString *url;

@property (readonly, nonatomic, assign) GYHTTPMethodType method;

@property (nullable, readonly, nonatomic, strong) GYParameters *parameters;

@property (readonly, nonatomic, assign) GYRequestSerializerType requestSerializer;

@property (nullable, readonly, nonatomic, strong) GYHttpHeaderFields *httpHeaderFields;

@property (readonly, nonatomic, strong) GYResult<NSURLRequest *> *urlRequest;

- (GYEndpoint *)addNewParameters:(nullable GYParameters *)newParameters;

- (GYEndpoint *)addNewRequestSerializer:(GYRequestSerializerType)newRequestSerializer;

- (GYEndpoint *)addNewHttpHeaderFields:(nullable GYHttpHeaderFields *)newHttpHeaderFields;

@end

NS_ASSUME_NONNULL_END
